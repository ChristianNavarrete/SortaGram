//
//  CustomFlowLayout.swift
//  SortaGram
//
//  Created by HoodsDream on 11/5/15.
//  Copyright © 2015 Parse. All rights reserved.
//

import UIKit

class CustomFlowLayout: UICollectionViewFlowLayout {
    
    override init(){
        
        super.init()

        
    }
    


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupMainCollectionView() {
        
        self.itemSize = CGSizeMake(106.0, 106.0)
        self.minimumLineSpacing = 1.0
        self.minimumInteritemSpacing = 1.0
        self.scrollDirection = UICollectionViewScrollDirection.Vertical
        
        
    }
    
    
    func setupFilterCollectionView() {
        
        self.itemSize = CGSizeMake(85.0, 85.0)
        self.minimumLineSpacing = 1.0
        self.minimumInteritemSpacing = 1.0
        self.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        
    }

}
