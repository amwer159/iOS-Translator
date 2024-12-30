//
//  TranslatorProvider.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation
import ChatGPTSwift
//import MLKit

protocol TranslatorProvider {
    func initialize()
    
    func translate(input: String) async -> Result<String, TranslationError>
}

internal class TranslatorProviderImpl : TranslatorProvider {
    static let shared: TranslatorProvider = TranslatorProviderImpl(translationCompletionProvider: TranslationCompletionProviderImpl())
    
    private let translationCompletionProvider: TranslationCompletionProvider
    
    private let selectedLanguageRepository: SelectedLanguageRepository
    
    init(translationCompletionProvider: TranslationCompletionProvider) {
        self.translationCompletionProvider = TranslationCompletionProviderImpl()
        self.selectedLanguageRepository = SelectedLanguageRepositoryImpl.shared
    }
    
    private let api = ChatGPTAPI(apiKey: "")
    
//    private let translateOptions = TranslatorOptions(sourceLanguage: .english, targetLanguage: .ukrainian)
    
    func initialize() {
        
    }
    
    func translate(input: String) async -> Result<String, TranslationError> {
        print("viktor Request for translation, input=\(input)")
        do {
            let output = try await api.sendMessage(
                text: translationCompletionProvider.createUserText(
                    input: input,
                    sourceLanguage: selectedLanguageRepository.getSource().displayName,
                    targetLanguage: selectedLanguageRepository.getTarget().displayName
                ),
                model: .gpt_hyphen_4_hyphen_0314,
                systemText: translationCompletionProvider.createSystemText()
            )
            return .success(output)
        } catch {
            print(error.localizedDescription)
            return .failure(.apiError(error.localizedDescription))
        }
//        let translator = Translator.translator(options: TranslatorOptions(sourceLanguage: .english, targetLanguage: .ukrainian))
//
//        let conditions = ModelDownloadConditions(
//            allowsCellularAccess: true,
//            allowsBackgroundDownloading: true
//        )
//
//        translator.downloadModelIfNeeded(with: conditions) { error in
//            guard error == nil else {
//                print("viktor Error while model downloading, error\(error!.localizedDescription)")
//                return
//            }
//            // Model downloaded successfully. Okay to start translating.
//
//            translator.translate(text) { translatedText, error in
//                guard error == nil else {
//                    print("viktor Error while translating, error\(error!.localizedDescription)")
//                    return
//                }
//
//                guard translatedText == nil else {
//                    print("viktor Translated text is nill")
//                    return
//                }
//
//                // Translation succeeded.
//                print("viktor, translatedText=\(translatedText!)")
//            }
//        }
    }
}
