    private func getRecord(): ?Array<Byte> {
        var headerBuf: ?Array<Byte> = this.readRecord()
        this.setAtEOF(this.isEOFRecord(headerBuf))
        if (this.isAtEOF()) {
            match (headerBuf) {
                case None => ()
                case _ => 
                    this.tryToConsumeSecondEOFRecord()
                    this.consumeRemainderOfLastBlock()
                    headerBuf = None
            }
        }
        return headerBuf
    }