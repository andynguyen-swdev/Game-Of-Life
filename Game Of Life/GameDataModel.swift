//
//  GameDataModel.swift
//  Game Of Life
//
//  Created by Duy Anh on 1/8/17.
//  Copyright © 2017 Duy Anh. All rights reserved.
//
import GameplayKit
import Foundation

struct Coordinate: Hashable {
    var x: Int
    var y: Int
    
    var hashValue: Int {
        var hash = 17
        hash = ((hash + x) << 5) - (hash + x)
        hash = ((hash + y) << 5) - (hash + y)
        return hash
    }
    
    public static func ==(lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

struct Cell {
    enum CellState {
        case dead, alive, undefined
    }
    
    var state: CellState
    var position: Coordinate
}


class GameDataModel {
    var cells = [Coordinate: Cell]()
    var width: Int
    var height: Int
    
    func cellAt(indexPath: IndexPath) -> Cell? {
        let index = indexPath.item
        let y = index / width
        let x = index - width * y
        
        return cellAtCoordinate(x: x, y: y)
    }
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func advance() {
        var clone = cells
        for cell in cells.values {
            var newCell = cell
            newCell.state = nextStatusForCellAt(cell.position)
            clone[newCell.position] = newCell
        }
        self.cells = clone
    }
    
    private func nextStatusForCellAt(_ c: Coordinate) -> Cell.CellState {
        return self.nextStatusForCellAt(x: c.x, y: c.y)
    }
    
    private func nextStatusForCellAt(x: Int, y: Int) -> Cell.CellState {
        let neighbors = neighborsForCellAt(x: x, y: y)
        let aliveNeighbors = neighbors.filter { if $0.state == .alive { return true }; return false }
        let alives = aliveNeighbors.count
        let cell = cellAtCoordinate(x: x, y: y)
        
        if cell?.state == .alive {
            if alives == 2 || alives == 3 { return .alive } else { return .dead }
        } else if cell?.state == .dead {
            if alives == 3 { return .alive } else { return .dead }
        }
        
        return .undefined
    }
    
    func generateCells(width: Int, height: Int, probability: Float) {
        self.width = width
        self.height = height
        
        cells.removeAll()
        for j in 0 ..< height {
            for i in 0 ..< width {
                var cell = Cell(state: .dead, position: Coordinate(x: i, y: j))
                if GKRandomSource.sharedRandom().nextUniform() <= probability {
                    cell.state = .alive
                }
                cells[cell.position] = cell
            }
        }
    }
    
    private func cellAtCoordinate(x: Int, y: Int) -> Cell? {
        return cells[Coordinate(x: x, y: y)]
    }
    
    private func cellAtCoordinate(_ coord: Coordinate) -> Cell? {
        return self.cellAtCoordinate(x: coord.x, y: coord.y)
    }
    
    private func neighborsForCellAt(x: Int, y: Int) -> [Cell] {
        var array = [Cell?]()
        for i in x-1...x+1 {
            for j in y-1...y+1 {
                if i == x && j == y { continue }
                array.append(cellAtCoordinate(x: i, y: j))
            }
        }
        return array.flatMap { $0 }
    }
    
    private func neighborsForCellAt(_ c: Coordinate) -> [Cell] {
        return self.neighborsForCellAt(x: c.x, y: c.y)
    }
}
