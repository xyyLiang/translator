    public func getUncompressedFilename(fileName: String): String {
        let lower = fileName.toLower().toRuneArray()
        let n: Int64 = lower.size
        let value = math.min(longestCompressedSuffix + 1, n)
        for (i in shortestCompressedSuffix..value) {
            let suffix: ?String = uncompressSuffix.get(String(lower[n - i..]))
            if (suffix != None) {
                return fileName[..n - i] + suffix.getOrThrow()
            }
        }
        return fileName
    }