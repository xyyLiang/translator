    public static int staticCompare(UUID u1, UUID u2)
    {
        // First: major sorting by types
        int type = u1.version();
        int diff = type - u2.version();
        if (diff != 0) {
            return diff;
        }
        // Second: for time-based version, order by time stamp:
        if (type == UUIDType.TIME_BASED.raw()) {
            diff = compareULongs(u1.timestamp(), u2.timestamp());
            if (diff == 0) {
                // or if that won't work, by other bits lexically
                diff = compareULongs(u1.getLeastSignificantBits(), u2.getLeastSignificantBits());
            }
        } else {
            // note: java.util.UUIDs compares with sign extension, IMO that's wrong, so:
            diff = compareULongs(u1.getMostSignificantBits(),
                    u2.getMostSignificantBits());
            if (diff == 0) {
                diff = compareULongs(u1.getLeastSignificantBits(),
                        u2.getLeastSignificantBits());
            }
        }
        return diff;
    }