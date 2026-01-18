    static func getVersionSize(version: Version): VersionSize {
        if (version.versionNumber <= 9) {
            VersionSize.SMALL
        } else if (version.versionNumber <= 26) {
            VersionSize.MEDIUM
        } else {
            VersionSize.LARGE
        }
    }
