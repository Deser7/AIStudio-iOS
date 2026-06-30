//
//  PaywallBenefit.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 30.06.2026.
//

import Foundation

enum PaywallBenefitIcon: String, CaseIterable {
    case generate
    case magicPencil
    case prompt
    case magic
}

struct PaywallBenefit: Identifiable, Equatable {
    let id: String
    let title: String
    let icon: PaywallBenefitIcon
}
