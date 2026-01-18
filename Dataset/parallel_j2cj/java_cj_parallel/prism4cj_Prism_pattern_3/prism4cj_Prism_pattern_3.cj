    public static func pattern(regex: Regex, lookbehind: Bool, greedy: Bool, alias: ?String): Pattern {
        return PatternImpl(regex, lookbehind, greedy, alias, None)
    }