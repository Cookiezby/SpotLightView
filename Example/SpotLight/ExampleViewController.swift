//
//  ExampleViewController.swift
//  SpotLight_Example
//
//  Created by cookie on 2018/9/30.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class ExampleViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.delegate = self
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = view.bounds
    }
}

extension ExampleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description()) else { return UITableViewCell() }
        cell.accessoryType = .disclosureIndicator
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Move"
        case 1:
            cell.textLabel?.text = "Scale"
        case 2:
            cell.textLabel?.text = "Breath"
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = SampleMoveViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = SampleScaleViewController()
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = SampleBreathViewController()
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}
