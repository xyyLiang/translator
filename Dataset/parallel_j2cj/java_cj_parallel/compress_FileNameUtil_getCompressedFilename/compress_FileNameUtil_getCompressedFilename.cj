    public func getCompressedFilename(fileName: String): String {
        let lower = fileName.toLower().toRuneArray()
        let n: Int64 = lower.size

        let longest: Int64 = math.min(longestUncompressedSuffix, n - 1)
        for (i in shortestUncompressedSuffix..=longest) {
            let suffix: ?String = compressSuffix.get(String(lower[n - i..]))
            if (suffix != None) {
                return fileName[..n - i] + suffix.getOrThrow()
            }
        }
        return fileName + defaultExtension
    }