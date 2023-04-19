//
//  GridStack.swift
//  
//
//  Created by 지준용 on 2023/04/19.
//

import SwiftUI

struct GridStack<Cell: View>: View {
    
    // MARK: - Property
    
    let numberOfCells: Int
    private let cell: (Int, Int) -> Cell

    // MARK: - Init
    
    init(
        numberOfCells: Int,
        cell: @escaping (Int, Int) -> Cell
    ) {
        self.numberOfCells = numberOfCells
        self.cell = cell
    }
    
    // MARK: - View
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< numberOfCells, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< numberOfCells, id: \.self) { column in
                        cell(row, column)
                    }
                }
            }
        }
    }
}
