//
//  ViewController.swift
//  Shortkathon
//
//  Created by 김민준 on 11/14/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 1.0, green: 0.514, blue: 0.063, alpha: 1.0)

        let studentImageView = UIImageView()
        studentImageView.image = UIImage(named: "student.png")
        studentImageView.contentMode = .scaleAspectFill
        studentImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(studentImageView)

        let teacherImageView = UIImageView()
        teacherImageView.image = UIImage(named: "teacher.png")
        teacherImageView.contentMode = .scaleAspectFill
        teacherImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(teacherImageView)

        let studentButton = UIButton(type: .system)
        studentButton.setTitle("학생으로 들어가기", for: .normal)
        studentButton.setTitleColor(.black, for: .normal)
        studentButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 17)
        studentButton.backgroundColor = UIColor.white
        studentButton.layer.cornerRadius = 20
        studentButton.clipsToBounds = true
        studentButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(studentButton)

        let teacherButton = UIButton(type: .system)
        teacherButton.setTitle("선생님으로 들어가기", for: .normal)
        teacherButton.setTitleColor(.black, for: .normal)
        teacherButton.titleLabel?.font = UIFont(name: "Pretendard-Bold", size: 17)
        teacherButton.backgroundColor = UIColor.white
        teacherButton.layer.cornerRadius = 20
        teacherButton.clipsToBounds = true
        teacherButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(teacherButton)

        studentButton.addTarget(self, action: #selector(showStudentController), for: .touchUpInside)
        teacherButton.addTarget(self, action: #selector(showTeacherController), for: .touchUpInside)

        NSLayoutConstraint.activate([
            studentImageView.topAnchor.constraint(equalTo: view.topAnchor),
            studentImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            studentImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            studentImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

            teacherImageView.topAnchor.constraint(equalTo: studentImageView.bottomAnchor),
            teacherImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            teacherImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            teacherImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),

            studentButton.centerXAnchor.constraint(equalTo: studentImageView.leadingAnchor, constant: 100),
            studentButton.centerYAnchor.constraint(equalTo: studentImageView.bottomAnchor, constant: -70),
            studentButton.widthAnchor.constraint(equalToConstant: 159),
            studentButton.heightAnchor.constraint(equalToConstant: 62),

            teacherButton.centerXAnchor.constraint(equalTo: teacherImageView.leadingAnchor, constant: 100),
            teacherButton.centerYAnchor.constraint(equalTo: teacherImageView.bottomAnchor, constant: -70),
            teacherButton.widthAnchor.constraint(equalToConstant: 159),
            teacherButton.heightAnchor.constraint(equalToConstant: 62),
        ])
    }

    @objc func showStudentController() {
        let studentController = StudentSwipePostController()
        studentController.modalPresentationStyle = .fullScreen
        self.present(studentController, animated: true, completion: nil)
    }

    @objc func showTeacherController() {
        let teacherController = TeacherViewController()
        teacherController.modalPresentationStyle = .fullScreen
        self.present(teacherController, animated: true, completion: nil)
    }
}

