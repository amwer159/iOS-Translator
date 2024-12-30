//
//  TranslationResultView.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation
import SwiftUI

struct TranslationResultView: View {
    @Binding var isPresented: Bool
    
    let titleText: String
    let translationOutput: String
    let isLoading: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(titleText)
                .foregroundColor(.gray50)
                .font(.system(size: 16, weight: .medium))
            
            if isLoading {
                ProgressView()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray50)
            } else {
                Text(translationOutput)
                    .textSelection(.enabled)
                    .foregroundColor(.gray50)
                    .font(.system(size: 20, weight: .bold))
            }
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .topLeading)
        .background(.gray400) // Set background color to black
        .ignoresSafeArea()
        .presentationDetents([.fraction(0.3), .medium, .large]) // Customizable sheet height
    }
}

struct TranslatedTextSheet_Previews: PreviewProvider {
    static var previews: some View {
        TranslationResultView(
            isPresented: .constant(true), // Use a constant binding for preview
            titleText: "Ukrainian",
            translationOutput: "This is the translated text that will be displayed in the sheet. It can be as long as needed to test the layout.",
            isLoading: false
        )
        .previewLayout(.sizeThatFits) // Adjust the preview layout as needed
        .padding()
        .background(Color.black) // Ensure the background color matches the sheet's
    }
}
