//
//  TextEditor.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation
import SwiftUI

struct TranslatorEditorView : View {
    @Binding
    var inputText: String
    
    @FocusState
    private var isTextEditorFocused: Bool
    
    let titleText: String
    
    var onSubmit: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(titleText)
                    .foregroundColor(.gray50)
                    .padding(.horizontal, 5)
                    .font(.system(size: 16, weight: .medium))
                
                Spacer()
                
                if (!inputText.isEmpty) {
                    Button("Clear") {
                        inputText = ""
                    }
                    .foregroundColor(.purple200)
                    .font(.system(size: 16, weight: .medium))
                    .buttonStyle(.automatic)
                }
            }
            
            ZStack(alignment: .topLeading) {
                if (inputText.isEmpty) {
                    Text("Enter yout text")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.gray300)
                }
                
                TextEditor(text: $inputText)
                    .frame(height: 200)
                    .scrollContentBackground(.hidden)
                    .foregroundColor(.gray50)
                    .font(.system(size: 24, weight: .bold))
                    .background(Color.gray700)
                    .submitLabel(.done)
                    .accentColor(.purple200)
                    .focused($isTextEditorFocused) // Focus modifier for keyboard control
                    .onSubmit {
                        onSubmit?()
                    }
                    .onAppear {
                        // Automatically show the keyboard when the view appears
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.isTextEditorFocused = true
                        }
                    }
            }
            
            HStack {
                Spacer()
                
                if (!inputText.isEmpty) {
                    PrimaryButton(title: "Translate", action: {
                        onSubmit?()
                    })
                }
            }
        }
        .padding()
        .background(Color.gray700)
        .cornerRadius(20)
        .padding()
    }
}

struct TranslatorEditorView_Previews: PreviewProvider {
    static var previews: some View {
        TranslatorEditorView(inputText: .constant("How are you?"), titleText: "English")
    }
}
