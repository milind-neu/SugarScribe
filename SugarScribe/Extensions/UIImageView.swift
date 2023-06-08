//
//  UIImageView.swift
//  SugarScribe
//
//  Created by Milind Sharma on 06/06/23.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    public func downloadImageWithCaching(with url: String, placeholderImage: UIImage? = nil) {
        if url == "" {
            self.image = placeholderImage
            return
        }
        guard let imageURL = URL.init(string: url) else {
            self.image = placeholderImage
            return
        }
        DispatchQueue.main.async {
            let resource = ImageResource(downloadURL: imageURL, cacheKey: imageURL.absoluteString)

            self.kf.setImage(with: resource, placeholder: placeholderImage, options: [.transition(.fade(0.1))], progressBlock: nil) { result in
                switch result {
                case .success(_):
                    break
                case .failure(_):
                    break
                }
            }
        }
        
    }
}
