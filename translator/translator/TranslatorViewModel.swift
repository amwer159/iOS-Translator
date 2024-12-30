//
//  TranslatorViewModel.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation
import Combine

class TranslatorViewModel : ObservableObject {
    
    @Published var translationOutput: String = ""
    @Published var isLoading: Bool = false
    
    @Published var sourceLanguage: Language = Languages.english.toLanguage()
    @Published var targetLanguage: Language = Languages.spanish.toLanguage()
    
    private let translatorProvider: TranslatorProvider
    private let selectedLanguageRepository: SelectedLanguageRepository
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.translatorProvider = TranslatorProviderImpl.shared
        self.selectedLanguageRepository = SelectedLanguageRepositoryImpl.shared
        
        let sourcePublisher = selectedLanguageRepository.sourceLanguagePublisher
        let targetPublisher = selectedLanguageRepository.targetLanguagePublisher
        
        sourcePublisher
            .combineLatest(targetPublisher)
            .sink { (sourceLanguage, targetLanguage) in
                self.sourceLanguage = sourceLanguage
                self.targetLanguage = targetLanguage
            }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.clear()
    }
    
    func setSourceLanguage(source: Language) {
        selectedLanguageRepository.setSource(languageCode: source.code)
    }
    
    func setTargetLanguage(target: Language) {
        selectedLanguageRepository.setTarget(languageCode: target.code)
    }
    
    func translate(input: String) {
        isLoading = true
        Task {
            let result: Result<String, TranslationError> = await translatorProvider.translate(input: input)
            
            switch result {
            case .success(let translatedText):
                DispatchQueue.main.async {
                    self.translationOutput = translatedText.slice() ?? ""
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.translationOutput = "Error: \(error.localizedDescription)"
                }
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}

extension String {
    func slice(from: String = "---", to: String = "---") -> String? {
        guard let rangeFrom = range(of: from)?.upperBound else { return nil }
        guard let rangeTo = self[rangeFrom...].range(of: to)?.lowerBound else { return nil }
        return String(self[rangeFrom..<rangeTo].trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
