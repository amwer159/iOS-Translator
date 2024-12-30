//
//  PrimaryButton.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import Foundation
import SwiftUI

struct PrimaryButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label(title, systemImage: "translate")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.purple200)
        }
        .padding(12)
        .background(
            .purple800,
            in: RoundedRectangle(cornerRadius: 12)
        )
    }
}
