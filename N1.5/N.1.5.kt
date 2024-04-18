import java.util.*

fun stringFixer(line: String): Pair<String, Int> {
    var workRow = line
    var addedCount = 0
    for (i in 0 until workRow.length - 1) {
        val codeSymbol = workRow[i].code
        val nextSymbol = (codeSymbol + 1).toChar()
        if (workRow[i] == workRow[i + 1]) {
            workRow = workRow.substring(0, i + 1) + nextSymbol + workRow.substring(i + 1)
            addedCount++ // Увеличиваем счетчик добавленных символов
        }
    }
    return Pair(workRow, addedCount)
}

fun main() {
    val scanner = Scanner(System.`in`)
    print("Enter row, please - ")
    val line = scanner.nextLine()
    val (finalRow, addedCount) = stringFixer(line)
    println("\nFixed row - $finalRow\nValue of changes - $addedCount")
}
