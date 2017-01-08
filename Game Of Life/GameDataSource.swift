//
//  GameDataSource.swift
//  Game Of Life
//
//  Created by Duy Anh on 1/8/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import Utils
import Foundation

class GameDataSource: NSObject, UICollectionViewDataSource {
    weak var collectionView: UICollectionView!
    var dataModel: GameDataModel
    
    var width: Int { return dataModel.width }
    var height: Int { return dataModel.height }
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.dataModel = GameDataModel(width: 3, height: 3)
    }
    
    func play() {
        dataModel.advance()
        collectionView.reloadData()
    }
    
    func set(width: Int, height: Int, probability: Float) {
        dataModel.generateCells(width: width, height: height, probability: probability)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.height * dataModel.width
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if dataModel.cellAt(indexPath: indexPath)?.state == .alive {
            cell.backgroundColor = .darkGray
        } else {
            cell.backgroundColor = .white
        }
        
        return cell
    }
}
