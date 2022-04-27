//
//  SearchCell.swift
//  Grip
//
//  Created by 오국원 on 2022/04/22.
//

import UIKit

class SearchCell:UITableViewCell {
    //MARK: - Properties
    private let apicall = WebService()
    
    private lazy var moviePoster: UIImageView = {
        let poster = UIImageView()
        poster.widthAnchor.constraint(equalToConstant: 60).isActive = true
        poster.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        return poster
    }()
    
    private lazy var isInclude: UIImageView = {
        let star = UIImageView()
        star.tintColor = .yellow
        star.widthAnchor.constraint(equalToConstant: 50).isActive = true
        star.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return star
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.alpha = 0.75
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .lightGray
        return label
    }()
    
    //MARK: -init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
                
        let stack = UIStackView(arrangedSubviews: [titleLabel, yearLabel, typeLabel])
        stack.axis = .vertical
        stack.distribution = .fill
        
        addSubview(stack)
        stack.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 60)
        
        addSubview(moviePoster)
        moviePoster.centerY(inView: self)
        
        addSubview(isInclude)
        isInclude.centerY(inView: self,leftAnchor: leftAnchor, paddingLeft: 200)
                
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Cell configure
    
    func configureCell(with info: JSON.Search.Movie,image:String = "star") {
        apicall.getImage(url: info.poster) { data, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.moviePoster.image = UIImage(data: data)
                    
                }
            }
        }
        titleLabel.text = info.title
        yearLabel.text = info.year
        typeLabel.text = info.type
        isInclude.image = UIImage(systemName: image)
    }
}

extension SearchCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.layer.borderWidth = 2
            contentView.layer.borderColor = UIColor.blue.cgColor
        } else {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
}
