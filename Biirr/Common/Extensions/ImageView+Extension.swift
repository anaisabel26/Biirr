//
//  ImageView+Extension.swift
//  Biirr
//
//  Created by Ana Márquez on 05/03/2021.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from url: URL, placeholder: UIImage, roundCorner: CGFloat = Size.largeCorner) {
        self.image = placeholder
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data, error == nil,
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                self?.clipsToBounds = true
                self?.contentMode = .scaleAspectFill
                self?.makeRoundedAndShadowed(cornerRadius: roundCorner)
            }
        }.resume()
    }
}
