    public static func pattern(regex: Regex, lookbehind: Bool, greedy: Bool): Pattern {
        return PatternImpl(regex, lookbehind, greedy, None, None)
    }