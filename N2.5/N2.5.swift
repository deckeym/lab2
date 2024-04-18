import Foundation

func wordConverter(_ fourthBlank: String) -> [String] {
    var convertedWord = [String]()
    var blankWord = fourthBlank.sorted()
    convertedWord.append(String(blankWord))
    while let nextPermutation = blankWord.nextPermutation() {
        convertedWord.append(String(nextPermutation))
    }
    return convertedWord
}

func stringSplitter(_ enterString: String) -> [String] {
    var splittedString = [String]()
    var miniWord = ""
    for (index, char) in enterString.enumerated() {
        if char == " " {
            splittedString.append(miniWord)
            miniWord = ""
        } else if index == enterString.count - 1 {
            miniWord += String(char)
            splittedString.append(miniWord)
        } else {
            miniWord += String(char)
        }
    }
    return splittedString
}

func translate(_ wordToTranslate: String, dictionary: [String: String]) -> String {
    var translatedWord = ""
    for char in wordToTranslate {
        if let morseCode = dictionary[String(char)] {
            translatedWord += morseCode
        }
    }
    return translatedWord
}

func unicChecker(_ translatedAllCombinations: [String], rnComb: String) -> String {
    var scoreOfSames = 0
    for word in translatedAllCombinations {
        if rnComb == word {
            scoreOfSames += 1
        }
    }
    if scoreOfSames > 1 {
        return ""
    } else {
        return rnComb
    }
}

func main() {
    let dictionary: [String: String] = [
        "a": ".-", "b": "-...", "w": ".--", "g": "--.", "d": "-..",
        "e": ".", "v": "...-", "z": "--..", "i": "..", "j": ".---",
        "k": "-.-", "l": ".-..", "m": "--", "n": "-.", "o": "---",
        "p": ".--.", "r": ".-.", "s": "...", "t": "-", "u": "..-",
        "f": "..-.", "h": "....", "c": "-.-.", "q": "--.-", "y": "-.--", "x": "-..-"
    ]
    
    var checkOfGo = true
    while checkOfGo {
        print("Enter String - ", terminator: "")
        guard let enterString = readLine() else { return }
        
        let splittedString = stringSplitter(enterString)
        
        var boolCheckOfWordLength = true
        for word in splittedString {
            if word.count > 9 {
                boolCheckOfWordLength = false
                break
            }
        }
        
        var boolCheckOfStringLength = true
        if enterString.count > 100 || enterString.count < 1 {
            boolCheckOfStringLength = false
        }
        
        if !boolCheckOfStringLength || !boolCheckOfWordLength {
            print("Please, enter correct string")
        } else {
            var allCombinations = [String]()
            for word in splittedString {
                for combination in wordConverter(word) {
                    allCombinations.append(combination)
                }
            }
            
            var translatedAllCombinations = [String]()
            for wordToTranslate in allCombinations {
                translatedAllCombinations.append(translate(wordToTranslate, dictionary: dictionary))
            }
            
            var unicCombinations = Set<String>()
            for rnComb in translatedAllCombinations {
                let unicCombination = unicChecker(translatedAllCombinations, rnComb: rnComb)
                if unicCombination == "" {
                    continue
                } else {
                    unicCombinations.insert(unicCombination)
                }
            }
            
            print()
            print("All combinations and their Morze translation:")
            for (index, output) in allCombinations.enumerated() {
                print("\(output) = (\(translatedAllCombinations[index]))")
            }
            
            print("Unic words:")
            for output in unicCombinations {
                print("(\(output))", terminator: " ")
            }
            
            print()
            print("____________________________________________________")
            print("               Value of unic words - \(unicCombinations.count)")
        }
        checkOfGo = false
    }
}

extension Array where Element: Comparable {
    mutating func nextPermutation() -> [Element]? {
        var i = count - 2
        while i >= 0 && self[i] >= self[i + 1] {
            i -= 1
        }
        
        if i < 0 {
            return nil
        }
        
        var j = count - 1
        while self[j] <= self[i] {
            j -= 1
        }
        
        swapAt(i, j)
        reverse(from: i + 1)
        
        return self
    }
    
    private mutating func reverse(from index: Int) {
        var i = index
        var j = count - 1
        while i < j {
            swapAt(i, j)
            i += 1
            j -= 1
        }
    }
}

main()
