import Foundation

func reglamentCheck(num: Int) -> Bool {
    var prevDigit = num % 10
    var num = num / 10
    while num != 0 {
        let currentDigit = num % 10
        if currentDigit <= prevDigit {
            prevDigit = currentDigit
            num /= 10
        } else {
            return false
        }
    }
    return true
}

func numReverser(numblank: Int) -> Int {
    if reglamentCheck(num: numblank) {
        var reversedNum = 0
        var numblank = numblank
        while numblank != 0 {
            reversedNum = reversedNum * 10 + numblank % 10
            numblank /= 10
        }
        return reversedNum
    } else {
        return 0
    }
}

print("Enter the number of numbers : ")
if let n = Int(readLine()!), n > 0 {
    print("Enter \(n) numbers:")
    for _ in 0..<n {
        if let number = Int(readLine()!) {
            print(numReverser(numblank: number), terminator: " ")
        }
    }
    print()
}