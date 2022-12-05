final class Day3: Day {
    
    func priority(_ char: Character) -> Int {
        let base: Int
        if char.isLowercase {
            base = Int(Character("a").asciiValue!) - 1
        } else {
            base = Int(Character("A").asciiValue!) - 26 - 1
        }
        let thisCharValue = Int(char.asciiValue!)
        return thisCharValue - base
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let input = input.components(separatedBy: .newlines).filter{!$0.isEmpty}
        
        var prioritySum = 0

        for line in input {
            let (firstHalf, secondHalf) = line.splitInHalf()
            let duplicate = Set(firstHalf).intersection(Set(secondHalf)).first!
            
            prioritySum += priority(duplicate)
        }
        return prioritySum
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let input = input.components(separatedBy: .newlines).filter{!$0.isEmpty}
        
        var prioritySum = 0
        stride(from: 0, to: Int(exactly: input.count)!, by: 3).forEach { i in
            var chars = Set(input[i])
            chars = chars.intersection(Set(input[i+1]))
            chars = chars.intersection(Set(input[i+2]))

            prioritySum += priority(chars.first!)
        }
        return prioritySum
    }
}
