    public static func pattern(regex: Regex, lookbehind: Bool): Pattern {
        return PatternImpl(regex, lookbehind, false, None, None)
    }