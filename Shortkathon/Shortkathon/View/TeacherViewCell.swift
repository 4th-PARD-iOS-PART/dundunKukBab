
import UIKit

class TeacherViewCell : UICollectionViewCell {
    
    let cellLabel : UILabel =  {
          let label = UILabel()
          label.translatesAutoresizingMaskIntoConstraints = false
          return label
      }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI(){
        contentView.addSubview(cellLabel)
        contentView.layer.cornerRadius = 3.0
        NSLayoutConstraint.activate([
            cellLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cellLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])

    }
    
    
    
    
    
}
