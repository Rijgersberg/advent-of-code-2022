enum Direction {
    case north, east, south, west
}

final class Day8: Day {
    
    func parse(_ input: String) -> [[Int]] {
        let input = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var forest = [[Int]]()
        
        for line in input.components(separatedBy: .newlines) {
            let treeline = Array(line).compactMap{Int(String($0))}
            forest.append(treeline)
        }
        return forest
    }
    
    func isVisible(forest: [[Int]], x: Int, y: Int, direction: Direction) -> Bool {
        
        let tree = forest[y][x]
        
        let Y = forest.count
        let X = forest[0].count
        
    
        switch direction {
        case .north:
            for j in stride(from:y-1, through:0, by: -1) {
                if forest[j][x] >= tree { return false }
            }
        case .east:
            for i in stride(from:x+1, to: X, by: 1) {
                if forest[y][i] >= tree { return false }
            }
        case .south:
            for j in stride(from:y+1, to: Y, by: 1) {
                if forest[j][x] >= tree { return false }
            }
        case .west:
            for i in stride(from: x-1, through: 0, by: -1) {
                if forest[y][i] >= tree { return false }
            }
        }
        return true
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let forest = parse(input)
        
        var nVisible = 0
        for (y, treeline) in forest.enumerated() {
            for (x, _) in treeline.enumerated() {
                if (isVisible(forest: forest, x: x, y: y, direction: .north) || isVisible(forest: forest, x: x, y: y, direction: .east) || isVisible(forest: forest, x: x, y: y, direction: .south) || isVisible(forest: forest, x: x, y: y, direction: .west)) {
                    nVisible += 1
                }
            }
        }
        return nVisible
    }
    
    func scenicDistance(forest: [[Int]], x: Int, y: Int, direction: Direction) -> Int {
        
        let tree = forest[y][x]
        
        let Y = forest.count
        let X = forest[0].count
        
        var steps = 0
        switch direction {
        case .north:
            for j in stride(from:y-1, through:0, by: -1) {
                if forest[j][x] >= tree {
                    return steps + 1
                } else {
                    steps += 1
                }
            }
        case .east:
            for i in stride(from:x+1, to: X, by: 1) {
                if forest[y][i] >= tree {
                    return steps + 1
                } else {
                    steps += 1
                }
            }
        case .south:
            for j in stride(from:y+1, to: Y, by: 1) {
                if forest[j][x] >= tree {
                    return steps + 1
                } else {
                    steps += 1
                }
            }
        case .west:
            for i in stride(from: x-1, through: 0, by: -1) {
                if forest[y][i] >= tree {
                    return steps + 1
                } else {
                    steps += 1
                }
            }
        }
        return steps
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        let forest = parse(input)
        
        var maxScore = 0
        for (y, treeline) in forest.enumerated() {
            for (x, _) in treeline.enumerated() {
                let score = (scenicDistance(forest: forest, x: x, y: y, direction: .north) * scenicDistance(forest: forest, x: x, y: y, direction: .east) * scenicDistance(forest: forest, x: x, y: y, direction: .south) * scenicDistance(forest: forest, x: x, y: y, direction: .west))
                
                if score > maxScore {
                    maxScore = score
                }
            }
        }
        return maxScore
    }
    
}
