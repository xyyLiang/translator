public func convertUPCEtoUPCA(upce: String): String {
    let upceChars = Array<Char>(6, {n => upce.charAt(n + 1)})
    let result = StringBuilder()
    result.append(upce.charAt(0))
    let lastChar = upceChars[5]
    match (lastChar) {
        case '0' | '1' | '2' =>
            result.append(upceChars[0..2])
            result.append(lastChar)
            result.append("0000")
            result.append(upceChars[2..5])
        case '3' =>
            result.append(upceChars[0..3])
            result.append("00000")
            result.append(upceChars[3..5])
        case '4' =>
            result.append(upceChars[0..4])
            result.append("00000")
            result.append(upceChars[4])
        case _ =>
            result.append(upceChars[0..5])
            result.append("0000")
            result.append(lastChar)
    }
    if (upce.size >= 8) {
        result.append(upce.charAt(7))
    }
    result.toString()
}