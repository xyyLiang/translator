    public func getCompressorOutputStreamProviders(): Map<String, CompressorStreamProvider> {
        return if (compressorOutputStreamProviders.size == 0) {
            generateProviders(compressorOutputStreamProviders)
        } else {
            compressorOutputStreamProviders
        }
    }