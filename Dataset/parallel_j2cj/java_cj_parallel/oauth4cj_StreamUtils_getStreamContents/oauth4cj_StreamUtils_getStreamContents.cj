    public static func getStreamContents(ins: InputStream, isGzipStream!: Bool = false): String {
        let buffer: Array<Byte> = Array<Byte>(DEFAULT_NUM, item: 0)
        let out: ByteArrayStream = ByteArrayStream(DEFAULT_NUM * 5)
        try {
            var len: Int64 = 0
            while (true) {
                len = ins.read(buffer)
                if (len > 0) {
                    out.write(buffer[0..len])
                }
                if (len < DEFAULT_NUM) {
                    break
                }
            }
        } catch (e: Exception) {
            throw OAuth4cjException("Read from InputStream failed." + e.message)
        }
        if (out.length <= 0 && isGzipStream) {
            throw OAuth4cjException("Unable to obtain decompressed string from an empty InputStream.")
        }
        if (!isGzipStream && out.length <= 0) {
            throw OAuth4cjException("Cannot get String from a Null InputStream.")
        }
        let res: Array<Byte> = out.readToEnd()

        out.clear()
        return String.fromUtf8(res)
    }