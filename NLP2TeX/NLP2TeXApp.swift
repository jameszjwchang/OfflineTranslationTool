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

    var body: some Scene {
//        WindowGroup {
//            SingleStringView()
//        }
        MenuBarExtra {
            ContentView()
                .overlay(alignment: .bottomTrailing) {
                    Button(
                        "Quit"
//                        ,
//                        systemImage: "xmark.circle.fill"
                    ) {
                        NSApp.terminate(nil)
                    }
//                    .labelStyle(.titleAndIcon)
//                    .buttonStyle(.plain)
                    .padding(6)
                }
        } label: {
            Label("MenuBarExtra", systemImage: "translate")
        }
        .defaultSize(width: 360, height: 300)
        .menuBarExtraStyle(.window)
    }
}

