//
//  TranslationError.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation

enum TranslationError : Error {
    case apiError(String)
    case unknownError
}
