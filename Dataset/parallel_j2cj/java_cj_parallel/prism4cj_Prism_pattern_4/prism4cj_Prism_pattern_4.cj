    public static func pattern(regex: Regex, lookbehind: Bool, greedy: Bool, alias: ?String, inside: ?Grammar): Pattern {
        return PatternImpl(regex, lookbehind, greedy, alias, inside)
    }