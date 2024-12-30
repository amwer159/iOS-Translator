//
//  Language.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation

struct Language {
    let code: String
    let displayName: String
    
    static func defaultSource() -> Language {
        return Languages.english.toLanguage()
    }
    
    static func defaultTarget() -> Language {
        return Languages.spanish.toLanguage()
    }
}
