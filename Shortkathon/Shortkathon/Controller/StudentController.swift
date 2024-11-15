
import Foundation
import UIKit

class StudentController: UIViewController {
    
    let tableViewUI: UITableView = {
        let tableVIew = UITableView()
        tableVIew.backgroundColor = UIColor.clear
        tableVIew.translatesAutoresizingMaskIntoConstraints = false
        return tableVIew
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(red: 255/255.0, green: 131/255.0, blue: 15/255.0, alpha: 1.0)
        
        super.viewDidLoad()
        
        tableViewUI.dataSource = self
        tableViewUI.delegate = self
        
        setUI()
    }
    
    func setUI(){
        
        view.addSubview(tableViewUI)
        
        tableViewUI.register(StudentTableCell.self, forCellReuseIdentifier: "studentTableCell")
        
        // 라벨과 버튼을 추가
        let label: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "보낸 메시지함"
            label.font = UIFont(name: "Pretendard-Bold", size: 30)
            label.textColor = .white
            return label
        }()
        
        let closeButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            // 이미지 설정
            if let image = UIImage(named: "Vector") {
                button.setImage(image, for: .normal)
            }
            
            button.backgroundColor = UIColor.clear // 배경을 투명으로 설정
            //             button.layer.cornerRadius = 10
            button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
            
            // 이미지의 위치와 크기를 적절히 설정
            button.imageView?.contentMode = .scaleAspectFit // 이미지 비율을 맞추어 보기 좋게 표시
            
            return button
        }()
        
        view.addSubview(label)
        view.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            
            tableViewUI.topAnchor.constraint(equalTo: view.topAnchor, constant: 185),
            tableViewUI.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 36),
            tableViewUI.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -36),
            tableViewUI.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -94),
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -136),
            
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 52),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 23),
            closeButton.widthAnchor.constraint(equalToConstant: 16),
            closeButton.heightAnchor.constraint(equalToConstant: 29)
            
        ])
        
    }
    
    @objc func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension StudentController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MockData.modeling.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "studentTableCell", for: indexPath) as? StudentTableCell else {
            return UITableViewCell()
        }
        
        let data = MockData.modeling[indexPath.row]
        cell.title.text = data.title
        cell.name.text = data.name
        
        cell.backgroundColor = .clear
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .clear  // 배경을 투명으로 설정
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    // 셀 선택 시 배경 색을 설정
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? StudentTableCell {
            selectedCell.bg.backgroundColor = UIColor.clear // 선택된 셀 배경 색
        }
    }
    
    // 셀 선택 해제 시 원래 배경 색으로 되돌리기
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let deselectedCell = tableView.cellForRow(at: indexPath) as? StudentTableCell {
            deselectedCell.bg.backgroundColor = UIColor.clear  // 기본 배경 색
        }
    }
}

