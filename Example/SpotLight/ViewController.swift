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
    
    private lazy var testView: SpotlightChainView = {
        let spotlight  = Spotlight(frame: CGRect(x: 100, y: 100, width: 50, height: 50), cornerRadius: 10)
        let view = SpotlightChainView(frame: self.view.bounds, spotlight: spotlight, backgroundColor: UIColor(white: 0.0, alpha: 0.5), autoNext: true, completed: nil)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backImage)
        view.addSubview(testView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        testView.moveTo(Spotlight(frame: CGRect(x: 100, y: 200, width: 50, height: 50), cornerRadius: 20), duration: 3)
                //.sleep(duration: 3)
                //.breath(minScale: 0.8, maxScale: 1.2, duration: 2, repeatCount: 2)
                .scaleTo(0.5, duratoin: 1).start()
                //.moveTo(Spotlight(frame: CGRect(x: 100, y: 100, width: 200, height: 50), cornerRadius: 17.5), duration: 2, completed: nil).start()
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
