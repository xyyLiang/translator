    @OverflowWrapping
    static func staticCompare(u1: UUID, u2: UUID): Int32 {
        // First: major sorting by types
        let types: Int32 = u1.version()
        var diffs: Int32 = types - u2.version()
        if (diffs != 0) {
            return diffs
        }
        // Second: for time-based variant, order by time stamp:
        if (Int64(types) == UUIDType.TIME_BASED.raw()) {
            diffs = compareULongs(u1.timestamp(), u2.timestamp())
            if (diffs == 0) {
                // or if that won't work, by other bits lexically
                diffs = compareULongs(UUIDUtil.getLeastSignificantBits(u1), UUIDUtil.getLeastSignificantBits(u2))
            }
        } else {
            // note: java.util.UUIDs compares with sign extension, IMO that's wrong, so:
            diffs = compareULongs(UUIDUtil.getMostSignificantBits(u1),
                    UUIDUtil.getMostSignificantBits(u2))
            if (diffs == 0) {
                diffs = compareULongs(UUIDUtil.getLeastSignificantBits(u1),
                        UUIDUtil.getLeastSignificantBits(u2))
            }
        }
        return diffs
    }