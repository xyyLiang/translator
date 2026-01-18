    public static func minify(jsonish: ?String, maximumNestingDepth!: Int64 = DEFAULT_NESTING_DEPTH, logging!: Bool = DEFAULT_LOGGING, force!: Bool = false): String {
        let s = JsonSanitizer(jsonish, maximumNestingDepth: maximumNestingDepth, logging: logging)
        s.sanitizeJsonish()
        return minify_(CharArray(s.toArray()), force)
    }