    private func write0(b: Byte) {
        var write_b: Int64 = Int64(b)
        if (this.currentChar != -1) {
            if (this.currentChar == write_b) {
                this.runLength++
                if (this.runLength > 254) {
                    writeRun()
                    this.currentChar = -1
                    this.runLength = 0
                }
            } else {
                writeRun()
                this.runLength = 1
                this.currentChar = write_b
            }
        } else {
            this.currentChar = write_b
            this.runLength++
        }
    }