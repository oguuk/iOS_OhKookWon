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

extension UIViewController {
    func cellClickedAndAlert(_ message:String, _ indexPath:Int, action: @escaping () -> Void){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            action()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
