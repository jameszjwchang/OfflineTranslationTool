//
//  ContentView.swift
//  NLP2TeX
//
//  Created by James Chang on 12/8/24.
//

import SwiftUI
import Translation

struct ContentView: View {
    
    @AppStorage("onboardingComplete") var isOnboardingComplete: Bool = false
    
    @State private var sourceText = "Hello, world!" // Default to English for this example
    @State private var targetText = ""
    @State private var languages = [
        "ar", // Arabic
        "zh-cn", // Chinese (Simplified)
        "zh-tw", // Chinese (Traditional)
        "nl", // Dutch
        "en", // English (UK)
        "en-gb", // English (US)
        "fr", // French
        "de", // German
        "hi", // Hindi
        "id", // Indonesian
        "it", // Italian
        "ja", // Japanese
        "ko", // Korean
        "pl", // Polish
        "pt", // Portuguese (Brazil)
        "ru", // Russian
        "es", // Spanish (Spain)
        "th", // Thai
        "tr", // Turkish
        "uk", // Ukrainian
        "vi"  // Vietnamese
    ]

    // State variables for selected languages
    @State private var selectedSourceLanguage: String = "en" // Default source
    @State private var selectedTargetLanguage: String = "es" // Default target

    // Define a configuration.
    @State private var configuration: TranslationSession.Configuration?

    // Helper to get a display name for a language code (optional, but good for UI)
    private func languageDisplayName(for code: String) -> String {
        if code.isEmpty { return "Auto Detect" } // Handle empty string if you keep it
        let locale = Locale(identifier: code)
        return locale.localizedString(forLanguageCode: code) ?? code.uppercased()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Translate From:")
                    .font(.headline)
                Picker("Source Language", selection: $selectedSourceLanguage) {
                    ForEach(languages, id: \.self) { languageCode in
                        Text(languageDisplayName(for: languageCode)).tag(languageCode)
                    }
                }
                .pickerStyle(.menu) // Or .segmented for fewer options
                .labelsHidden()
            }
            
            HStack {
                Text("Translate To:")
                    .font(.headline)
                Picker("Target Language", selection: $selectedTargetLanguage) {
                    ForEach(languages.filter { $0 != selectedSourceLanguage }, id: \.self) { languageCode in // Prevent selecting same lang
                        Text(languageDisplayName(for: languageCode)).tag(languageCode)
                    }
                }
                .labelsHidden()
                .pickerStyle(.menu)
            }
            HStack {
                TextField("Enter text to translate", text: $sourceText, axis: .vertical)
                    .onSubmit {
                        triggerTranslation()
                    }
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(5...)
                
                Button("Translate") {
                    
                    triggerTranslation()
                }
                .buttonStyle(.borderedProminent)
                .disabled(sourceText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || selectedSourceLanguage == selectedTargetLanguage)
            }

            Divider()

            Text("Translation:")
                .font(.headline)
            ScrollView {
                Text(verbatim: targetText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .textSelection(.enabled)
            }
            .frame(minHeight: 100)
            .padding(.top, 5)

            Spacer() // Pushes content to the top
        }
        // Pass the configuration to the task.
        .translationTask(configuration) { session in
            do {
                // Use the session the task provides to translate the text.
                let response = try await session.translate(sourceText)

                // Update the view with the translated result.
                targetText = response.targetText
            } catch {
                // Handle any errors.
            }
        }
        .padding()
        .navigationTitle("Single String Translator")
        .onChange(of: selectedSourceLanguage) { // Optionally re-translate if source language changes
            if !sourceText.isEmpty {
                 // Invalidate current config to allow new one with new language
                configuration?.invalidate()
                configuration = nil
                triggerTranslation()
            }
        }
        .onChange(of: selectedTargetLanguage) { // Optionally re-translate if target language changes
            if !sourceText.isEmpty {
                // Invalidate current config to allow new one with new language
                configuration?.invalidate()
                configuration = nil
                triggerTranslation()
            }
        }
        .onAppear { // Set initial configuration based on default selected languages
             // Ensure different default languages if possible
            if selectedSourceLanguage == selectedTargetLanguage && languages.count > 1 {
                if let differentTarget = languages.first(where: { $0 != selectedSourceLanguage }) {
                    selectedTargetLanguage = differentTarget
                }
            }
        }
    }
    
    private func triggerTranslation() {
        guard configuration == nil else {
            configuration?.invalidate()
            return
        }

        configuration = TranslationSession.Configuration(
            source: .init(identifier: selectedSourceLanguage),
            target: .init(identifier: selectedTargetLanguage)
        )
        
    }
}

#Preview {
    ContentView()
}
