//
//  SelectableText.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 12.07.2026.
//

import SwiftUI
import UIKit

/// Non-editable text with native iOS selection (double-tap / handles).
struct SelectableText: UIViewRepresentable {
    var attributedText: NSAttributedString
    var isSelectable = true
    /// When false, long-press stays with SwiftUI `contextMenu`; double-tap still selects.
    var allowsLongPressSelection = true

    init(
        _ text: String,
        style: Typography.Style = .regular16,
        color: Color,
        isSelectable: Bool = true,
        allowsLongPressSelection: Bool = true
    ) {
        self.attributedText = Typography.attributedString(text, style: style, color: color)
        self.isSelectable = isSelectable
        self.allowsLongPressSelection = allowsLongPressSelection
    }

    init(
        attributedText: NSAttributedString,
        isSelectable: Bool = true,
        allowsLongPressSelection: Bool = true
    ) {
        self.attributedText = attributedText
        self.isSelectable = isSelectable
        self.allowsLongPressSelection = allowsLongPressSelection
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> IntrinsicTextView {
        let view = IntrinsicTextView()
        view.backgroundColor = .clear
        view.isEditable = false
        view.isScrollEnabled = false
        view.isSelectable = isSelectable
        view.textContainerInset = .zero
        view.textContainer.lineFragmentPadding = 0
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
        view.setContentHuggingPriority(.required, for: .vertical)
        context.coordinator.configureLongPress(
            on: view,
            allowsLongPressSelection: allowsLongPressSelection
        )
        return view
    }

    func updateUIView(_ view: IntrinsicTextView, context: Context) {
        if view.attributedText != attributedText {
            view.attributedText = attributedText
            view.invalidateIntrinsicContentSize()
        }
        view.isSelectable = isSelectable
        context.coordinator.configureLongPress(
            on: view,
            allowsLongPressSelection: allowsLongPressSelection
        )
    }

    func sizeThatFits(
        _ proposal: ProposedViewSize,
        uiView: IntrinsicTextView,
        context: Context
    ) -> CGSize? {
        let width = proposal.width ?? UIScreen.main.bounds.width
        return uiView.sizeThatFits(
            CGSize(width: width, height: .greatestFiniteMagnitude)
        )
    }

    final class Coordinator {
        func configureLongPress(
            on textView: UITextView,
            allowsLongPressSelection: Bool
        ) {
            for recognizer in textView.gestureRecognizers ?? [] {
                guard let longPress = recognizer as? UILongPressGestureRecognizer else {
                    continue
                }
                longPress.isEnabled = allowsLongPressSelection
            }
        }
    }
}

final class IntrinsicTextView: UITextView {
    override var intrinsicContentSize: CGSize {
        let width = bounds.width > 0 ? bounds.width : UIScreen.main.bounds.width
        let size = sizeThatFits(
            CGSize(width: width, height: .greatestFiniteMagnitude)
        )
        return CGSize(width: UIView.noIntrinsicMetric, height: size.height)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        SelectableText(
            "Double-tap to select a word, then drag handles to expand.",
            color: .white
        )

        SelectableText(
            attributedText: Typography.emphasizedAttributedString(
                "Emphasis",
                suffix: "and the rest of the bullet stays regular.",
                color: .white.opacity(0.8)
            )
        )
    }
    .padding(24)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.background)
}
