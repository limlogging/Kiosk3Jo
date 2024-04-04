//
//  MyPageViewController.swift
//  Kiosk
//
//  Created by imhs on 4/4/24.
//

import UIKit

class MyPageViewController: UIViewController {

    var profileView: UIView = {
        let view = UIView()
        //view.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.960784018, green: 0.9607844949, blue: 0.9693934321, alpha: 1)

        profileUI()
    }
    
    func profileUI() {
        view.addSubview(profileView)
        
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            profileView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
    }
}
