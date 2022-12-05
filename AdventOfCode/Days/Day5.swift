final class Day5: Day {
    func parse(_ lines: [String]) -> (initialState: [[Character]], moves: [(move: Int, from: Int, to: Int)]) {
        
        // initial state
        let initialStatelines = lines[..<(lines.firstIndex(of: "")! - 1)]
        
        var initialState = [[Character]](repeating: [Character](), count: 9)
        for line in initialStatelines {
            for (idx, char) in line.enumerated() {
                if char.isLetter {
                    initialState[idx / 4].insert(char, at: 0)
                }
            }
        }
        
        // moves
        // "move 2 from 4 to 6"
        let moveLines = lines[(lines.firstIndex(of: "")!+1)...].dropLast()
        
        var moves = [(Int, Int, Int)]()
        for line in moveLines {
            let parts = line.components(separatedBy: " ").map { Int($0) }.filter{ $0 != nil }
            moves.append((parts[0]!, parts[1]!, parts[2]!))
        }
        
        return (initialState, moves)
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        var (state, moves) = parse(input.components(separatedBy: .newlines))
        
        for (move, from, to) in moves {
            for _ in 0..<move {
                state[to-1].append(state[from-1].popLast()!)
            }
        }
        return String(state.map{$0.last!})
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var (state, moves) = parse(input.components(separatedBy: .newlines))
        
        for (move, from, to) in moves {
            let grabbed = state[from-1].suffix(move)
            state[from-1].removeLast(move)
            
            state[to-1].append(contentsOf: grabbed)
        }
        return String(state.map{$0.last!})
    }
}
