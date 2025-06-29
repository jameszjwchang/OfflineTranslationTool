//
//  OnboardingView.swift
//  NLP2TeX
//
//  Created by James Chang on 6/28/25.
//


import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingComplete: Bool
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Header
                VStack(spacing: 15) {
                    Image(systemName: "translate")
                        .font(.system(size: 30))
                        .foregroundColor(.blue)
                    
                    Text("Welcome to Offline Translation Tool!")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Before you can start translating, you need to download the translation languages.")
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                }
                
                // Setup Steps
                VStack(alignment: .leading, spacing: 20) {
                    Text("Setup Required:")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    SetupStepView(
                        stepNumber: 1,
                        title: "Open System Settings",
                        description: "Click the Apple menu and select \"System Settings\""
                    )
                    
                    SetupStepView(
                        stepNumber: 2,
                        title: "Navigate to General",
                        description: "In the sidebar, click on \"General\""
                    )
                    
                    SetupStepView(
                        stepNumber: 3,
                        title: "Select Language & Region",
                        description: "Click on \"Language & Region\" in the General section"
                    )
                    
                    SetupStepView(
                        stepNumber: 4,
                        title: "Download Translation Languages",
                        description: "Click \"Translation Languages\" & download languages you plan to use"
                    )
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(16)
                
                // Important Note
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(.orange)
                        Text("Important")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    
                    Text("Only after downloading the translation languages can you properly use this menu bar app. The app will not function correctly without the necessary language translation files.")
                        .font(.callout)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(8)
                
//                Spacer()
                
                // Continue Button
                Button("I've Downloaded the Languages!") {
                    isOnboardingComplete = true
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .padding(30)
            .frame(maxWidth: 500)
        }
    }
}

struct SetupStepView: View {
    let stepNumber: Int
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // Step Number Circle
            Text("\(stepNumber)")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .background(Color.blue)
                .clipShape(Circle())
            
            // Step Content
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.medium)
                
                Text(description)
                    .font(.system(size: 10))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
    }
}

#Preview {
    OnboardingView(isOnboardingComplete: .constant(false))
}
