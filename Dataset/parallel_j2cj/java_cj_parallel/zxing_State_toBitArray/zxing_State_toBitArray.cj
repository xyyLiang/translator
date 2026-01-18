    func toBitArray(text: Array<UInt8>): BitArray {
        let symbols = ArrayList<Token>()
        var token: ?Token = endBinaryShift(text.size).token
        while (let Some(t) = token) {
            symbols.append(t)
            token = t.previous
        }
        let bitArray = BitArray()
        for (i in (symbols.size - 1)..-1) {
            symbols[i].appendTo(bitArray, text)
        }
        bitArray
    }