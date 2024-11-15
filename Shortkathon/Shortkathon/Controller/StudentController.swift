//
//  StudentController.swift
//  Shortkathon
//
//  Created by 이유현 on 11/16/24.
//

import Foundation
import UIKit

class StudentController: UIViewController {
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        setUI()
    }
    
    func setUI(){
        
        let contentView: UIView = {
            let contents = UIView()
            contents.translatesAutoresizingMaskIntoConstraints = false
            return contents
        }()
        
        let button : UIButton = {
            let button = UIButton()
            button.setTitle("화면전환 ", for: .normal)
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            return button
        }()
        
        view.addSubview(contentView)
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // Button 제약 조건: 화면 중앙에 배치
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
            
            
            
        ])
        
    }
    
    @objc func buttonClicked(){
        let vc = StudentModalController()
        vc.modalTransitionStyle = .coverVertical // 아래에서 위로 (기존)
        vc.modalPresentationStyle = .automatic // 자동으로
        
//        vc.modalPresentationStyle = .fullScreen
        
        
        vc.modalPresentationStyle = .pageSheet //화면의 가운데에 배치되는 페이지 시트 (iPad나 가로 모드에서 주로 사용)
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium()] // 중간 및 큰 높이 조절 포인트 지정
            sheet.prefersGrabberVisible = true    // 상단에 잡기 표시줄 추가
        }
        
        self.present(vc,animated: true)
    }
    
    
}


