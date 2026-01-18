public func provisionalVersionForDimension(dimension: Int64): Version {
    if (dimension % 4 != 1) {
        throw FormatException()
    }
    try {
        return versionForNumber((dimension - 17) / 4)
    } catch (e: IllegalArgumentException) {
        throw FormatException()
    }
}