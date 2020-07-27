//
//  ImageLoadService.swift
//  Romato
//
//  Created by Jithin M on 22/07/20.
//  Copyright © 2020 Jithin M. All rights reserved.
//

import Foundation
import Combine
import UIKit

class ImageLoadService : ObservableObject {
    
    @Published var image : UIImage?
    var cancellable : AnyCancellable?
    
    init(url: URL) {
        load(imageFrom: url)
    }
    
    func load(imageFrom url: URL) {
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map {
                UIImage(data: $0.data)
            }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        self.cancellable?.cancel()
    }
    
}
