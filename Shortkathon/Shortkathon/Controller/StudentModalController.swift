//
//  StudentModalController.swift
//  Shortkathon
//
//  Created by 이유현 on 11/16/24.
//

import Foundation
import UIKit

class StudentModalController: UIViewController {
   
    override func viewDidLoad() {
        view.backgroundColor = UIColor.clear

        super.viewDidLoad()
       
        setUI()
    }
    
    func setUI(){
        
        let contentView: UIView = {
            let contents = UIView()
            contents.translatesAutoresizingMaskIntoConstraints = false
            return contents
        }()
        
        let modal: UIView = {
            let modal = UIView()
            modal.translatesAutoresizingMaskIntoConstraints = false
            modal.backgroundColor = UIColor.white
            return modal
        }()
        
        
        view.addSubview(contentView)
        contentView.addSubview(modal)
        
        NSLayoutConstraint.activate([

            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            modal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            modal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            modal.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            modal.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1)
            
        ])
        
    }


}
