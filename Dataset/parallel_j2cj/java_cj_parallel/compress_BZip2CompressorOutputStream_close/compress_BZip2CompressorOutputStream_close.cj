    public func close(): Unit {
        if (!closed) {
            try {
                finish()
            } finally {
                (this.out as Resource)?.close()
            }
        }
    }