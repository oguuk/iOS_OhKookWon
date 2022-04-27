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
    
    private let moviePoster: UIImageView = {
        let poster = UIImageView()
        poster.widthAnchor.constraint(equalToConstant: 60).isActive = true
        poster.heightAnchor.constraint(equalToConstant: 120).isActive = true
        return poster
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.alpha = 0.75
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        
        return label
    }()
    
    //MARK: -init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        let stack = UIStackView(arrangedSubviews: [titleLabel, yearLabel, typeLabel])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 0
        
        let queue = UIStackView(arrangedSubviews: [moviePoster,stack])
        queue.axis = .horizontal
        
        addSubview(queue)
        queue.translatesAutoresizingMaskIntoConstraints = false
        queue.centerYAnchor.constraint(equalTo: stack.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Cell configure
    
    func configureCell(with info: JSON.Search.Movie) {
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
    }
}
