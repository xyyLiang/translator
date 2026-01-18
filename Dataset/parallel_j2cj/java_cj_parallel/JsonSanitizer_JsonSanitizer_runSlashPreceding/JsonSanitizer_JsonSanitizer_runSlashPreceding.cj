    private static func runSlashPreceding(jsonish: CharArray, pos: Int64): Int64 {
        var startOfRun = pos
        while (startOfRun >= 0 && jsonish.charAt(startOfRun) == '\\') {
            startOfRun--
        }
        return pos - startOfRun
    }