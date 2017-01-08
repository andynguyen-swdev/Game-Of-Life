//
//  GameViewDelegate.swift
//  Game Of Life
//
//  Created by Duy Anh on 1/8/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import UIKit
import Foundation

class GameViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    weak var collectionView: UICollectionView!
    var controller: ViewController

    init(controller: ViewController) {
        self.controller = controller
        self.collectionView = controller.collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / CGFloat(controller.dataSource.dataModel.width)
        let height = collectionView.bounds.height / CGFloat(controller.dataSource.dataModel.height)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
