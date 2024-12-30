//
//  SelectedLanguageRepository.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation
import Combine

protocol SelectedLanguageRepository {
    
    var sourceLanguagePublisher: AnyPublisher<Language, Never> { get }
    var targetLanguagePublisher: AnyPublisher<Language, Never> { get }
    
    func getSource() -> Language
    func getTarget() -> Language
    
    func setSource(languageCode: String)
    func setTarget(languageCode: String)
}

class SelectedLanguageRepositoryImpl : SelectedLanguageRepository {
    static let shared: SelectedLanguageRepository = SelectedLanguageRepositoryImpl()
    
    private let sourceSelectedLanguageKey = "selected_language_source"
    private let targetSelectedLanguageKey = "selected_language_target"
    
    private let userDefaults = UserDefaults.standard
    
    @Published
    private var selectedSourceLanguage: Language?
    
    @Published
    private var selectedTargetLanguage: Language?
    
    var sourceLanguagePublisher: AnyPublisher<Language, Never> {
        $selectedSourceLanguage
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    var targetLanguagePublisher: AnyPublisher<Language, Never> {
        $selectedTargetLanguage
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    init() {
        self.selectedSourceLanguage = getSource()
        self.selectedTargetLanguage = getTarget()
    }
    
    func getSource() -> Language {
        return getFromCode(code: userDefaults.string(forKey: sourceSelectedLanguageKey)) ?? Language.defaultSource()
    }
    
    func getTarget() -> Language {
        return getFromCode(code: userDefaults.string(forKey: targetSelectedLanguageKey)) ?? Language.defaultTarget()
    }
    
    func setSource(languageCode: String) {
        userDefaults.set(languageCode, forKey: sourceSelectedLanguageKey)
        selectedSourceLanguage = getFromCode(code: languageCode)
    }
    
    func setTarget(languageCode: String) {
        userDefaults.set(languageCode, forKey: targetSelectedLanguageKey)
        selectedTargetLanguage = getFromCode(code: languageCode)
    }
    
    private func getFromCode(code: String?) -> Language? {
        let language: Languages? = Languages.allCases.first(where: { $0.rawValue == code })
        return language?.toLanguage()
    }
}
