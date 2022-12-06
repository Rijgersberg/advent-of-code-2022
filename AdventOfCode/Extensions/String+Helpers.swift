//
//  String+Helpers.swift
//  AdventOfCode
//
//  Created by Christopher Luu on 12/2/21.
//

import Foundation

extension String {
    func substring(_ from: Int, _ to: Int) -> Substring {
        let start = self.index(self.startIndex, offsetBy: from)
        let end = self.index(self.startIndex, offsetBy: to)
        return self[start..<end]
    }
    
    var lines: [Substring] {
        split(separator: "\n")
    }

    var ints: [Int] {
        lines.compactMap { Int($0) }
    }
    
    func splitInHalf() -> (firstHalf: String, secondHalf: String) {
        return ( String(self.prefix(self.count / 2)),
                 String(self.suffix(self.count / 2)) )
    }
}
