//
//  LazyImageView.swift
//  Romato
//
//  Created by Jithin M on 22/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import SwiftUI

struct LazyImageView: View {
    
    @ObservedObject private var imageLoader : ImageLoadService
    
    init(imageUrl: URL) {
        imageLoader = ImageLoadService(url: imageUrl)
    }
    
    var body: some View {
        Group {
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
            } else {
                Image(uiImage: LazyImageView.placeholder!)
            }
        }
    }
}

extension LazyImageView {
    static let placeholder = UIImage(named: "placeholder")
}

struct LazyImageView_Previews: PreviewProvider {
    static var previews: some View {
        LazyImageView(imageUrl: URL(string: "https://picsum.photos/200/300")!)
    }
}
