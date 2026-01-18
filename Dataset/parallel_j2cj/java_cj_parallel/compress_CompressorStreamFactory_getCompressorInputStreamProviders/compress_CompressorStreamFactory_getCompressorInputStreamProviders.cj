    public func getCompressorInputStreamProviders(): Map<String, CompressorStreamProvider> {
        return if (compressorInputStreamProviders.size == 0) {
            generateProviders(compressorInputStreamProviders)
        } else {
            compressorInputStreamProviders
        }
    }