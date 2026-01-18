public func versionForNumber(versionNumber: Int64): Version {
    if (versionNumber < 1 || versionNumber > 40) {
        throw IllegalArgumentException()
    }
    return Version.VERSIONS[versionNumber - 1]
}