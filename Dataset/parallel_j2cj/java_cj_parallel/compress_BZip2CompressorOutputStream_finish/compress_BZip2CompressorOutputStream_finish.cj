    func finish(): Unit {
        if (!closed) {
            closed = true
            try {
                if (this.runLength > 0) {
                    writeRun()
                }
                this.currentChar = -1
                endBlock()
                endCompression()
            } finally {
                // this.out = None
                // this.blockSorter = None
                // this.data = None
            }
        }
    }