    public static func sanitize(jsonish: ?String, maximumNestingDepth!: Int64 = DEFAULT_NESTING_DEPTH, logging!: Bool = DEFAULT_LOGGING): String {
        let s = JsonSanitizer(jsonish, maximumNestingDepth: maximumNestingDepth, logging: logging)
        s.sanitizeJsonish()
        return s.toString()
    }