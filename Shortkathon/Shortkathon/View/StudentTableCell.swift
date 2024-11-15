import Foundation
import UIKit

class StudentTableCell: UITableViewCell {
    
    let bg: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear  // 흰색 배경
        return view
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white  // 흰색 배경
        view.layer.cornerRadius = 20  // 모서리 둥글게
        return view
    }()
    
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Pretendard-Medium", size: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    let name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Pretendard-Regular", size: 15)
        label.textColor = UIColor(red: 75/255.0, green: 156/255.0, blue: 255/255.0, alpha: 1.0)
        return label
    }()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Group 14")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "studentTableCell")
        
        contentView.addSubview(bg)  // containerView를 contentView에 추가
        bg.addSubview(containerView)
        containerView.addSubview(title)  // title, name, imageView를 containerView에 추가
        containerView.addSubview(name)
        containerView.addSubview(image)  // 추가한 imageView
        
        setLabel()
    }
    
    func setLabel() {
        NSLayoutConstraint.activate([
            // containerView 제약 설정
            bg.topAnchor.constraint(equalTo: contentView.topAnchor),
            bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            // containerView 제약 설정
            containerView.topAnchor.constraint(equalTo: bg.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: bg.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: bg.trailingAnchor),
//            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 73),
            
            // title 제약 설정 (containerView 기준)
            title.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 13),
            title.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -77),
            
            // 읽음 안 읽음
            name.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 11),
            name.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -11),
            
            // imageView 제약 설정 (containerView 기준)
            image.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 21),
            image.heightAnchor.constraint(equalToConstant: 44),  // 이미지 크기 설정
            image.widthAnchor.constraint(equalToConstant: 44),   // 이미지 크기 설정
        ])
    }
}
