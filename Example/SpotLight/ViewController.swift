//
//  ViewController.swift
//  SpotLight
//
//  Created by Cookiezby on 07/26/2018.
//  Copyright (c) 2018 Cookiezby. All rights reserved.
//

import UIKit
import SpotLight

class ViewController: UIViewController {
    private var backImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "mountain.jpg"))
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var testView: SpotlightView = {
        let spotlight  = Spotlight(frame: CGRect(x: 100, y: 100, width: 50, height: 50), cornerRadius: 25)
        let spotlight2 = Spotlight(frame: CGRect(x: 100, y: 200, width: 50, height: 50), cornerRadius: 25)
        let view = SpotlightView(frame: .zero, spotlight: spotlight, completed: nil)
        let animation = SpotlightMove(from: spotlight, to: spotlight2, duration: 2.0, animationCurve: .liner)
        let animation2 = SpotlightBreath(spot: spotlight, minScale: 0.9, maxScale: 1.1, duration: 1, repeatCount: 10)
        view.pushAnimation(animation2)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backImage)
        view.addSubview(testView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        testView.popAnimation()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backImage.frame = view.bounds
        testView.frame = view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
