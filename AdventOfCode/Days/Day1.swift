final class Day1: Day {
    func parse(_ input: String) -> [Int] {
        var cals = [Int]()
        var currentElfCal = 0
        
        for calString in input.components(separatedBy: .newlines) {
            if calString.isEmpty {
                cals.append(currentElfCal)
                currentElfCal = 0
            } else {
                currentElfCal += Int(calString)!
            }
        }
        cals.sort()
        return cals
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        return parse(input).last!
    }

    func part2(_ input: String) -> CustomStringConvertible {
        return parse(input).suffix(3).sum()
    }
}
