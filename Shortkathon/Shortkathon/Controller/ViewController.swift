//
//  ViewController.swift
//  Shortkathon
//
//  Created by 김민준 on 11/14/24.
//

import UIKit

class ViewController: UIViewController {

    // 상태 관리 변수
    var currentActiveOverlay: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 배경색 설정 (FF8310)
        self.view.backgroundColor = UIColor(red: 1.0, green: 0.514, blue: 0.063, alpha: 1.0)

        // student.png를 위한 ImageView
        let studentImageView = UIImageView()
        studentImageView.image = UIImage(named: "student.png")
        studentImageView.contentMode = .scaleAspectFill
        studentImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(studentImageView)

        // teacher.png를 위한 ImageView
        let teacherImageView = UIImageView()
        teacherImageView.image = UIImage(named: "teacher.png")
        teacherImageView.contentMode = .scaleAspectFill
        teacherImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(teacherImageView)

        // student.png 위의 반투명 View
        let studentOverlay = UIView()
        studentOverlay.backgroundColor = UIColor.black.withAlphaComponent(0)
        studentOverlay.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(studentOverlay)

        // teacher.png 위의 반투명 View
        let teacherOverlay = UIView()
        teacherOverlay.backgroundColor = UIColor.black.withAlphaComponent(0)
        teacherOverlay.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(teacherOverlay)

        // 학생 버튼
        let studentButton = UIButton(type: .system)
        studentButton.setTitle("학생으로 들어가기", for: .normal)
        studentButton.setTitleColor(.black, for: .normal)
        studentButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 17)
        studentButton.backgroundColor = UIColor.white
        studentButton.layer.cornerRadius = 20
        studentButton.clipsToBounds = true
        studentButton.isHidden = true
        studentButton.translatesAutoresizingMaskIntoConstraints = false
        studentOverlay.addSubview(studentButton)

        // 선생님 버튼
        let teacherButton = UIButton(type: .system)
        teacherButton.setTitle("선생님으로 들어가기", for: .normal)
        teacherButton.setTitleColor(.black, for: .normal)
        teacherButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 17)
        teacherButton.backgroundColor = UIColor.white
        teacherButton.layer.cornerRadius = 20
        teacherButton.clipsToBounds = true
        teacherButton.isHidden = true
        teacherButton.translatesAutoresizingMaskIntoConstraints = false
        teacherOverlay.addSubview(teacherButton)

        // Auto Layout 설정
        NSLayoutConstraint.activate([
            // studentImageView 레이아웃
            studentImageView.topAnchor.constraint(equalTo: view.topAnchor),
            studentImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            studentImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            studentImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

            // teacherImageView 레이아웃
            teacherImageView.topAnchor.constraint(equalTo: studentImageView.bottomAnchor),
            teacherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            teacherImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            teacherImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

            // studentOverlay 레이아웃
            studentOverlay.topAnchor.constraint(equalTo: studentImageView.topAnchor),
            studentOverlay.leadingAnchor.constraint(equalTo: studentImageView.leadingAnchor),
            studentOverlay.trailingAnchor.constraint(equalTo: studentImageView.trailingAnchor),
            studentOverlay.bottomAnchor.constraint(equalTo: studentImageView.bottomAnchor, constant: 1),

            // teacherOverlay 레이아웃
            teacherOverlay.topAnchor.constraint(equalTo: teacherImageView.topAnchor),
            teacherOverlay.leadingAnchor.constraint(equalTo: teacherImageView.leadingAnchor),
            teacherOverlay.trailingAnchor.constraint(equalTo: teacherImageView.trailingAnchor),
            teacherOverlay.bottomAnchor.constraint(equalTo: teacherImageView.bottomAnchor),

            // studentButton 레이아웃
            studentButton.centerXAnchor.constraint(equalTo: studentOverlay.centerXAnchor),
            studentButton.centerYAnchor.constraint(equalTo: studentOverlay.centerYAnchor),
            studentButton.widthAnchor.constraint(equalToConstant: 175),
            studentButton.heightAnchor.constraint(equalToConstant: 62),

            // teacherButton 레이아웃
            teacherButton.centerXAnchor.constraint(equalTo: teacherOverlay.centerXAnchor),
            teacherButton.centerYAnchor.constraint(equalTo: teacherOverlay.centerYAnchor),
            teacherButton.widthAnchor.constraint(equalToConstant: 175),
            teacherButton.heightAnchor.constraint(equalToConstant: 62),
        ])

        // Gesture Recognizers 추가
        let studentTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleStudentOverlayTap))
        studentOverlay.addGestureRecognizer(studentTapGesture)

        let teacherTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTeacherOverlayTap))
        teacherOverlay.addGestureRecognizer(teacherTapGesture)
    }

    // 학생 오버레이 탭 처리
    @objc func handleStudentOverlayTap() {
        activateOverlay(studentOverlay: true)
    }

    // 선생님 오버레이 탭 처리
    @objc func handleTeacherOverlayTap() {
        activateOverlay(studentOverlay: false)
    }

    // 오버레이 상태 관리
    func activateOverlay(studentOverlay: Bool) {
        if studentOverlay {
            currentActiveOverlay?.backgroundColor = UIColor.black.withAlphaComponent(0)
            currentActiveOverlay?.subviews.forEach { $0.isHidden = true }

            currentActiveOverlay = self.view.subviews[2] // studentOverlay
            currentActiveOverlay?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            currentActiveOverlay?.subviews.forEach { $0.isHidden = false }
        } else {
            currentActiveOverlay?.backgroundColor = UIColor.black.withAlphaComponent(0)
            currentActiveOverlay?.subviews.forEach { $0.isHidden = true }

            currentActiveOverlay = self.view.subviews[3] // teacherOverlay
            currentActiveOverlay?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            currentActiveOverlay?.subviews.forEach { $0.isHidden = false }
        }
    }
}
