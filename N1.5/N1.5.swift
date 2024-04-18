import Foundation

func stringFixer(line: String) -> (String, Int) {
    var workRow = line
    var count = 0
    var globalCount = 0
    
    for i in 0..<workRow.count-1 {
        let index = workRow.index(workRow.startIndex, offsetBy: i)
        let nextIndex = workRow.index(workRow.startIndex, offsetBy: i+1)
        
        let codeSymbol = Int(workRow[index].asciiValue!)
        let nextSymbol = Character(UnicodeScalar(codeSymbol + 1)!)
        
        if workRow[index] == workRow[nextIndex] {
            count += 1
        }
        
        if count == 2 {
            workRow.insert(nextSymbol, at: nextIndex)
            count = 0
            globalCount += 1
        }
    }
    
    return (workRow, globalCount)
}

let line = "abbcdd"
let (finalRow, globalCount) = stringFixer(line: line)
print("Fixed row - \(finalRow)")
print("Value of changes - \(globalCount)")