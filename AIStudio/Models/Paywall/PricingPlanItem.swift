//
//  PricingPlanItem.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 30.06.2026.
//

import Foundation

struct PricingPlanItem: Identifiable, Equatable {
    let id: String
    let periodLabel: String
    let price: String
    /// Discount as a fraction, e.g. `0.8` for 80%.
    let badgeDiscount: Double?
}
