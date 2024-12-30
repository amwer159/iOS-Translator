//
//  TranslatorView.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation
import SwiftUI

struct TranslatorView: View {
    @State private var inputText: String = ""
    @State private var navigateToDestination: Bool = false
    @State private var isSource: Bool = false
    @State private var showTranslatedTextSheet: Bool = false
    
    @FocusState private var isTextEditorFocused: Bool
    
    @StateObject private var viewModel = TranslatorViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                LanguagePickerView(
                    sourceLanguage: viewModel.sourceLanguage,
                    targetLanguage: viewModel.targetLanguage,
                    onSourceLanguageClick: { languageCode in
                        isSource = true
                        navigateToDestination = true
                    },
                    onSwapLanguagesClick: { sourceLanguage, targetLanguage in
                        viewModel.setSourceLanguage(source: sourceLanguage)
                        viewModel.setTargetLanguage(target: targetLanguage)
                    },
                    onTargetLanguageClick: { languageCode in
                        isSource = false
                        navigateToDestination = true
                    }
                )
                
                NavigationLink(
                    destination: LanguageListPickerView(isSource: isSource),
                    isActive: $navigateToDestination
                ) {
                    EmptyView() // Hidden view to trigger navigation
                }
                
                TranslatorEditorView(
                    inputText: $inputText,
                    titleText: viewModel.sourceLanguage.displayName
                ) {
                    viewModel.translate(input: inputText)
                    showTranslatedTextSheet = true // Show the bottom sheet after translation
                }
            }
            .padding(.vertical, 12)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Translator")
                        .foregroundColor(.gray50)
                        .font(.system(size: 24) .weight(.bold))
                }
            }
            .sheet(isPresented: $showTranslatedTextSheet) {
                TranslationResultView(
                    isPresented: $showTranslatedTextSheet,
                    titleText: viewModel.targetLanguage.displayName,
                    translationOutput: viewModel.translationOutput,
                    isLoading: viewModel.isLoading
                )
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.gray900)
        }
    }
}

#Preview {
    TranslatorView()
}
