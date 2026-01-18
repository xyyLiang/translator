    private func moveToFrontCodeAndSend(): Unit {
        bsW(24, this.data.origPtr)
        generateMTFValues()
        sendMTFValues()
    }