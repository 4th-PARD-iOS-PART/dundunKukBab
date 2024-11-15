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
            textField.placeholder = "제목을 입력하세요" // 플레이스홀더 텍스트
            textField.font = UIFont.boldSystemFont(ofSize: 24) // 굵은 폰트로 크기 설정
            textField.textAlignment = .center // 텍스트 가운데 정렬
            textField.borderStyle = .roundedRect // 둥근 사각형 테두리
            return textField
        }()
        
        // 내용 텍스트 필드 추가
        let textField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.placeholder = "내용을 입력하세요" // 플레이스홀더 텍스트
            textField.borderStyle = .roundedRect // 둥근 사각형 테두리
            textField.font = UIFont.systemFont(ofSize: 16) // 폰트 크기 설정
            return textField
        }()
        
        // 콘텐츠 뷰에 모달 뷰를 추가
        view.addSubview(contentView)
        contentView.addSubview(modal)
        
        // 모달 뷰 안에 제목 텍스트 필드와 내용 텍스트 필드를 추가
        modal.addSubview(titleTextField)
        modal.addSubview(textField)
        
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
            
            // 내용 텍스트 필드의 제약조건 설정
            textField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: modal.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: modal.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 40) // 텍스트 필드의 높이 고정
        ])
    }
}
