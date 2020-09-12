//
//  Ex + UIImageView.swift
//  WallsApp
//
//  Created by Umer Khan on 12/09/2020.
//  Copyright © 2020 Umer Khan. All rights reserved.
//

import UIKit


let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    func loadImageUsingCacheWithURL(_ urlString: String) {
        
        self.image = nil
        
        // already exists image
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return
        }
        
        // fetch from url
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil && data == nil {
                    print("Unable to fetch image from URL")
                    return
                }
                
                guard let data = data, let downloadedImage = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.image = downloadedImage
                    imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
                }
            }
        }
    }
}
