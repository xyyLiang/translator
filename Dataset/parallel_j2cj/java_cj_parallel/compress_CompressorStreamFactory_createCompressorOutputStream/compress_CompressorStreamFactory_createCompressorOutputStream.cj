    public func createCompressorOutputStream(name: String, out: OutputStream): CompressorOutputStream {
        if (name.size == 0 || name == "\0") {
            throw IllegalArgumentException("The compressed name and stream cannot be empty or \\0")
        }
        let str = name.toAsciiLower()
        try {
            if (GZIP_STREAM == str) {
                return GzipCompressorOutputStream(out)
            } else if (DEFLATE_STREAM == str) {
                return DeflateCompressorOutputStream(out)
            } else if (BZIP2_STREAM == str) {
                return BZip2CompressorOutputStream(out)
            } else if (ZLIB_STREAM == str) {
                return ZLibCompressorOutputStream(out)
            }
        } catch (e: Exception) {
            throw CompressorException("Could not create CompressorOutputStream")
        }
        match (getCompressorOutputStreamProviders().get(str)) {
            case None => throw CompressorException("Compressor: ${name} not found")
            case Some(v) => v.createCompressorOutputStream(name, out)
        }
    }