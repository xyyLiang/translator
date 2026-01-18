    static func closeQuietly(closeable: Resource) {
        try {
            closeable.close()
        }catch (e: Exception) {
            throw e
        }
    }