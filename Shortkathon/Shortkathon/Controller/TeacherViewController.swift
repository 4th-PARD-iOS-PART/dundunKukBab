import UIKit

class TeacherViewController :  UIViewController {
    
    var mem : TeacherModel = TeacherModel(name: "민준")
    
    let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "게시판"
        label.textColor = .black
        label.font = UIFont(name: "Pretendard-Black", size: 20)
        return label
    
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 100 // 셀 사이 간격
    

        layout.itemSize = CGSize(width: 133, height: 165) // 셀 크기
//        layout.i
        layout.minimumLineSpacing = 20 // 행 간격
        layout.minimumInteritemSpacing = 37
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollection()
        setUI()
        
        view.backgroundColor = #colorLiteral(red: 0.5121328831, green: 0.7262243629, blue: 0.9602429271, alpha: 1)
    }
    func setUI(){
        view.addSubview(label)
        view.addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 36 ),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -36),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func setCollection(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = #colorLiteral(red: 0.5121328831, green: 0.7262243629, blue: 0.9602429271, alpha: 1)
        collectionView.register(TeacherViewCell.self, forCellWithReuseIdentifier: "teacher")
        collectionView.showsHorizontalScrollIndicator = false
    }
}




extension TeacherViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return teacherModel.count
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teacher", for: indexPath) as? TeacherViewCell else { return UICollectionViewCell() }
        cell.cellLabel.text = mem.name
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 20
        return cell
    }
    
    
    
}
