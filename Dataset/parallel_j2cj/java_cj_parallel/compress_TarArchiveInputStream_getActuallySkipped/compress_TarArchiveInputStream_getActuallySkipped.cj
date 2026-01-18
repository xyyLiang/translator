    private func getActuallySkipped(available: Int64, skipped: Int64, expected: Int64): Int64 {
        (available)
        var actuallySkipped: Int64 = skipped
        if (actuallySkipped != expected) {
            throw Exception("Truncated TAR archive: ${actuallySkipped}, expected: ${expected}")
        }
        return actuallySkipped
    }