final class Day2: Day {
    enum Result : Int {
        case win = 6  // score
        case draw = 3
        case lose = 0
        
        static func fromInput(_ letter: String) -> Result? {
            switch letter {
            case "X":
                return .lose
            case "Y":
                return .draw
            case "Z":
                return .win
            default:
                return nil
            }
        }
    }
    
    enum Move : Int, Comparable, CaseIterable {
        case rock = 1  // score
        case paper = 2
        case scissors = 3
        
        static func < (lhs: Move, rhs: Move) -> Bool {
            switch (lhs, rhs) {
            case (.rock, .paper), (.paper, .scissors), (.scissors, .rock):
                return true
            default:
                return false
            }
        }
        
        static func fromInput(_ letter: String) -> Move? {
            switch letter {
            case "A", "X":
                return .rock
            case "B", "Y":
                return .paper
            case "C", "Z":
                return .scissors
            default:
                return nil
            }
        }
    }
    
    static func playRound(_ playerMove: Move, _ opponentMove: Move) -> Result {
        if playerMove == opponentMove {
            return .draw
        } else if playerMove < opponentMove {
            return .lose
        } else {
            return .win
        }
    }
    
    func parse1(_ input: [String]) -> [(Move, Move)] {
        var moves = [(Move, Move)]()
        
        for line in input {
            let elements = line.split(separator: " ")
            moves.append(
                ( Move.fromInput(String(elements[1]))!,
                  Move.fromInput(String(elements[0]))! )
            )
        }
        return moves
    }
    
    func parse2(_ input: [String]) -> [(Result, Move)] {
        var strategies = [(Result, Move)]()
        
        for line in input {
            let elements = line.split(separator: " ")
            strategies.append(
                ( Result.fromInput(String(elements[1]))!,
                  Move.fromInput(String(elements[0]))! )
            )
        }
        return strategies
    }

    
    func part1(_ input: String) -> CustomStringConvertible {
        let input = input.components(separatedBy: .newlines).filter{!$0.isEmpty}
        
        var score = 0
        for (playerMove, opponentMove) in parse1(input) {
            score += playerMove.rawValue
            score += Day2.playRound(playerMove, opponentMove).rawValue
        }
        return score
    }

    func part2(_ input: String) -> CustomStringConvertible {
        let input = input.components(separatedBy: .newlines).filter{!$0.isEmpty}
        
        var score = 0
        for (desiredResult, opponentMove) in parse2(input) {
            score += desiredResult.rawValue
            
            for move in Move.allCases {
                if Day2.playRound(move, opponentMove) == desiredResult {
                    score += move.rawValue
                    break
                }
            }
        }
        return score
    }
}
