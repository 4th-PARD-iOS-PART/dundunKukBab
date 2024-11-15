import UIKit

class StudentPostModalController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 뷰 배경을 투명하게 설정
        view.backgroundColor = UIColor.clear
        
        // UI 초기화 함수 호출
        setUI()
    }
    
    // UI 구성 함수
    func setUI() {
        
        // 콘텐츠를 담을 뷰를 생성
        let contentView: UIView = {
            let contents = UIView()
            contents.translatesAutoresizingMaskIntoConstraints = false
            return contents
        }()
        
        // 모달 뷰를 생성
        let modal: UIView = {
            let modal = UIView()
            modal.translatesAutoresizingMaskIntoConstraints = false
            modal.backgroundColor = UIColor.white
            modal.layer.cornerRadius = 20 // 모달에 둥근 모서리 적용
            modal.layer.masksToBounds = true // 모서리가 둥글게 보이도록 마스크 처리
            return modal
        }()
        
        // 제목 텍스트 필드 추가 (이전에는 UILabel이었으나, 텍스트 필드로 변경)
        let titleTextField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.placeholder = "제목쓰기" // 플레이스홀더 텍스트
            textField.font = UIFont.boldSystemFont(ofSize: 24) // 굵은 폰트로 크기 설정
            textField.textAlignment = .left // 텍스트 가운데 정렬
            textField.borderStyle = .roundedRect // 둥근 사각형 테두리
            return textField
        }()
    
        
        let button: UIButton = {
            let button = UIButton()
            button.setTitle("보내기", for: .normal)  // 버튼 텍스트 설정
            button.backgroundColor = UIColor(red: 255/255.0, green: 131/255.0, blue: 15/255.0, alpha: 1.0)  // 배경 색상 설정
            button.setTitleColor(.white, for: .normal)  // 버튼 텍스트 색상을 흰색으로 설정
            button.translatesAutoresizingMaskIntoConstraints = false  // Auto Layout을 사용할 수 있도록 설정
            button.titleLabel?.font = UIFont(name: "Pretendard-Black", size: 17)
            
            // 모서리를 둥글게 설정
            button.layer.cornerRadius = 30.0  // 버튼 모서리 둥글기 반경을 30으로 설정
            
            // 그림자 효과 추가 (box-shadow)
            button.layer.shadowColor = UIColor.black.cgColor  // 그림자 색상 설정
            button.layer.shadowOpacity = 0.25  // 그림자 투명도 설정
            button.layer.shadowOffset = CGSize(width: 0, height: 2)  // 그림자의 오프셋(수평, 수직)
            button.layer.shadowRadius = 5.0  // 그림자의 반경 설정
            
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            
            return button
        }()
        
        // 첫 번째 라벨 추가
        let label1: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "음성메시지" // 텍스트 설정
            label.font = UIFont(name: "Pretendard-Regular", size: 17)
            label.textColor = .black
            label.textAlignment = .center
            return label
        }()
        
        // 첫 번째 버튼 추가 (동그란 버튼, 이미지 추가)
        let button1: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
//            button.layer.cornerRadius = 23  // 동그란 버튼 설정
            button.setImage(UIImage(named: "Group 14"), for: .normal)  // 이미지 설정 (이미지 파일 이름에 맞게 설정)
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            return button
        }()
        
        // 두 번째 버튼 추가 (동그란 버튼, 이미지 추가)
        let button2: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
//            button.layer.cornerRadius = 23  // 동그란 버튼 설정
            button.setImage(UIImage(named: "Group 15"), for: .normal)  // 이미지 설정 (이미지 파일 이름에 맞게 설정)
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            return button
        }()
        
        // 콘텐츠 뷰에 모달 뷰를 추가
        view.addSubview(contentView)
        contentView.addSubview(modal)
        
        // 모달 뷰 안에 제목 텍스트 필드와 내용 텍스트 필드를 추가
        modal.addSubview(titleTextField)
        //        modal.addSubview(textField)
        modal.addSubview(button)
        modal.addSubview(label1)
        modal.addSubview(button1)
        modal.addSubview(button2)
        
        // Auto Layout 제약 조건 설정
        NSLayoutConstraint.activate([
            // 콘텐츠 뷰가 전체 화면을 차지하도록 설정
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // 모달 뷰가 콘텐츠 뷰 내부에서 전체를 차지하도록 설정
            modal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            modal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            modal.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            modal.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 1),
            
            // 제목 텍스트 필드의 제약조건 설정
            titleTextField.topAnchor.constraint(equalTo: modal.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: modal.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: modal.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 40), // 제목의 높이 고정
            
            //            button.topAnchor.constraint(equalTo: modal.topAnchor, constant: 641),
            button.leadingAnchor.constraint(equalTo: modal.leadingAnchor, constant: 108),
            button.trailingAnchor.constraint(equalTo: modal.trailingAnchor, constant: -94),
            button.bottomAnchor.constraint(equalTo: modal.bottomAnchor, constant: -43),
            button.heightAnchor.constraint(equalToConstant: 56),
            
            label1.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 22),
            label1.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
//            label1.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor, constant: -20),
            
            // 첫 번째 버튼 위치 설정
            button1.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -46),
            button1.leadingAnchor.constraint(equalTo: modal.leadingAnchor, constant: 208),
            button1.heightAnchor.constraint(equalToConstant: 46),
            button1.widthAnchor.constraint(equalToConstant: 46),  // 이미지에 맞는 크기로 설정
            
            // 두 번째 버튼 위치 설정
            button2.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -46),
//            button2.centerXAnchor.constraint(equalTo: modal.centerXAnchor),
            button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 13),
            button2.heightAnchor.constraint(equalToConstant: 46),
            button2.widthAnchor.constraint(equalToConstant: 46),
            
        ])
    }
    
    @objc func buttonClicked(){
        
        print("버튼 확인222")
    }
}
