//
//  Matrix.swift
//  The30Days
//
//  Created by Cédric Bahirwe on 23/08/2022.
//

import Foundation

struct Matrix {
    init(_ rows: Int, _ columns: Int) {
        self.rows = rows
        self.columns = columns

        assert(rows != 0, "Rows can not be empty")
        assert(columns != 0, "Columns can not be empty")
    }

    let rows: Int
    let columns: Int

    func getMatrixTable() -> [[Int]] {
        var table: [[Int]] = [[]]
        for i in 0..<rows {
            var row = [Int]()
            for j in 0..<columns {
                row.append(i * columns + j + 1)
            }
            table.append(row)
        }
        return table
    }
}
