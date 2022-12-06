final class Day6: Day {
    
    func firstUnique(N: Int, in input: String) -> Int {
        let input = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        for i in (N-1)..<input.count {
            if Set(input.substring(i, i+N)).count == N {
                return i + N
            }
            
        }
        return input.count
    }

    func part1(_ input: String) -> CustomStringConvertible {
        return firstUnique(N: 4, in: input)
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return firstUnique(N: 14, in: input)
    }
}
