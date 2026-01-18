    public func isCompressedFilename(fileName: String): Bool {
        let lower = fileName.toLower().toRuneArray()
        let n: Int64 = lower.size
        let value = math.min(longestCompressedSuffix + 1, n)
        for (i in shortestCompressedSuffix..value) {
            if (uncompressSuffix.contains(String(lower[n - i..]))) {
                return true
            }
        }
        return false
    }