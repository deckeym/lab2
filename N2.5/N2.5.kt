
import java.util.*

fun wordConverter(fourthBlank: String): List<String> {
    val convertedWord = mutableListOf<String>()
    var blankWord = fourthBlank.toCharArray().sorted().joinToString("")
    convertedWord.add(blankWord)
    var nextPermutation = true
    while (nextPermutation) {
        val nextWord = nextPermutation(blankWord)
        if (nextWord != null) {
            convertedWord.add(nextWord)
            blankWord = nextWord
        } else {
            nextPermutation = false
        }
    }
    return convertedWord
}

fun nextPermutation(word: String): String? {
    val charArray = word.toCharArray()
    var i = charArray.size - 2
    while (i >= 0 && charArray[i] >= charArray[i + 1]) {
        i--
    }
    if (i < 0) {
        return null
    }
    var j = charArray.size - 1
    while (charArray[j] <= charArray[i]) {
        j--
    }
    charArray.swap(i, j)
    charArray.reverse(i + 1)
    return String(charArray)
}

fun stringSplitter(enterString: String): List<String> {
    val splittedString = mutableListOf<String>()
    var miniWord = ""
    for (i in enterString.indices) {
        if (enterString[i] == ' ') {
            splittedString.add(miniWord)
            miniWord = ""
        } else if (i == enterString.length - 1) {
            miniWord += enterString[i]
            splittedString.add(miniWord)
        } else {
            miniWord += enterString[i]
        }
    }
    return splittedString
}

fun translate(wordToTranslate: String, dictionary: Map<String, String>): String {
    val translatedWord = StringBuilder()
    for (char in wordToTranslate) {
        val charString = char.toString()
        translatedWord.append(dictionary[charString])
    }
    return translatedWord.toString()
}

fun unicChecker(translatedAllCombinations: List<String>, rnComb: String): String? {
    var scoreOfSames = 0
    for (word in translatedAllCombinations) {
        if (rnComb == word) {
            scoreOfSames++
        }
    }
    return if (scoreOfSames > 1) {
        null
    } else {
        rnComb
    }
}

fun main() {
    val dictionary = mapOf(
        "a" to ".-", "b" to "-...", "w" to ".--", "g" to "--.", "d" to "-..",
        "e" to ".", "v" to "...-", "z" to "--..", "i" to "..", "j" to ".---",
        "k" to "-.-", "l" to ".-..", "m" to "--", "n" to "-.", "o" to "---",
        "p" to ".--.", "r" to ".-.", "s" to "...", "t" to "-", "u" to "..-",
        "f" to "..-.", "h" to "....", "c" to "-.-.", "q" to "--.-", "y" to "-.--", "x" to "-..-"
    )

    val scanner = Scanner(System.`in`)
    print("Enter String - ")
    val enterString = scanner.nextLine()

    val splittedString = stringSplitter(enterString)

    var boolCheckOfWordLength = true
    for (thirdBlank in splittedString) {
        if (thirdBlank.length > 9) {
            boolCheckOfWordLength = false
            break
        }
    }

    var boolCheckOfStringLength = true
    if (enterString.length > 100 || enterString.length < 1) {
        boolCheckOfStringLength = false
    }

    if (!boolCheckOfStringLength || !boolCheckOfWordLength) {
        println("Please, enter correct string")
    } else {
        val allCombinations = mutableListOf<String>()
        for (fourthBlank in splittedString) {
            for (combination in wordConverter(fourthBlank)) {
                allCombinations.add(combination)
            }
        }

        val translatedAllCombinations = mutableListOf<String>()
        for (wordToTranslate in allCombinations) {
            translatedAllCombinations.add(translate(wordToTranslate, dictionary))
        }

        val unicCombinations = mutableSetOf<String>()
        for (rnComb in translatedAllCombinations) {
            val unicCombination = unicChecker(translatedAllCombinations, rnComb)
            if (unicCombination != null) {
                unicCombinations.add(unicCombination)
            }
        }

        println()
        println("All combinations and their Morze translation:")
        for (i in allCombinations.indices) {
            println("${allCombinations[i]} = (${translatedAllCombinations[i]})")
        }
        println("Unic words:")
        for (output in unicCombinations) {
            print("($output) ")
        }
        println()
        println("____________________________________________________")
        println("Value of unic words - ${unicCombinations.size}")
    }
}

fun CharArray.swap(i: Int, j: Int) {
    val temp = this[i]
    this[i] = this[j]
    this[j] = temp
}

fun CharArray.reverse(startIndex: Int) {
    var i = startIndex
    var j = this.size - 1
    while (i < j) {
        this.swap(i, j)
        i++
        j--
    }
}
