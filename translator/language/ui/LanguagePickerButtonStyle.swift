//
//  LanguagePickerButtonStyle.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import SwiftUI

struct LanguagePickerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 24)
            .padding(.vertical, 12)
            .background(.gray700)
            .foregroundColor(.gray50)
            .font(.system(size: 16) .weight(.medium))
            .cornerRadius(100)
            .opacity(configuration.isPressed ? 0.8 : 1.0) // Add pressed effect
    }
}
