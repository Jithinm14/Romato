//
//  RTActivityIndicatorView.swift
//  Romato
//
//  Created by Jithin M on 28/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct RTActivityIndicator : UIViewRepresentable {
    
    typealias UIViewType = UIActivityIndicatorView
    @Binding var animate : Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .medium)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if animate {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
    
}

struct RTActivityIndicatorView : View {
    
    @Binding var shouldAnimate : Bool
    
    var body: some View {
        RTActivityIndicator(animate: $shouldAnimate)
    }
    
}
