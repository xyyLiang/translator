    protected func getLongNameData(): ?Array<Byte> {
        let longName: ByteArrayStream = ByteArrayStream()
        var length: Int64 = this.read(this.smallBuf)
        while (length > 0) {
            longName.write(this.smallBuf[0..length])
            length = this.read(this.smallBuf)
        }
        this.getNextEntry()
        match(this.currEntry) {
            case None => return None
            case _ => ()
        }
        var longNameData: Array<Byte> = longName.bytes()
        length = longNameData.size
        while (length > 0 && longNameData[length - 1] == 0) {
            length--
        }
        if (length != longNameData.size) {
            let l: Array<Byte> = Array<Byte>(length, item: 0)
            ArrayCopy(longNameData, 0, l, 0, length)
            longNameData = l
        }
        return longNameData
    }