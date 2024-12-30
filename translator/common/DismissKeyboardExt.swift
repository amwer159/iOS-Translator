//
//  DismissKeyboard.swift
//  translator
//
//  Created by Ilin, Viktor (Contractor) on 30/12/2024.
//

import SwiftUI

struct DismissKeyboard: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let tap = UITapGestureRecognizer(target: uiViewController.view, action: #selector(UIView.endEditing(_:)))
        uiViewController.view.addGestureRecognizer(tap)
    }
}
