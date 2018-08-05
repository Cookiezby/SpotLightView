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
   
    private let logo: UIImageView = {
        let view = UIImageView(image: UIImage(named: "logo")?.withRenderingMode(.alwaysTemplate))
        view.tintColor = .white
        view.contentMode = .scaleAspectFit
        view.bounds = CGRect(x: 0, y: 0, width: 111, height: 32)
        return view
    }()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    private var spotView: SpotlightChainView?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = logo
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let firstSpot = Spotlight(frame: emailTextField.frame.insetBy(dx: -5, dy: -5), cornerRadius: emailTextField.layer.cornerRadius)
        let spotView = SpotlightChainView(frame: view.bounds, spotlight: firstSpot, autoNext: true, completed: nil)
        navigationController?.view.addSubview(spotView)
        spotView.sleep(duration: 3)
                .moveTo(Spotlight(frame: passwordTextField.frame.insetBy(dx: -5, dy: -5), cornerRadius: passwordTextField.layer.cornerRadius), duration: 0.8, curve: .curveEaseInOut)
                .sleep(duration: 3)
                .moveTo(Spotlight(frame: loginButton.frame.insetBy(dx: -5, dy: -5), cornerRadius: loginButton.layer.cornerRadius), duration: 0.8, curve: .curveEaseInOut)
                .start()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
