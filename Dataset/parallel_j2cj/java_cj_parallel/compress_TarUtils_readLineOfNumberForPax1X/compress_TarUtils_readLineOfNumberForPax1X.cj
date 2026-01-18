    @OverflowWrapping
    private static func readLineOfNumberForPax1X(inputStream: InputStream): Array<Int64> {
        var numberValue: Int64
        var result: Int64 = 0
        var bytesRead: Int64 = 0
        let arr = Array<Byte>(1, item: 0)
        numberValue = inputStream.read(arr)
        while (arr[0] != UInt8(UInt32('\n'))) {
            bytesRead += 1
            if (numberValue == 0) {
                throw Exception("Unexpected EOF when reading parse information of 1.X PAX format")
            }
            if (Int64(arr[0]) < Int64(UInt32('0')) || Int64(arr[0]) > Int64(UInt32('9'))) {
                throw Exception("Corrupted TAR archive. Non-numeric value in sparse headers block")
            }
            result = result * 10 + Int64(Int64(arr[0]) - Int64(UInt32('0')))
            numberValue = inputStream.read(arr)
        }
        bytesRead += 1
        return [result, bytesRead]
    }