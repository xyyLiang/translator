    public func getCharacterCountBits(version: Version): Int64 {
        let number = version.versionNumber
        let offset = if (number <= 9) {
            0
        } else if (number <= 26) {
            1
        } else {
            2
        }
        characterCountBitsForVersions()[offset]
    }