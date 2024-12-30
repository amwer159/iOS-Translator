//
//  Languages.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation

enum Languages: String, CaseIterable {
    case english = "en"        // English
    case mandarin = "zh"       // Mandarin Chinese
    case hindi = "hi"          // Hindi
    case spanish = "es"        // Spanish
    case french = "fr"         // French
    case arabic = "ar"         // Arabic
    case bengali = "bn"        // Bengali
    case portuguese = "pt"     // Portuguese
    case russian = "ru"        // Russian
    case japanese = "ja"       // Japanese
    case german = "de"         // German
    case korean = "ko"         // Korean
    case italian = "it"        // Italian
    case turkish = "tr"        // Turkish
    case vietnamese = "vi"     // Vietnamese
    case tamil = "ta"          // Tamil
    case ukrainian = "uk-UA"    // Ukrainian
    case urdu = "ur"           // Urdu
    case persian = "fa"        // Persian
    case swahili = "sw"        // Swahili
}

// Extension for getting localized name
extension Languages {
    /// Returns the localized struct of the language in the specified locale.
    /// - Parameter localeIdentifier: The identifier of the locale to use. Defaults to the current locale.
    func toLanguage(localeIdentifier: String = Locale.current.identifier) -> Language {
        return Language(
            code: self.rawValue,
            displayName: localizedName(localeIdentifier: localeIdentifier)
        )
    }
    
    /// Returns the localized name of the language in the specified locale.
    /// - Parameter localeIdentifier: The identifier of the locale to use. Defaults to the current locale.
    /// - Returns: The localized name of the language.
    private func localizedName(localeIdentifier: String = Locale.current.identifier) -> String {
        let locale = Locale(identifier: localeIdentifier)
        return locale.localizedString(forLanguageCode: self.rawValue) ?? self.rawValue
    }
}
