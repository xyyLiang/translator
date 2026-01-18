    public static func matchGenreDescription(description: Option<String>): Int32 {
        if (description != Option<String>.None && description.getOrThrow().size > 0) {
            var times: Int32 = 0
            for (gen in GENRES) {
                if (gen.toAsciiLower() == description.getOrThrow().toAsciiLower()) {
                    return times
                }
                times++
            }
        }
        return -1
    }