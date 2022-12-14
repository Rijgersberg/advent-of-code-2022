

final class Day12: Day {
    
    struct Point : Hashable, Equatable {
        var row: Int
        var col: Int
        var height: Int
    }
    
    func parse(_ input: String) -> (grid: [[Point]], source: Point, target: Point) {
        let input = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var source: Point?
        var target: Point?
        
        var grid = [[Point]]()
        for (row, line) in input.components(separatedBy: .newlines).enumerated() {
            
            var gridRow = [Point]()
            for (col, char) in line.enumerated() {
                
                var point: Point
                
                // TODO parse start and end points
                switch char {
                case "S":
                    point = Point(row: row, col: col, height: Int(Character("a").asciiValue!) - Int(Character("a").asciiValue!))
                    source = point
                case "E":
                    point = Point(row: row, col: col, height: Int(Character("z").asciiValue!) - Int(Character("a").asciiValue!))
                    target = point
                default: point = Point(row: row, col: col, height: Int(char.asciiValue!) - Int(Character("a").asciiValue!))
                }
                
                gridRow.append(point)
            }
            grid.append(gridRow)
        }
        return (grid, source!, target!)
    }
    
    func neighbors(_ point: Point, grid: [[Point]]) -> [Point] {
        let R = grid.count
        let C = grid[0].count
        
        var neighs = [Point]()
        
        for (dr, dc) in [(-1, 0), (1, 0), (0, 1), (0, -1)] {
            if !(dr == 0 && dc == 0) {
                let r = point.row + dr
                let c = point.col + dc
                if (0..<R).contains(r) && (0..<C).contains(c) {
                    neighs.append(grid[r][c])
                }
            }
        }
        return neighs
    }
    
    func breadthFirstSearch(grid: [[Point]], source: Point, target: Point, allowed: (Point, Point) -> Bool) -> Int {
        
        var visited = Set([source])
        var queue = [source]
        var nextLevelQueue :[Point]
        
        var depth = 0
        
        while queue.count > 0 {
            nextLevelQueue = [Point]()
            
            while queue.count > 0 {
                let current = queue.removeFirst()
                
                if current == target {
                    return depth
                }
                
                for neighbor in neighbors(current, grid: grid) {
                    if !visited.contains(neighbor) && allowed(current, neighbor) {
                        visited.insert(neighbor)
                        nextLevelQueue.append(neighbor)
                    }
                }
            }
            depth += 1
            queue = nextLevelQueue
        }
        return Int.max
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let (grid, source, target) = parse(input)
                
        return breadthFirstSearch(grid: grid, source: source, target: target, allowed: {$0.height + 1 >= $1.height})
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        let (grid, source, target) = parse(input)
        
        var minSteps = Int.max
        
        for row in grid {
            for point in row {
                if point.height == 0 {
                    let steps = breadthFirstSearch(grid: grid, source: point, target: target, allowed: {$0.height + 1 >= $1.height})
                    minSteps = min(minSteps, steps)
                }
            }
        }
        return minSteps
    }
    
    
}
