    static func checkChecksums(result: String) {
        let length = result.size
        checkOneChecksum(result, length - 2, 20)
        checkOneChecksum(result, length - 1, 15)
    }