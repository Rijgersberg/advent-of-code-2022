final class Day10: Day {
    
    func parse(_ input: String) -> [Int?] {
        let input = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var program = [Int?]()
        
        for line in input.components(separatedBy: .newlines) {
            let parts = line.split(separator: " ")
            if parts[0].starts(with: "noop") {
                program.append(nil)
            } else if parts[0] == "addx" {
                program.append(Int(String(parts[1]))!)
            }
        }
        return program
    }
    
    func execute(_ program: [Int?]) -> [Int] {
        var program = program
        var X = [1]
        
        while program.count > 0 {
            let instruction = program.removeFirst()
            
            X.append(X.last!)
            if let add = instruction {
                X.append(X.last! + add)
            }
        }
        return X
    }
            
            
    func part1(_ input: String) -> CustomStringConvertible {
        let program = parse(input)
        
        let X = execute(program)
        
        var answer = 0
        for i in stride(from: 20, to: X.count, by: 40) {
            answer += i * X[i-1]
        }
        return answer
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        let program = parse(input)
        
        let X = execute(program)
        
        var output = "\n"
        for (drawLocation, sprite) in X.enumerated() {
            if abs(drawLocation % 40 - sprite) <= 1 {
                output += "█"
            } else {
                output += " "
            }
            if drawLocation % 40 == 0 {
                output += "\n"
            }
        }
        return output
    }
}
