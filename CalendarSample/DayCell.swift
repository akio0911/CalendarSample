//
//  DayCell.swift
//  CalendarSample
//
//  Created by akio0911 on 2016/05/08.
//  Copyright © 2016年 akio0911. All rights reserved.
//

import UIKit

protocol Configurable {
    associatedtype Item
    func configure(item: Item)
}

class DayCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    
    func configure(item: DayInfo?) {
        dayLabel.text = item.map{ String($0.day) }
    }
}
