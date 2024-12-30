//
//  LanguageListPickerViewModel.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation
import Combine

class LanguageListPickerViewModel: ObservableObject {
    
    private let isSource: Bool
    
    private let repository = SelectedLanguageRepositoryImpl.shared
    
    @Published
    var languages: [Language] = []
    
    @Published
    var selectedLanguage: Language?
    
    private var cancellables = Set<AnyCancellable>()
    
    init(isSource: Bool) {
        self.isSource = isSource
        self.languages = getLanguageList()
        
        let publisher = isSource ? repository.sourceLanguagePublisher : repository.targetLanguagePublisher
        
        publisher
            .sink { language in
                self.selectedLanguage = language
            }
            .store(in: &cancellables)
    }
    
    deinit {
        cancellables.clear()
    }
    
    func setLanguage(code: String) {
        if (isSource) {
            repository.setSource(languageCode: code)
        } else {
            repository.setTarget(languageCode: code)
        }
    }
    
    private func getLanguageList() -> [Language] {
        var languageList: [Language] = []
        
        // Get localized names for the defined enum languages
        for language in Languages.allCases {
            languageList.append(language.toLanguage())
        }
        
        return languageList.sorted(by: { $0.code < $1.code })
    }
}
