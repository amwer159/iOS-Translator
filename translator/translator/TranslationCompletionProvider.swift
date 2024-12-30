//
//  TranslationCompletionPrivider.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation

protocol TranslationCompletionProvider {
    func createSystemText() -> String
    func createUserText(input: String, sourceLanguage: String, targetLanguage: String) -> String
}

internal class TranslationCompletionProviderImpl : TranslationCompletionProvider {
    
    private let systemText = "You are a professional translator. Wrap given translation in ---"
    
    func createSystemText() -> String {
        return systemText
    }
    
    func createUserText(input: String, sourceLanguage: String, targetLanguage: String) -> String {
        let userText = "Translate this input [\(input)] from \(sourceLanguage) to \(targetLanguage)"
        return userText
    }
}
