//
//  SampleViewControllers.swift
//  SpotLight_Example
//
//  Created by cookie on 2018/9/30.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SpotLight

class SampleMoveViewController: UIViewController {
    let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "sample.jpg"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    var spotView: SpotlightChain?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.frame = view.bounds
        
        let spot1 = Spotlight(frame: CGRect(origin: CGPoint(x: view.center.x - 50, y: 100), size: CGSize(width: 100, height: 100)), cornerRadius: 0)
        spotView = SpotlightChain(frame: view.bounds, spotlight: spot1, autoNext: false, completed: nil)
        view.addSubview(spotView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let spot2 = Spotlight(frame: CGRect(origin: CGPoint(x: view.center.x - 50, y: view.center.y + 200), size: CGSize(width: 100, height: 100)), cornerRadius: 0)
        spotView?.moveTo(spot2, duration: 4.0, completed: { [weak self] in
            UIView.animate(withDuration: 1.0, animations: {
                self?.spotView?.alpha = 0.0
            })
        }).start()
    }
}

class SampleScaleViewController: UIViewController {
    let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "sample.jpg"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    var spotView: SpotlightChain?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.frame = view.bounds
        
        let spot1 = Spotlight(frame: CGRect(origin: CGPoint(x: view.center.x - 25, y: view.center.y - 25), size: CGSize(width: 50, height: 50)), cornerRadius: 0)
        spotView = SpotlightChain(frame: view.bounds, spotlight: spot1, autoNext: false, completed: nil)
        view.addSubview(spotView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spotView?.scaleTo(4.0, duratoin: 4.0, completed: { [weak self] in
            UIView.animate(withDuration: 1.0, animations: {
                 self?.spotView?.alpha = 0.0
            })
        }).start()
    }
}

class SampleBreathViewController: UIViewController {
    let imageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "sample.jpg"))
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    var spotView: SpotlightChain?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.frame = view.bounds
        
        let spot1 = Spotlight(frame: CGRect(origin: CGPoint(x: view.center.x - 50, y: view.center.y - 50), size: CGSize(width: 100, height: 100)), cornerRadius: 50)
        spotView = SpotlightChain(frame: view.bounds, spotlight: spot1, autoNext: false, completed: nil)
        view.addSubview(spotView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spotView?.breath(minScale: 0.8, maxScale: 1.3, duration: 2.0, repeatCount: 4, completed: { [weak self] in
            UIView.animate(withDuration: 1.0, animations: {
                self?.spotView?.alpha = 0.0
            })
        }).start()
    }
}
