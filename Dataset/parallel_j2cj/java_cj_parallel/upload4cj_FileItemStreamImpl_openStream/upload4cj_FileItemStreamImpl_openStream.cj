    public override func openStream(): InputStream {
        if (opened) {
            throw IllegalStateException("The stream was already opened.")
        }
        return stream
    }