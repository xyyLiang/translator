    public func readBodyData(outputStream: Option<OutputStream>): Int64 {
        return Streams.copy(newInputStream(), outputStream, false)
    }