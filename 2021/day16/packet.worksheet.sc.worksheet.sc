def hexToBin(hexStr: String): String = {
    hexStr.map(
      ch => String.format("%4s", Integer.parseInt((ch.toString), 16)
      .toBinaryString).replace(' ','0'))
    .mkString("")
}

hexToBin("D2FE28")