import java.io.File

fun getInput(filename: String): List<String> {
    val content = File(filename).readLines()
    //val rows = content.size
    //val cols = content[0].length

    return content
}

fun main() {
    val input = getInput("sample.txt")
    println(input)
}