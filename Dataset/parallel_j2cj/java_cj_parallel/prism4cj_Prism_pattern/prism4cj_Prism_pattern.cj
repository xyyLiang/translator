    public static func pattern(regex: Regex): Pattern {
        return PatternImpl(regex, false, false, None, None)
    }