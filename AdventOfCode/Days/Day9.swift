

final class Day9 : Day {
    
    struct Point : Hashable {
        var x: Int
        var y: Int
        
        mutating func move(_ direction: Direction) {
            var dx: Int
            var dy: Int
            
            switch direction{
            case.up:
                dx = 0
                dy = 1
            case.down:
                dx = 0
                dy = -1
            case.left:
                dx = -1
                dy = 0
            case.right:
                dx = 1
                dy = 0
            }
            
            self.x += dx
            self.y += dy
        }
        
        mutating func moveTowards(_ point: Point) {
            let xDist = point.x - self.x
            let yDist = point.y - self.y
            
            if abs(xDist) + abs(yDist) == 1 || (abs(xDist) == 1 && abs(yDist) == 1) {
                return
            } else {
                self.x += xDist.signum()
                self.y += yDist.signum()
            }
        }
    }
    
    enum Direction {
        case up, down, left, right
        
        static func fromSring(_ s: String) -> Direction? {
            switch s {
            case "U": return .up
            case "D": return .down
            case "L": return .left
            case "R": return .right
            default: return nil
            }
        }
    }
    
    struct Move {
        var direction: Direction
        var n: Int
    }
    
    func parse(_ input: String) -> [Move] {
        let input = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var moves = [Move]()
        for line in input.components(separatedBy: .newlines) {
            let parts = line.split(separator: " ")
            
            moves.append(Move(direction: Direction.fromSring(String(parts[0]))!,
                              n: Int(parts[1])!))
        }
        return moves
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        var head = Point(x: 0, y: 0)
        var tail = Point(x: 0, y: 0)
        
        var tailVisited = Set([tail])
        
        let moves = parse(input)
        for move in moves {
            for _ in 0..<move.n {
                head.move(move.direction)
                
                tail.moveTowards(head)
                tailVisited.insert(tail)
            }
        }
        return tailVisited.count
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        var head = Point(x: 0, y: 0)
        var tails = [Point](repeating: Point(x: 0, y: 0), count: 9)
        
        var tailVisited = Set([tails.last])
        
        let moves = parse(input)
        for move in moves {
            for _ in 0..<move.n {
                head.move(move.direction)
                
                var prev = head
                for i in 0..<tails.count {
                    tails[i].moveTowards(prev)
                    prev = tails[i]
                }
                tailVisited.insert(tails.last)
            }
        }
        return tailVisited.count
    }
    
    
}
