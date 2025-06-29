//
//  NLP2TeXApp.swift
//  NLP2TeX
//
//  Created by James Chang on 12/8/24.
//

import SwiftUI
import AppKit
//import KeyboardShortcuts
//import HotKey
//import MenuBarExtraAccess

//extension KeyboardShortcuts.Name {
//    static let bringToFront = Self("bringToFront")
//}

//let hotKey = HotKey(key: .r, modifiers: [.command, .option])

//var isMenuPresentedt: Bool = false

@main
struct YourApp: App {
    @AppStorage("onboardingComplete") var isOnboardingComplete: Bool = false

    var body: some Scene {
//        WindowGroup {
//            SingleStringView()
//        }
        MenuBarExtra {
            Group {
                if !isOnboardingComplete {
                    // Show onboarding view if not complete
                    OnboardingView(isOnboardingComplete: $isOnboardingComplete)
                }
                else {
                    ContentView()
                        .overlay(alignment: .bottomLeading) {
                            Button("Onboarding") {
                                // Handle settings action
                                isOnboardingComplete = false
                            }
                            .padding(6)
                        }
                        .overlay(alignment: .bottomTrailing) {
                            Button("Quit") {
                                NSApp.terminate(nil)
                            }
                            .padding(6)
                        }
                }
            }
        } label: {
            Label("MenuBarExtra", systemImage: "translate")
        }
        .defaultSize(width: 360, height: 300)
        .menuBarExtraStyle(.window)
    }
}

