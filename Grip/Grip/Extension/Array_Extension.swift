//
//  Array_Extension.swift
//  Grip
//
//  Created by 오국원 on 2022/04/25.
//

import UIKit

extension Array where Element: Hashable {
    func removeDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        return filter({ addedDict.updateValue(true, forKey: $0) == nil})
    }
}
