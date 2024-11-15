
import UIKit

class StudentSwipePostController : UIViewController , UIScrollViewDelegate {
    
    // Define the number of pages.
    let pageSize = 2
    
    
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
            
            scrollView.addSubview(label)
        }
        
        // Add UIScrollView, UIPageControl on view
        self.view.addSubview(self.scrollView)
        self.view.addSubview(self.pageControl)
        
        addWhiteModalView()
    }
    
    func addWhiteModalView() {
        let modalView: UIView = {
            let modalView = UIView()
            modalView.translatesAutoresizingMaskIntoConstraints = false
            modalView.backgroundColor = .white
            modalView.layer.cornerRadius = 40.0  // Round the corners
            return modalView
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
      
             button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            
            return button
        }()
        
        let boldlabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "글자글자"
            label.textColor = .black
            label.font = UIFont(name: "Pretendard-Bold", size: 30)
            return label
        }()
        
        let sublabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = "여기가 어떤 곳인지 설명해주는 글자글자글자 글자 "
            label.textColor = .black
            label.numberOfLines = 0
            label.font = UIFont(name: "Pretendard-Regular", size: 17)
            return label
        }()

        
        self.view.addSubview(modalView)
        self.view.addSubview(imageView)
        self.view.addSubview(button)
        
        self.view.addSubview(boldlabel)
        self.view.addSubview(sublabel)
        

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
            sublabel.trailingAnchor.constraint(equalTo: modalView.trailingAnchor, constant: -111),
            sublabel.bottomAnchor.constraint(equalTo: modalView.bottomAnchor, constant: -130),
            
        ])
    }
    
    @objc func buttonClicked(){
        let vc = StudentPostModalController()
        vc.modalTransitionStyle = .coverVertical // 아래에서 위로 (기존)
        vc.modalPresentationStyle = .formSheet // 자동으로
        
//        vc.modalPresentationStyle = .fullScreen
        
        
//        vc.modalPresentationStyle = .pageSheet //화면의 가운데에 배치되는 페이지 시트 (iPad나 가로 모드에서 주로 사용)
//        if let sheet = vc.sheetPresentationController {
//            sheet.detents = [.medium()] // 중간 및 큰 높이 조절 포인트 지정
//            sheet.prefersGrabberVisible = true    // 상단에 잡기 표시줄 추가
//        }
        
        self.present(vc,animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // When the number of scrolls is one page worth.
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            // Switch the location of the page.
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }

}
