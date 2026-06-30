//
//  PaywallView.swift
//  AIStudio
//
//  Created by Андрей Спиридонов on 30.06.2026.
//

import SwiftUI

struct PaywallView: View {
    @StateObject private var viewModel: PaywallViewModel

    init(viewModel: PaywallViewModel = PaywallViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            StudioBackground()

            VStack {
                Spacer()

                VStack(spacing: 32) {
                    titleSection
                    benefitsSection
                    plansSection
                }
                .padding()

                BottomBar(
                    cancelText: viewModel.cancelText,
                    buttonTitle: viewModel.unlockButtonTitle,
                    onButtonTap: viewModel.unlockTapped,
                    onPrivacyTap: viewModel.privacyPolicyTapped,
                    onRestoreTap: viewModel.restorePurchasesTapped,
                    onTermsTap: viewModel.termsOfUseTapped
                )
            }

            closeButton
        }
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }

    private var titleSection: some View {
        Text(viewModel.title)
            .typography(style: .bold34)
            .foregroundStyle(.white)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
    }

    private var benefitsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(viewModel.benefits) { benefit in
                BenefitRow(
                    title: benefit.title,
                    style: .medium16,
                    icon: benefit.icon
                )
            }
        }
        .fixedSize(horizontal: true, vertical: false)
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private var plansSection: some View {
        PricingPlans(
            plans: viewModel.plans,
            selectedPlanID: $viewModel.selectedPlanID
        )
    }

    @ViewBuilder
    private var closeButton: some View {
        if viewModel.isCloseButtonVisible {
            Button(action: viewModel.closeTapped) {
                Image(systemName: "xmark")
                    .font(.system(size: 17, weight: .regular))
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
            }
            .buttonStyle(.plain)
            .opacity(0.7)
            .padding(.leading, 24)
            .padding(.top, 16)
            .transition(.opacity)
            .animation(.easeIn(duration: 0.3), value: viewModel.isCloseButtonVisible)
        }
    }
}

#Preview {
    PaywallView()
}
