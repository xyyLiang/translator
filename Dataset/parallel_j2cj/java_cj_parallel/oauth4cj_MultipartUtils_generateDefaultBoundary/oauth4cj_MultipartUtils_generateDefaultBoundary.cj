    public static func generateDefaultBoundary(): String {
        let res: Duration = DateTime.now() - DateTime.of(year: 1970, month: Month.January, dayOfMonth: 1)
        let timeMillis: Int64 = res.toMilliseconds()
        return "----OAuth4cj----" + timeMillis.toString()
    }