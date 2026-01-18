    init(jsonish: ?String, maximumNestingDepth!: Int64 = DEFAULT_NESTING_DEPTH, logging!: Bool = DEFAULT_LOGGING) {
        let jsonish = CharArray(jsonish ?? "null")
        SUPER_VERBOSE_AND_SLOW_LOGGING = logging
        this.maximumNestingDepth = min(max(1, maximumNestingDepth), MAXIMUM_NESTING_DEPTH)
        if (SUPER_VERBOSE_AND_SLOW_LOGGING) {
            println("\n${jsonish}\n========")
        }
        this.jsonish =  jsonish

    }