    static func getEncodedData(correctedBits: Array<Bool>): String {
        let endIndex = correctedBits.size
        var latchTable = Table.UPPER
        var shiftTable = Table.UPPER
        let result = StringBuilder()
        let decodedBytes = ByteArrayStream()

        var index = 0
        while (index < endIndex) {
            if (shiftTable == Table.BINARY) {
                if (endIndex - index < 5) {
                    break
                }
                var length = readCode(correctedBits, index, 5)
                index += 5
                if (length == 0) {
                    if (endIndex - index < 11) {
                        break
                    }
                    length = readCode(correctedBits, index, 11) + 31
                    index += 11
                }
                for (charCount in 0..length) {
                    if (endIndex - index < 8) {
                        index = endIndex
                        break
                    }
                    decodedBytes.write([UInt8(readCode(correctedBits, index, 8))])
                    index += 8
                }
                shiftTable = latchTable
            } else {
                let size = if (shiftTable == Table.DIGIT) {
                    4
                } else {
                    5
                }
                if (endIndex - index < size) {
                    break
                }
                let code = readCode(correctedBits, index, size)
                index += size
                let str = getCharacter(shiftTable, code)
                if ("FLG(n)" == str) {
                    if (endIndex - index < 3) {
                        break
                    }
                    var n = readCode(correctedBits, index, 3)
                    index += 3
                    result.appendFromUtf8(decodedBytes.bytes())
                    decodedBytes.clear()
                    match (n) {
                        case 0 => result.append(Char(29))
                        case 7 => throw FormatException()
                        case _ =>
                            var eci = 0
                            if (endIndex - index < 4 * n) {
                                break
                            }
                            n--
                            while (n > 0) {
                                let nextDigit = readCode(correctedBits, index, 4)
                                index += 4
                                if (nextDigit < 2 || nextDigit > 11) {
                                    throw FormatException()
                                }
                                eci = eci * 10 + (nextDigit - 2)
                                n--
                            }
                    }
                    shiftTable = latchTable
                } else if (str.startsWith("CTRL_")) {
                    latchTable = shiftTable
                    shiftTable = getTable(str.charAt(5))
                    if (str.charAt(6) == 'L') {
                        latchTable = shiftTable
                    }
                } else {
                    let b = str.toUtf8Array()
                    let t = decodedBytes.bytes()
                    decodedBytes.clear()
                    decodedBytes.write(b)
                    if (t.size > 0) {
                        decodedBytes.write(t)
                    }
                    shiftTable = latchTable
                }
            }
        }

        result.appendFromUtf8(decodedBytes.bytes())
        result.toString()
    }