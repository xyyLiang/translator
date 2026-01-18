    public func parseTarHeader(header: Array<Byte>): Unit {
        try {
            this.parseTarEncoding(header, TarUtils.DEFAULT_ENCODING)
        } catch (ex:Exception) {
            try {
                this.parseTarEncoding(header, TarUtils.DEFAULT_ENCODING, oldStyle: true, lenient: false)
            } catch (ex2:Exception) {
                throw  Exception("not really possible")
            }
        }
    }