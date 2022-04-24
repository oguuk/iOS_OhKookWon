//
//  UITableView_Extension.swift
//  Grip
//
//  Created by 오국원 on 2022/04/24.
//

import UIKit

extension UITableView {
    func showHelpLabel(tableView: UITableView,withText text: String) -> UITableView {
        let helpLabel = UILabel()
        helpLabel.frame.size = CGSize.zero
        helpLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        helpLabel.textColor = UIColor.lightGray
        helpLabel.textAlignment = .center
        helpLabel.text = text
        helpLabel.sizeToFit()
        tableView.backgroundView = helpLabel
        
        return tableView
    }
}
