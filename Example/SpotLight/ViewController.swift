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
        let spotlight  = Spotlight(frame: CGRect(x: 100, y: 100, width: 50, height: 50), duration: 0)
        let spotlight2 = Spotlight(frame: CGRect(x: 100, y: 200, width: 80, height: 80), duration: 2.0)
        let spotlight3 = Spotlight(frame: CGRect(x: 50, y: 200, width: 10, height: 10), duration: 0.5)
        let view = SpotlightView(frame: self.view.bounds, spotlight: spotlight, autoNext: true) {
            print("finish spot")
        }
        //view.addSpotlight(spotlight2)
        //view.addSpotlight(spotlight3)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backImage)
        view.addSubview(testView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        testView.breathTest()
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
