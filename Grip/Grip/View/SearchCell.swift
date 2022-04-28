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
        return poster
    }()
    
    private lazy var isInclude: UIImageView = {
        let star = UIImageView()
        star.widthAnchor.constraint(equalToConstant: 30).isActive = true
        star.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return star
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.alpha = 0.8
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
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
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 67).isActive = true
        stack.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addSubview(moviePoster)
        moviePoster.translatesAutoresizingMaskIntoConstraints = false
        moviePoster.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        moviePoster.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 6).isActive = true
        moviePoster.widthAnchor.constraint(equalToConstant: 60).isActive = true
        moviePoster.heightAnchor.constraint(equalToConstant: 103).isActive = true
        
        addSubview(isInclude)
        isInclude.translatesAutoresizingMaskIntoConstraints = false
        isInclude.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        isInclude.topAnchor.constraint(equalTo: self.topAnchor, constant: 9).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Cell configure
    
    func configureCell(with info: JSON.Search.Movie,image:String = "bookmark") {
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.blue.cgColor
        } else {
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = UIColor.black.cgColor
        }
    }
}
