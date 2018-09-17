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
   
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    private var spotView: SpotlightChain?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "Input you Email Address"
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let firstSpot   = Spotlight(frame: emailTextField.frame.insetBy(dx: -5, dy: -5), cornerRadius: 0)
        let secondSpot  = Spotlight(frame: passwordTextField.frame.insetBy(dx: -5, dy: -5), cornerRadius: 2)
        let thirdSpot   = Spotlight(frame: loginButton.frame.insetBy(dx: -5, dy: -5), cornerRadius: 5)

        let spotView = SpotlightChain(frame: view.bounds, spotlight: firstSpot, autoNext: true, completed: nil)
        spotView.addSubview(label)
        label.frame = CGRect(x: 0, y: spotView.bounds.height - 200, width: spotView.bounds.width, height: 200)
        navigationController?.view.addSubview(spotView)
        spotView.sleep(duration: 3)
                .moveTo(secondSpot, duration: 0.8, curve: .liner, completed: { [weak self] in
                    self?.label.text = "Input the Pwd"
                })
                .sleep(duration: 3)
                .moveTo(thirdSpot, duration: 0.8, curve: .liner, completed: { [weak self] in
                    self?.label.text = "Press Login Button"
                })
                .start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
