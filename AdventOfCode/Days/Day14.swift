
final class Day14: Day {
    
    struct Point : Hashable {
        var x: Int
        var y: Int
    }
    
    struct Cave {
        var rock: Set<Point>
        var sand: Set<Point>
        var maxY: Int
        
        init(input: String) {
            let input = input.trimmingCharacters(in: .whitespacesAndNewlines)
            
            self.rock = Set<Point>()
            self.sand = Set<Point>()
            self.maxY = 0
            
            for wallString in input.components(separatedBy: .newlines) {
                
                let points = wallString.components(separatedBy: " -> ")
                    .map{$0.components(separatedBy: ",").compactMap{Int($0)}}
                
                for i in 0..<(points.count - 1) {
                    let (x1, y1) = (points[i][0], points[i][1])
                    let (x2, y2) = (points[i+1][0], points[i+1][1])
                    
                    maxY = max(maxY, max(y1, y2))
                    
                    if x1 == x2 {
                        for y in min(y1, y2)...max(y1, y2) {
                            rock.insert(Point(x: x1, y: y))
                        }
                    } else if y1 == y2 {
                        for x in min(x1, x2)...max(x1, x2) {
                            rock.insert(Point(x: x, y: y1))
                        }
                    } else {
                        fatalError()
                    }
                }
            }
        }
        
        func valid(_ pos: Point) -> Bool {
            return !rock.contains(pos) && !sand.contains(pos)
        }
        
        func valid2(_ pos: Point) -> Bool {
            return !rock.contains(pos) && !sand.contains(pos) && pos.y != 2 + maxY
        }
        
        mutating func dropSand(at pos: Point) -> Point? {
            var pos = pos
            
            while pos.y < maxY {
                // directly down
                var nextPos = Point(x: pos.x, y: pos.y+1)
                if valid(nextPos) {
                    pos = nextPos
                    continue
                }
                
                // down and to the left
                nextPos = Point(x: pos.x-1, y: pos.y+1)
                if valid(nextPos) {
                    pos = nextPos
                    continue
                }
                
                // down and to the right
                nextPos = Point(x: pos.x+1, y: pos.y+1)
                if valid(nextPos) {
                    pos = nextPos
                    continue
                }
                
                //blocked
                sand.insert(pos)
                return pos
            }
            return nil
        }
        
        mutating func dropSand2(at pos: Point) -> Point? {
            let endPoint = pos
            var pos = pos
            
            while true {
                // directly down
                var nextPos = Point(x: pos.x, y: pos.y+1)
                if valid2(nextPos) {
                    pos = nextPos
                    continue
                }
                
                // down and to the left
                nextPos = Point(x: pos.x-1, y: pos.y+1)
                if valid2(nextPos) {
                    pos = nextPos
                    continue
                }
                
                // down and to the right
                nextPos = Point(x: pos.x+1, y: pos.y+1)
                if valid2(nextPos) {
                    pos = nextPos
                    continue
                }
                
                //blocked
                if pos == endPoint {
                    return nil
                } else {
                    sand.insert(pos)
                    return pos
                }
            }
            fatalError()
        }
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        var cave = Cave(input: input)
        
        var i = 0
        while cave.dropSand(at: Point(x: 500, y: 0)) != nil {
            i += 1
        }
        return i
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        var cave = Cave(input: input)
        
        var i = 0
        while cave.dropSand2(at: Point(x: 500, y: 0)) != nil {
            i += 1
        }
        return i + 1
    }
}
