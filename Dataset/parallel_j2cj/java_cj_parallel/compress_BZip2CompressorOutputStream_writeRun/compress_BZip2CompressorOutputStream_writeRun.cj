    private func writeRun(): Unit {
        let lastShadow: Int64 = this.last

        if (lastShadow < this.allowableBlockSize) {
            let currentCharShadow: Int64 = this.currentChar
            let dataShadow: BZip2OutputStreamData = this.data
            dataShadow.inUse[currentCharShadow] = true
            let ch: Byte = UInt8(currentCharShadow & 0xff)

            var runLengthShadow: Int64 = this.runLength
            this.crc.updateCRC(UInt8(currentCharShadow & 0xff), runLengthShadow)

            match (runLengthShadow) {
                case 1 =>
                    dataShadow.block[lastShadow + 2] = ch
                    this.last = lastShadow + 1
                case 2 =>
                    dataShadow.block[lastShadow + 2] = ch
                    dataShadow.block[lastShadow + 3] = ch
                    this.last = lastShadow + 2
                case 3 =>
                    let block: Array<Byte> = dataShadow.block
                    block[lastShadow + 2] = ch
                    block[lastShadow + 3] = ch
                    block[lastShadow + 4] = ch
                    this.last = lastShadow + 3
                case _ =>
                    runLengthShadow -= 4
                    dataShadow.inUse[runLengthShadow] = true
                    let block: Array<Byte> = dataShadow.block
                    block[lastShadow + 2] = ch
                    block[lastShadow + 3] = ch
                    block[lastShadow + 4] = ch
                    block[lastShadow + 5] = ch
                    block[lastShadow + 6] = UInt8(runLengthShadow & 0xff)
                    this.last = lastShadow + 5
            }
        } else {
            endBlock()
            initBlock()
            writeRun()
        }
    }