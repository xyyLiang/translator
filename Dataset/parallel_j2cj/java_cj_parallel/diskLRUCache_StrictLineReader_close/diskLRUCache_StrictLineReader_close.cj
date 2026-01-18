    protected func close(): Unit {
        (this.input as Resource)?.close()
    }