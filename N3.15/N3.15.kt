fun reglamentCheck(num: Int): Boolean {
    var prevDigit = num % 10
    var number = num / 10
    while (number != 0) {
        val currentDigit = number % 10
        if (currentDigit <= prevDigit) {
            prevDigit = currentDigit
            number /= 10
        } else {
            return false
        }
    }
    return true
}

fun numReverser(numBlank: Int): Int {
    if (reglamentCheck(numBlank)) {
        var reversedNum = 0
        var number = numBlank
        while (number != 0) {
            reversedNum = reversedNum * 10 + number % 10
            number /= 10
        }
        return reversedNum
    } else {
        return 0
    }
}

fun main() {
    val defaultCount = 4
    var n = defaultCount

    repeat(n) {
        val number = readLine()!!.toInt()
        print("${numReverser(number)} ")
    }
    println()
}