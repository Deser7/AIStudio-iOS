//
//  ChatViewModel+Reveal.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 15.07.2026.
//

import Foundation

extension ChatViewModel {
    /// Block appearance (no typing): larger chunks + pause for fade.
    private static let revealTick: Duration = .milliseconds(420)
    private static let revealIdlePoll: Duration = .milliseconds(40)
    private static let revealMinCharactersPerBlock = 48
    private static let revealMaxCharactersPerBlock = 110

    func beginReveal(assistantID: UUID) {
        revealAssistantID = assistantID
        streamingAssistantID = assistantID
        revealPendingText = ""
        revealDisplayedText = ""
        revealStreamFinished = false
        startRevealLoopIfNeeded()
    }

    func enqueueReveal(_ delta: String) {
        revealPendingText += delta
        startRevealLoopIfNeeded()
    }

    func finishRevealAndPersist() async {
        revealStreamFinished = true
        await waitForRevealCatchUp()

        if let assistantID = revealAssistantID {
            revealDisplayedText = revealPendingText
            updateAssistant(id: assistantID, text: revealPendingText)
        }
        persist()
        resetRevealState()
    }

    func waitForRevealCatchUp() async {
        if revealDisplayedText.count >= revealPendingText.count {
            return
        }

        startRevealLoopIfNeeded()

        await withCheckedContinuation { continuation in
            if revealDisplayedText.count >= revealPendingText.count {
                continuation.resume()
                return
            }

            revealCompletionContinuation = continuation

            // Loop may have finished between the check and storing the continuation.
            if revealTask == nil, revealDisplayedText.count >= revealPendingText.count {
                revealCompletionContinuation = nil
                continuation.resume()
            }
        }
    }

    func startRevealLoopIfNeeded() {
        guard revealTask == nil else { return }

        revealTask = Task { [weak self] in
            await self?.runRevealLoop()
        }
    }

    func runRevealLoop() async {
        defer {
            revealTask = nil
            resumeRevealCompletionIfNeeded()
        }

        while !Task.isCancelled {
            let pending = revealPendingText
            let displayed = revealDisplayedText

            if displayed.count >= pending.count {
                if revealStreamFinished {
                    return
                }
                try? await Task.sleep(for: Self.revealIdlePoll)
                continue
            }

            guard let assistantID = revealAssistantID else { return }

            guard let next = Self.nextRevealText(
                displayed: displayed,
                full: pending,
                streamFinished: revealStreamFinished
            ) else {
                if revealStreamFinished {
                    return
                }
                try? await Task.sleep(for: Self.revealIdlePoll)
                continue
            }

            revealDisplayedText = next
            updateAssistant(id: assistantID, text: next)

            if next.count >= pending.count, revealStreamFinished {
                return
            }

            try? await Task.sleep(for: Self.revealTick)
        }
    }

    func resumeRevealCompletionIfNeeded() {
        guard revealStreamFinished,
              revealDisplayedText.count >= revealPendingText.count,
              let continuation = revealCompletionContinuation
        else { return }

        revealCompletionContinuation = nil
        continuation.resume()
    }

    func resetRevealState() {
        revealTask?.cancel()
        revealTask = nil
        revealPendingText = ""
        revealDisplayedText = ""
        revealAssistantID = nil
        streamingAssistantID = nil
        revealStreamFinished = false
        if let continuation = revealCompletionContinuation {
            revealCompletionContinuation = nil
            continuation.resume()
        }
    }

    /// Reveals sentence/clause-sized blocks only — never character typing.
    /// Returns `nil` when we should wait for more buffered text.
    private static func nextRevealText(
        displayed: String,
        full: String,
        streamFinished: Bool
    ) -> String? {
        guard displayed.count < full.count else { return full }

        let start = full.index(full.startIndex, offsetBy: displayed.count)
        let remaining = full[start...]

        if streamFinished {
            return full
        }

        if let sentenceEnd = firstSentenceEnd(in: remaining),
           full.distance(from: start, to: sentenceEnd) >= 1
        {
            return String(full[..<sentenceEnd])
        }

        let buffered = remaining.count
        let minimum = displayed.isEmpty ? 24 : revealMinCharactersPerBlock
        guard buffered >= minimum else {
            return nil
        }

        let hardLimit = min(buffered, revealMaxCharactersPerBlock)
        var index = full.index(start, offsetBy: hardLimit)

        // Prefer breaking on whitespace so blocks look natural.
        if index < full.endIndex, !full[index].isWhitespace {
            if let space = full[..<index].lastIndex(where: \.isWhitespace),
               space > start
            {
                index = full.index(after: space)
            }
        } else if index < full.endIndex, full[index].isWhitespace {
            while index < full.endIndex, full[index].isWhitespace {
                index = full.index(after: index)
            }
        }

        guard index > start else { return nil }
        return String(full[..<index])
    }

    private static func firstSentenceEnd(in text: Substring) -> String.Index? {
        var index = text.startIndex
        var seenContent = false

        while index < text.endIndex {
            let character = text[index]
            if !character.isWhitespace {
                seenContent = true
            }

            if seenContent, isSentenceTerminator(character) {
                var end = text.index(after: index)
                while end < text.endIndex, isSentenceTerminator(text[end]) {
                    end = text.index(after: end)
                }
                while end < text.endIndex, text[end].isWhitespace {
                    end = text.index(after: end)
                    break
                }
                return end
            }

            if character == "\n" {
                let end = text.index(after: index)
                if seenContent {
                    return end
                }
            }

            index = text.index(after: index)
        }

        return nil
    }

    private static func isSentenceTerminator(_ character: Character) -> Bool {
        character == "." || character == "!" || character == "?" || character == "…"
    }
}
