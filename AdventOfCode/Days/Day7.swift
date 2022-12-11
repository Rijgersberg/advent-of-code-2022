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
            } else {
                self.children.append(possibleNewFolder)
            }
            return possibleNewFolder
        }
        
        var totalSize: Int {
            return size + children.map{$0.totalSize}.reduce(0, +)
        }
        
        func allSizes() -> [Int] {
            if self.children.count == 0 { // is a file, and they don't count for the dirs
                return [0]
            }
            
            var sizes = self.children.flatMap{$0.allSizes()}
            sizes.append(self.totalSize)
            sizes.sort()
            return sizes
        }
        
        func nSmaller(than maxSize: Int) -> (n: Int, sumSize: Int) {
            if self.children.count == 0 { // is a file, and they don't count for the dirs
                return(0, 0)
            }
            
            let childResults = children.map{$0.nSmaller(than: maxSize)}
            
            let childN = childResults.map{$0.n}.reduce(0, +)
            let childSize = childResults.map{$0.sumSize}.reduce(0, +)
            
            let ownSize = self.totalSize
            
            return (ownSize <= maxSize ? 1 + childN : childN,
                    ownSize <= maxSize ? ownSize + childSize : childSize)
        }
    }
    
    func parse(_ input: String) -> FileFolder {
        let input = input.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let root = FileFolder(name: "", parent: nil, size: 0)
        var pwd = root
        
        for line in input.components(separatedBy: .newlines)[1...] {  // first one is "$ cd /"
            let parts = line.split(separator: " ")
            
            if parts[0] == "$" {
                if parts[1] == "cd" { // "$ cd name"
                    let name = String(parts[2])
                    
                    if name == ".." {
                        pwd = pwd.parent!
                    } else {
                        pwd = pwd.retreiveOrAdd(name: name, size: 0)
                    }
                    
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
        let root = parse(input)
        
        let (_, size) = root.nSmaller(than: 100000)
        return size
    }
    
    func part2(_ input: String) -> CustomStringConvertible {
        let root = parse(input)
        
        let free = 70000000 - root.totalSize
        let needed = 30000000 - free
        
        let sizes = root.allSizes()
        return sizes.first{$0 > needed}!
    }
    
}
