
import Foundation
import UIKit

class StudentController: UIViewController {
    
    let tableViewUI: UITableView = {
        let tableVIew = UITableView()
        tableVIew.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        tableVIew.translatesAutoresizingMaskIntoConstraints = false
        return tableVIew
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        
        tableViewUI.dataSource = self
        tableViewUI.delegate = self
        
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
        
        view.addSubview(tableViewUI)
        view.addSubview(button)
        
        tableViewUI.register(StudentTableCell.self, forCellReuseIdentifier: "studentTableCell")
        
        NSLayoutConstraint.activate([
            
            tableViewUI.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewUI.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableViewUI.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableViewUI.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
//             Button 제약 조건: 화면 중앙에 배치
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
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
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    
        let headerTitle = UILabel()
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        headerTitle.text = "Section \(section)"
        headerTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerTitle.textColor = .white
    
        headerView.addSubview(headerTitle)
    
        NSLayoutConstraint.activate([
            headerTitle.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 0),
            headerTitle.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 8),
            headerTitle.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -8),
            headerTitle.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0)
        ])
    
        return headerView
    }
}

