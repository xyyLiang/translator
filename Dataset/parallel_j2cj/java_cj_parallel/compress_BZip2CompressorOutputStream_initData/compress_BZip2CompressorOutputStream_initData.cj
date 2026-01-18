    private func initData(): Unit {
        bsPutUByte(66) // 'B'
        bsPutUByte(90) // 'Z'

        // huffmanised magic bytes
        bsPutUByte(104) // 'h'
        bsPutUByte(48 + this.blockSize100k) // '0'

        this.combinedCRC = 0
        initBlock()
    }