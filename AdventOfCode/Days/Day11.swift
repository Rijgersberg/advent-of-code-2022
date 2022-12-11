import Foundation

final class Day11: Day {
    
    struct Monkey {
        var id: Int
        var items: [Int]
        var operation: (Int) -> Int
        var testDivisbleBy: Int
        var testSucces: Int
        var testFail: Int
        var totalInspections: Int
        
        var part: Int
        
        let maxCommonDivisor = 19 * 5 * 11 * 17 * 7 * 13 * 3 * 2 * 23  // includes values from test cases
        
        init(description: String, part: Int) {
            let description = description.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let lines = description.components(separatedBy: .newlines)
            
            // "Monkey 0:"
            var parts = lines[0].split(separator: " ")
            self.id = Int(String(parts[1].dropLast()))!
            
            // "Starting items: 79, 98"
            parts = lines[1].split(separator: ":")
            self.items = parts[1].trimmingCharacters(in: .whitespaces).split(separator: ",")
                .compactMap{Int($0.trimmingCharacters(in: .whitespaces))}
            
            // "Operation: new = old * 19"
            // TODO: automatic parsing
            // includes values from test cases
            switch lines[2].split(separator: ":")[1].trimmingCharacters(in: .whitespaces) {
            case "new = old * 13": self.operation = {$0 * 13}
            case "new = old + 7": self.operation = {$0 + 7}
            case "new = old + 6": self.operation = {$0 + 6}
            case "new = old + 5": self.operation = {$0 + 5}
            case "new = old + 8": self.operation = {$0 + 8}
            case "new = old * 5": self.operation = {$0 * 5}
            case "new = old * old": self.operation = {$0 * $0}
            case "new = old + 2": self.operation = {$0 + 2}
            case "new = old + 3": self.operation = {$0 + 3}
            case "new = old * 19": self.operation = {$0 * 19}
                
            default: self.operation = {$0}
            }
            
            // "Test: divisible by 23"
            self.testDivisbleBy = Int(lines[3].split(separator: " ").last!)!
            
            // "If true: throw to monkey 2"
            self.testSucces = Int(lines[4].split(separator: " ").last!)!
            
            // "If false: throw to monkey 3"
            self.testFail = Int(lines[5].split(separator: " ").last!)!
            
            self.totalInspections = 0
            
            self.part = part
        }
        
        mutating func turn() -> [(destination: Int, item: Int)]  {
            if items.count == 0 {
                return []
            }
            
            var output = [(Int, Int)]()
            while items.count > 0 {
                totalInspections += 1
                
                var item = items.removeFirst()
                item = operation(item)
                item = part == 1 ? item / 3 : item % maxCommonDivisor
                
                let destination = item % testDivisbleBy == 0 ? testSucces : testFail
                output.append((destination, item))
            }
            return output
        }
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        let monkeyStrings = input.components(separatedBy: "\n\n")
        var monkeys = monkeyStrings.compactMap{Monkey(description: $0, part: 1)}
        
        for _ in 0..<20 {
            for i in 0..<monkeys.count {
                let output = monkeys[i].turn()
                for (destination, item) in output {
                    monkeys[destination].items.append(item)
                }
            }
        }
        var inspected = monkeys.map{$0.totalInspections}
        inspected.sort()
        
        return inspected.last! * inspected[inspected.count-2]
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        let monkeyStrings = input.components(separatedBy: "\n\n")
        var monkeys = monkeyStrings.compactMap{Monkey(description: $0, part: 2)}
        
        for _ in 0..<10000 {
            for i in 0..<monkeys.count {
                let output = monkeys[i].turn()
                for (destination, item) in output {
                    monkeys[destination].items.append(item)
                }
            }
        }
        var inspected = monkeys.map{$0.totalInspections}
        inspected.sort()
        
        return inspected.last! * inspected[inspected.count-2]
    }
}
