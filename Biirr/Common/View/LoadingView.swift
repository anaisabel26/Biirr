//
//  LoaderView.swift
//  Biirr
//
//  Created by Ana Márquez on 08/03/2021.
//

import UIKit

public enum GiftOptions: String {
    case colors = "beer_colors"
    case fill_black_bg = "loader"
    case cheers = "beer_loader"
    case fill = "preloader_gif"
}

public class LoadingView {
    
    private var overlayView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return v
    }()
    
    private var shadowView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .clear
        return v
    }()

    private var imageView : UIImageView = {
        let v = UIImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.contentMode = .scaleAspectFill
        return v
    }()
    
    class var shared: LoadingView {
        struct Static {
            static let instance: LoadingView = LoadingView()
        }
        return Static.instance
    }

    init() {
        
        overlayView.addSubview(shadowView)
        shadowView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            shadowView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor),
            shadowView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            shadowView.widthAnchor.constraint(equalTo: overlayView.widthAnchor, multiplier: 0.5),
            shadowView.heightAnchor.constraint(equalTo: overlayView.widthAnchor, multiplier: 0.4),
            
            imageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: shadowView.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: shadowView.leftAnchor),
        ])
    }

    public func showOverlay(gif: GiftOptions) {
        guard let vc = UIApplication.getTopViewController() else { return }
        
        vc.view.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: vc.view.topAnchor),
            
            overlayView.leftAnchor.constraint(equalTo: vc.view.leftAnchor),
            overlayView.rightAnchor.constraint(equalTo: vc.view.rightAnchor),
            overlayView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor),
        ])
        
        shadowView.applyShadow()
        
        imageView.loadGif(name: gif.rawValue)
        
        imageView.clipsToBounds = true
        imageView.roundCorners()
    }

    public func hideOverlayView(at seconds: Double = 2, completion: (() -> ())? = nil) {
        DispatchQueue.main.async {
            self.overlayView.delay(seconds) {
                self.overlayView.removeFromSuperview()
                completion?()
            }
        }
    }
}
