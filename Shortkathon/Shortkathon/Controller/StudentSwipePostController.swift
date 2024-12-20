
import UIKit

class StudentSwipePostController : UIViewController , UIScrollViewDelegate {
    
    // Define the number of pages.
    let pageSize = 2
    
    let pageTexts: [String] = [
         "고민글",
         "고민함"
     ]
    
    let subpageText: [String] = [
         "학교 폭력을 겪거나 목격한 일을 익명으로 작성할 수 있습니다. 당신의 목소리가 문제를 해결하는 첫걸음이 됩니다.",
         "작성한 고민글이 모이는 공간입니다. 익명성을 보장하며, 선생님께만 전달되어 안전하게 처리됩니다."
     ]
    
    let buttonPage: [String] = [
         "작성하기",
         "메시지함 가기"
     ]
    
    let imgaeTextpage: [String] = [
         "studentSwipe1",
         "studentList"
     ]
    
    let positionPage: [String] = [
         "post",
         "list"
     ]
    
    lazy var pageControl: UIPageControl = {
        // Create a UIPageControl.
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: self.view.frame.maxY - 100, width: self.view.frame.maxX, height:50))
        pageControl.backgroundColor = UIColor.orange
        
        // Set the number of pages to page control.
        pageControl.numberOfPages = pageSize
        
        // Set the current page.
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        
        return pageControl
    }()
    
    lazy var scrollView: UIScrollView = {
        // Create a UIScrollView.
        let scrollView = UIScrollView(frame: self.view.frame)
        
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.showsVerticalScrollIndicator = false
        
        // Allow paging.
        scrollView.isPagingEnabled = true
        
        // Set delegate of ScrollView.
        scrollView.delegate = self
        
        // Specify the screen size of the scroll.
        scrollView.contentSize = CGSize(width: CGFloat(pageSize) * self.view.frame.maxX, height: 0)
        
        return scrollView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "studentSwipe1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle("작성하기", for: .normal)  // 버튼 텍스트 설정
        button.backgroundColor = UIColor(red: 255/255.0, green: 131/255.0, blue: 15/255.0, alpha: 1.0)  // 배경 색상 설정
        button.setTitleColor(.white, for: .normal)  // 버튼 텍스트 색상을 흰색으로 설정
        button.translatesAutoresizingMaskIntoConstraints = false  // Auto Layout을 사용할 수 있도록 설정
        button.titleLabel?.font = UIFont(name: "Pretendard-Black", size: 17)
        
        // 모서리를 둥글게 설정
        button.layer.cornerRadius = 30.0  // 버튼 모서리 둥글기 반경을 30으로 설정
  
//         button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
      // 그림자 효과 추가 (box-shadow)
          button.layer.shadowColor = UIColor.black.cgColor  // 그림자 색상 설정
          button.layer.shadowOpacity = 0.25  // 그림자 투명도 설정
          button.layer.shadowOffset = CGSize(width: 0, height: 2)  // 그림자의 오프셋(수평, 수직)
          button.layer.shadowRadius = 5.0  // 그림자의 반경 설정
        
        return button
    }()
    
    let boldlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "고민글"
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Bold", size: 30)
        return label
    }()
    
    let sublabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "학교 폭력을 겪거나 목격한 일을 익명으로 작성할 수 있습니다. 당신의 목소리가 문제를 해결하는 첫걸음이 됩니다."
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "Pretendard-Regular", size: 15)
        return label
    }()
    
    let check: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "post")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Set the background color to Cyan.
        self.view.backgroundColor = UIColor(red: 255/255.0, green: 131/255.0, blue: 15/255.0, alpha: 1.0)
        
        // Get the vertical and horizontal sizes of the view.
        let width = self.view.frame.maxX, height = self.view.frame.maxY
        
        for i in 0 ..< pageSize {
            // Generate different labels for each page.
            let label: UILabel = UILabel(frame: CGRect(x: CGFloat(i) * width + width/2 - 40, y: height/2 - 40, width: 80, height: 80))
            label.backgroundColor = .red
            label.textColor = .white
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.text = "Page\(i)"
            
            label.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
            label.layer.cornerRadius = 40.0
            
//            scrollView.addSubview(label)
        }
        
        // Add UIScrollView, UIPageControl on view
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.pageControl)
        
        addWhiteModalView()

        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    func addWhiteModalView() {
        let modalView: UIView = {
            let modalView = UIView()
            modalView.translatesAutoresizingMaskIntoConstraints = false
            modalView.backgroundColor = .white
            modalView.isUserInteractionEnabled = false //스와이프 인식 충돌 해결

            // 상단 코너만 둥글게 설정
            let cornerRadius: CGFloat = 40.0
            let maskPath = UIBezierPath(
                roundedRect: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 286),
                byRoundingCorners: [.topLeft, .topRight], // 상단 코너만 라운딩
                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
            )
            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            modalView.layer.mask = shape

            return modalView
        }()


        
        self.view.addSubview(modalView)
        self.view.addSubview(imageView)
        self.view.addSubview(button)
        
        self.view.addSubview(boldlabel)
        self.view.addSubview(sublabel)
        self.view.addSubview(check)
        

        NSLayoutConstraint.activate([
            modalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            modalView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            modalView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            modalView.heightAnchor.constraint(equalToConstant: 286),
            
            imageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 72),
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 13),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -277),
            
            button.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 188),
            button.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 180),
            button.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -36),
            button.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -42),
            
            boldlabel.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 42),
            boldlabel.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 36),
            boldlabel.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -167),
            boldlabel.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -197),
            
            sublabel.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 109),
            sublabel.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 36),
            sublabel.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -56),
            sublabel.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -120),
            
            check.topAnchor.constraint(equalTo: modalView.topAnchor, constant: 216),
            check.leadingAnchor.constraint(equalTo: modalView.leadingAnchor, constant: 36),
            check.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -83),
//            check.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -120),
            
        ])
    }
    
    @objc func buttonClicked(){
        let vc = StudentPostModalController()
        vc.modalTransitionStyle = .coverVertical // 아래에서 위로 (기존)
        vc.modalPresentationStyle = .formSheet // 자동으로
        
        self.present(vc,animated: true)
    }
    
    @objc func buttonClicked2(){
//        StudentModalController
        let vc = StudentController()
        vc.modalTransitionStyle = .coverVertical // 아래에서 위로 (기존)
        vc.modalPresentationStyle = .formSheet // 자동으로
        
        self.present(vc,animated: true)
        print("버튼 확인")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // When the number of scrolls is one page worth.
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            // Calculate the current page.
            let currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
            
            // Update the UIPageControl's current page.
            pageControl.currentPage = currentPage
            
            // Update the labels based on the current page.
            updateLabels(forPage: currentPage)
        }
    }

    func updateLabels(forPage page: Int) {
        if page < pageTexts.count {
            boldlabel.text = pageTexts[page]
            
            sublabel.text = subpageText[page]
            // Update the button text
            button.setTitle(buttonPage[page], for: .normal)
            
            // Update the image for the page
            if let image = UIImage(named: imgaeTextpage[page]) {
                imageView.image = image
            }
            
            if let image = UIImage(named: positionPage[page]) {
                check.image = image
            }
            
            button.removeTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            button.removeTarget(self, action: #selector(buttonClicked2), for: .touchUpInside)

            // Dynamically set the target function based on the page
            if page == 0 {
                button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            } else if page == 1 {
                button.addTarget(self, action: #selector(buttonClicked2), for: .touchUpInside)
            }

        }
    }

}

