import java.io.File

fun getInput(filename: String): List<String>
 = File(filename).readLines()

fun main() {
    val input = getInput("sample.txt")
    println(input);
}