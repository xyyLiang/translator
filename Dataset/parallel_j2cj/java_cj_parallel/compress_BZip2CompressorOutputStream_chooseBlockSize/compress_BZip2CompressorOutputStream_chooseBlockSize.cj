    public static func chooseBlockSize(inputLength: Int64): Int64 {
        return if (inputLength > 0) {
            math.min((inputLength / 132000) + 1, 9)
        } else {
            MAX_BLOCKSIZE
        }
    }