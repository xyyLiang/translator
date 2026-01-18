    func getVersion(versionSize: VersionSize): Version {
        match (versionSize) {
            case SMALL => versionForNumber(9)
            case MEDIUM => versionForNumber(26)
            case LARGE => versionForNumber(40)
        }
    }