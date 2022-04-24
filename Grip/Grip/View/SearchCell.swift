//
//  SearchCell.swift
//  Grip
//
//  Created by 오국원 on 2022/04/22.
//

import UIKit

class SearchCell:UITableViewCell {
    //MARK: - Properties
    private let moviePoster: UIImageView = {
        let poster = UIImageView()
        return poster
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26)
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "2022.03.22"
        label.alpha = 0.75
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = "Thrill"

        return label
    }()
    
    //MARK: -init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        let stack = UIStackView(arrangedSubviews: [titleLabel, yearLabel, typeLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 1
        
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerYAnchor.constraint(equalTo: stack.centerYAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Cell configure
    
    func configureCell(with info: JSON.Search.Movie) {
        titleLabel.text = info.title
        yearLabel.text = info.year
        typeLabel.text = info.type
    }
}
