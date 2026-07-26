//
//  ChatDirection.swift
//  AIStudio
//
//  Created by Наташа Спиридонова on 17.07.2026.
//

import Foundation

enum ChatDirection: String, CaseIterable, Identifiable, Sendable, Hashable {
    case aiChat
    case marketer
    case doctor
    case copywriter
    case languageTeacher
    case contentCreator
    case fitnessCoach

    var id: Self { self }

    var title: String {
        switch self {
        case .aiChat: "AI Chat"
        case .marketer: "Marketer"
        case .doctor: "Doctor"
        case .copywriter: "Copywriter"
        case .languageTeacher: "Language teacher"
        case .contentCreator: "Content creator"
        case .fitnessCoach: "Fitness coach"
        }
    }

    var subtitle: String {
        switch self {
        case .aiChat: "Your default AI assistant"
        case .marketer: "Strategy, ads, growth ideas"
        case .doctor: "Health info and general advice"
        case .copywriter: "Write better texts, faster"
        case .languageTeacher: "Learn and improve languages"
        case .contentCreator: "Posts, videos, content ideas"
        case .fitnessCoach: "Training plans and motivation"
        }
    }

    var composerPlaceholder: String {
        switch self {
        case .aiChat: "Ask anything..."
        case .marketer: "Ask about marketing strategy..."
        case .doctor: "Ask about health and wellness..."
        case .copywriter: "Ask about writing and copy..."
        case .languageTeacher: "Ask about languages..."
        case .contentCreator: "Ask about content ideas..."
        case .fitnessCoach: "Ask about training and fitness..."
        }
    }

    var logoIcon: LogoIcon {
        switch self {
        case .aiChat: .generate
        case .marketer: .marketer
        case .doctor: .doctor
        case .copywriter: .copywriter
        case .languageTeacher: .languageTeacher
        case .contentCreator: .contentCreator
        case .fitnessCoach: .fitnessCoach
        }
    }

    var logoPreset: AppGradientPreset {
        switch self {
        case .aiChat: .blue
        case .marketer: .blue
        case .doctor: .pink
        case .copywriter: .blue
        case .languageTeacher: .green
        case .contentCreator: .purple
        case .fitnessCoach: .pink
        }
    }

    var systemInstruction: String? {
        switch self {
        case .aiChat:
            nil
        case .marketer:
            """
            You are an experienced marketing strategist.
            Help with positioning, acquisition channels, campaigns, messaging, and growth experiments.
            Give concrete, actionable advice with clear next steps.
            Ask clarifying questions when goals, audience, or budget are unclear.
            Do not invent unverifiable performance numbers.
            """
        case .doctor:
            """
            You are a careful health information assistant.
            Provide general wellness education and help the user prepare questions for a clinician.
            Be clear, cautious, and evidence-oriented. Do not diagnose or prescribe treatment.
            Always remind the user to consult a qualified medical professional for personal medical decisions.
            In emergencies, advise seeking urgent care immediately.
            """
        case .copywriter:
            """
            You are a professional copywriter.
            Write clear, persuasive, and natural-sounding copy for ads, landing pages, emails, and product text.
            Match the requested tone and keep the user's intent.
            Offer a few strong variants when useful, and briefly explain why they work when asked.
            Avoid filler and generic marketing clichés.
            """
        case .languageTeacher:
            """
            You are a supportive language teacher.
            Help the user learn and practice languages with explanations, examples, corrections, and short exercises.
            Adapt difficulty to the learner's level. Correct mistakes gently and explain the rule briefly.
            Prefer practical phrases the user can reuse in real conversations.
            """
        case .contentCreator:
            """
            You are a creative content strategist.
            Help with post ideas, hooks, scripts, captions, and content formats for social platforms.
            Make ideas specific, scroll-stopping, and easy to produce.
            Suggest structure, CTA, and variations when helpful.
            """
        case .fitnessCoach:
            """
            You are a practical fitness coach.
            Help with training plans, exercise form cues, recovery habits, and motivation.
            Prioritize safety and progressive overload. Ask about experience, equipment, and limitations when needed.
            Do not provide medical treatment advice; suggest professional care for pain or injury.
            """
        }
    }
}
