    public func readStamp(): Int64{
        var size: Int64 = mFile.length
        if (size == 0) {
            logger.warn("Missing or empty file, can not read timestamp value");
            return READ_ERROR;
        }
        
        if (size > 100) {
            size = 100
        }

        var uArray: Array<UInt8> = Array<UInt8>(mFile.length, item: 0)
        try {
            mFile.read(uArray)
        } catch (ie: FSException | IllegalArgumentException) {
            logger.error("file Failed to read ${mFile.length} bytes")
            return READ_ERROR
        }

        var charArray: Array<Char> = Array<Char>(uArray.size, item: Char(0))

        for( i in 0..uArray.size) {
            // uint8 -> char
           charArray[i] = Char(uArray[i])
        }
        // charArray -> String
        var dataStr: String = String(charArray)
        dataStr = dataStr.trim()

        var result: Int64 = -1
        var err: String = ""

        if ((!dataStr.startsWith("[0")) || (dataStr.size < 3) || (dataStr.toRuneArray()[2].toLowerCase() != 'x')) {
            err = "does not start with '[0x' prefix"
        } else {
            let ix: Int64 = dataStr.indexOf("]", 3).getOrThrow()
            if (ix <= 0) {
                err = "does not end with ']' marker"
            } else {
                var hex: String = dataStr[3..ix]
                if (hex.size > 16) {
                    err = "length of the (hex) timestamp too long; expected 16"
                } else {
                    try {
                        result = Int64.parse("0x" + hex.toString())
                    } catch (iae: IllegalArgumentException) {
                        err = "parse fail"
                    }
                }
            }
        }
        if (result < 0) {
            logger.error("timestamp file contents wrong timestamp ${err}");
            return READ_ERROR;
        }
        mLastTimestamp = result
        return result
    }