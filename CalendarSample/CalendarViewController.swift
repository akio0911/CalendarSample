//
//  CalendarViewController.swift
//  CalendarSample
//
//  Created by akio0911 on 2016/05/08.
//  Copyright © 2016年 akio0911. All rights reserved.
//

import UIKit

class CalendarViewController: UICollectionViewController {
    
    var yearAndMonth: YearAndMonth = YearAndMonth(year: 2016, month: 5) {
        didSet {
            dataSource = CalendarDataSource(yearAndMonth: yearAndMonth)
            guard isViewLoaded() else { return }
            collectionView?.reloadData()
        }
    }
    
    private var dataSource: CalendarDataSource! {
        didSet {
            collectionView?.dataSource = dataSource
            guard isViewLoaded() else { return }
            collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = CalendarDataSource(yearAndMonth: yearAndMonth)
        collectionView?.dataSource = dataSource
    }
}
