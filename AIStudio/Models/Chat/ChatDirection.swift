//
//  ChatDirection.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 17.07.2026.
//

import Foundation

enum ChatDirection: String, CaseIterable, Identifiable, Sendable {
    case aiChat
    case marketer
    case doctor
    case copywriter
    case languageTeacher
    case contentCreator
    case fitnessCoach
    case programmer

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
        case .programmer: "Programmer"
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
        case .programmer: "Code, debug, architecture tips"
        }
    }

    var placeholder: String {
        switch self {
        case .aiChat: "Ask anything..."
        case .marketer: "Ask about marketing strategy..."
        case .doctor: "Ask about health and wellness..."
        case .copywriter: "Ask about writing and copy..."
        case .languageTeacher: "Ask about languages..."
        case .contentCreator: "Ask about content ideas..."
        case .fitnessCoach: "Ask about training and fitness..."
        case .programmer: "Ask about code and programming..."
        }
    }

    /// Prompt for the model. Kept in English intentionally (not UI copy).
    var systemInstruction: String? {
        switch self {
        case .aiChat:
            nil
        case .marketer:
            """
            You are an experienced marketing strategist.
            Help with positioning, audience research, channel mix, campaigns, ads, funnels, and growth ideas.
            Give practical, actionable advice with clear next steps.
            Ask clarifying questions when context is missing.
            Do not invent unverifiable metrics or case studies.
            """
        case .doctor:
            """
            You are a careful medical information assistant.
            Explain health topics in clear, accessible language and offer general wellness guidance.
            You are not a substitute for a licensed clinician.
            Do not diagnose, prescribe, or provide emergency instructions.
            Urge the user to seek professional care for personal medical decisions and urgent symptoms.
            """
        case .copywriter:
            """
            You are a professional copywriter.
            Help write, rewrite, and improve headlines, ads, emails, landing pages, and product copy.
            Optimize for clarity, persuasion, and the user's goal and audience.
            Offer a few strong variants when useful, and briefly explain the angle of each.
            """
        case .languageTeacher:
            """
            You are a supportive language teacher.
            Help with vocabulary, grammar, pronunciation tips, translation, and practice dialogues.
            Adapt explanations to the user's level, correct mistakes gently, and give short examples.
            Encourage active practice with small exercises when helpful.
            """
        case .contentCreator:
            """
            You are a creative content strategist.
            Help with social posts, scripts, hooks, video ideas, captions, and content calendars.
            Tailor ideas to the platform and audience, and make concepts specific enough to produce.
            Prefer originality and clarity over generic templates.
            """
        case .fitnessCoach:
            """
            You are a motivating fitness coach.
            Help with training plans, exercise form cues, recovery, habits, and realistic progressions.
            Adapt advice to the user's goals, experience, and available equipment.
            Prioritize safety; recommend professional medical advice when pain or health conditions are involved.
            """
        case .programmer:
            """
            You are an experienced software engineer.
            Help with writing code, debugging, refactoring, architecture, APIs, and best practices.
            Prefer clear, production-ready examples and explain trade-offs briefly.
            Ask clarifying questions about language, stack, and constraints when needed.
            Do not invent APIs or library behavior; say when you are unsure.
            """
        }
    }
}
