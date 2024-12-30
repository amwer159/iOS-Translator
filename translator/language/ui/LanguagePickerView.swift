//
//  LanguagePickerView.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import SwiftUI

struct LanguagePickerView : View {
    let sourceLanguage: Language
    let targetLanguage: Language
    
    var onSourceLanguageClick: ((Language) -> Void)? = nil
    var onSwapLanguagesClick: ((Language, Language) -> Void)? = nil
    var onTargetLanguageClick: ((Language) -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 8) {
            Button(sourceLanguage.displayName) {
                onSourceLanguageClick?(sourceLanguage)
            }
            .buttonStyle(LanguagePickerButtonStyle())
            
            IconButton(iconName: "rectangle.2.swap", tint: .purple500) {
                onSwapLanguagesClick?(targetLanguage, sourceLanguage)
            }
            
            Button(targetLanguage.displayName) {
                onTargetLanguageClick?(targetLanguage)
            }
            .buttonStyle(LanguagePickerButtonStyle())
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

struct LanguagePicker_Previews: PreviewProvider {
    static var previews: some View {
        LanguagePickerView(sourceLanguage: Languages.english.toLanguage(), targetLanguage: Languages.spanish.toLanguage())
    }
}
