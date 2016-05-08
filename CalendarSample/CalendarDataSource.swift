//
//  CalendarDataSource.swift
//  CalendarSample
//
//  Created by akio0911 on 2016/05/08.
//  Copyright © 2016年 akio0911. All rights reserved.
//

import Foundation
import UIKit

struct DayInfo {
    var day: Int
}

enum Weekday: Int {
    case Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
}

struct YearAndMonth {
    var year: Int
    var month: Int
    
    var dayCountOfMonth: Int {
        return NSCalendar.currentCalendar()
            .rangeOfUnit(.Day, inUnit: .Month, forDate: firstDay!)
            .length
    }
    
    var firstDay: NSDate? {
        let comp = NSDateComponents()
        comp.year = year
        comp.month = month
        comp.day = 1
        return NSCalendar.currentCalendar().dateFromComponents(comp)
    }
}

extension NSDate {
    var weekday: Weekday {
        let comp = NSCalendar.currentCalendar()
            .component([.Weekday], fromDate: self)
        return Weekday(rawValue: comp - 1)!
    }
}

class CalendarDataSource: NSObject, UICollectionViewDataSource {
    
    private var dayInfos: [DayInfo?] = []
    
    init(yearAndMonth: YearAndMonth){
        super.init()
        dayInfos = updateDataSource(yearAndMonth)
    }
    
    private func updateDataSource(yearAndMonth: YearAndMonth) -> [DayInfo?] {
        let ColumnCount = 7
        let RowCount = 6
        
        var result = Array<DayInfo?>(count: ColumnCount * RowCount, repeatedValue: nil)
        
        let firstIndex = yearAndMonth.firstDay!.weekday.rawValue
        let lastIndex = firstIndex + yearAndMonth.dayCountOfMonth - 1
        
        for i in firstIndex...lastIndex {
            result[i] = DayInfo(day: i + 1)
        }
        
        return result
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayInfos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "Cell"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DayCell
        cell.configure(dayInfos[indexPath.row])
        return cell
    }
}