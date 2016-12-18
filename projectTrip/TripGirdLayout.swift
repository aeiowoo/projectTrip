//
//  TripGirdLayout.swift
//  projectTrip
//
//  Created by Friday on 2016. 12. 11..
//  Copyright © 2016년 SwiftTive. All rights reserved.
//

import UIKit

class TripGirdLayout: UICollectionViewFlowLayout {

    var numberOfColumns : Int = 2
    let userDefaults = UserDefaults.standard
    
    init(numberOfColumns : Int) {
        super.init()
        
        self.numberOfColumns = numberOfColumns
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var itemSize: CGSize {
        get {
            
            if let collectionView = collectionView {
                let collectionViewWitdh = collectionView.frame.width
                let itemWitdh = (collectionViewWitdh/CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing
                let itemHeight : CGFloat = 187
                
                return CGSize(width: itemWitdh, height: itemHeight)
            }
            
            return CGSize(width: 187, height: 187)
        }
        set {
            
            super.itemSize = newValue
        }
    }
}












