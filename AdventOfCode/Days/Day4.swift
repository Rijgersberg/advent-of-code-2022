extension ClosedRange {
    func contains(_ other: ClosedRange) -> Bool {
        return (other.lowerBound >= self.lowerBound)
        && (other.upperBound <= self.upperBound)
    }
}

final class Day4: Day {
    
    func parse(_ line: String) -> (firstRange: ClosedRange<Int>, secondRange: ClosedRange<Int>) {
        let parts = line.split(separator: ",")
        
        let firstParts = parts[0].split(separator: "-")
        let firstRange = Int(firstParts[0])!...Int(firstParts[1])!
        
        let secondParts = parts[1].split(separator: "-")
        let secondRange = Int(secondParts[0])!...Int(secondParts[1])!
        
        return (firstRange, secondRange)
    }
   
    func part1(_ input: String) -> CustomStringConvertible {
        var total = 0
        for line in input.components(separatedBy: .newlines).filter({!$0.isEmpty}) {
            let (firstRange, secondRange) = parse(line)
            
            if firstRange.contains(secondRange) || secondRange.contains(firstRange) {
                total += 1
            }
        }
        return total
    }

    func part2(_ input: String) -> CustomStringConvertible {
        var total = 0
        for line in input.components(separatedBy: .newlines).filter({!$0.isEmpty}) {
            let (firstRange, secondRange) = parse(line)
            
            if firstRange.overlaps(secondRange) {
                total += 1
            }
        }
        return total
    }
}
