//
//  LanguageListPickerView.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation
import SwiftUI

struct LanguageListPickerView : View {
    
    private let isSource: Bool
    
    @StateObject
    private var viewModel: LanguageListPickerViewModel
    
    @Environment(\.presentationMode)
    private var presentationMode
    
    init(isSource: Bool) {
        self._viewModel = StateObject(wrappedValue: LanguageListPickerViewModel(isSource: isSource))
        self.isSource = isSource
    }
    
    var body: some View {
        List(viewModel.languages, id: \.code) { language in
            HStack {
                Text(language.displayName)
                    .padding()
                
                Spacer()
            }
            .contentShape(Rectangle())
            .background(language.code == viewModel.selectedLanguage?.code ? .purple50 : Color.clear)
            .listRowInsets(EdgeInsets())
            .onTapGesture {
                viewModel.setLanguage(code: language.code)
                presentationMode.wrappedValue.dismiss()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Languages")
                    .foregroundColor(.gray50)
                    .font(.system(size: 24) .weight(.bold))
            }
        }
        .background(.purple900)
    }
}
