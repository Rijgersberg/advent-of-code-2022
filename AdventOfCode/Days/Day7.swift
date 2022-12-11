final class Day7: Day {
    
    class FileFolder {
        var size = 0
        var parent: FileFolder?
        var children: [FileFolder]
        var name: String
        var path: String
        
        init(name: String, parent: FileFolder?, size: Int) {
            self.parent = parent
            self.size = size
            self.children = [FileFolder]()
            
            self.name = name
            
            if let parent = parent {
                self.path = "\(parent.path)/\(name)"
            } else {
                self.path = name
            }
        }
        
        func retreiveOrAdd(name: String, size: Int) -> FileFolder {
            var possibleNewFolder = FileFolder(name: name, parent: self, size: size)
            
            if let offset = self.children.firstIndex(where: {$0.path == possibleNewFolder.path}) {
                possibleNewFolder = self.children[offset]
            }
            return possibleNewFolder
        }
        
        var totalSize: Int {
            return size + children.map{$0.totalSize}.reduce(0, +)
        }
    }
    
    func parse(_ input: String) -> FileFolder {
        
        let input = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let root = FileFolder(name: "/", parent: nil, size: 0)
        var pwd = root
        
        for line in input.components(separatedBy: .newlines) {
            let parts = line.split(separator: " ")
            
            if parts[0] == "$" {
                if parts[1] == "cd" { // "$ cd name"
                    let name = String(parts[2])
                    pwd = pwd.retreiveOrAdd(name: name, size: 0)
                    
                } else if parts[1] == "ls" {
                    // some kind of reading mode from now on?
                }
            } else if parts[0] == "dir" {
                let name = String(parts[1])
                _ = pwd.retreiveOrAdd(name: name, size: 0)
            } else {
                let size = Int(String(parts[0]))!
                let name = String(parts[1])
                _ = pwd.retreiveOrAdd(name: name, size: size)
            }
        }
        
        return root
    }
    
    func part1(_ input: String) -> CustomStringConvertible {
        
        return 0
        
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        return 0
    }
    
}
