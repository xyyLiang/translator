    public func writeEntryHeader(outbuf: Array<Byte>): Unit {
        try {
            this.writeEntryHeader(outbuf, TarUtils.DEFAULT_ENCODING, false)
        } catch (ex: Exception) {
            try {
                this.writeEntryHeader(outbuf, TarUtils.FALLBACK_ENCODING, false)
            } catch (ex2: Exception) {
                throw  Exception(ex2.message)
            }
        }
    }