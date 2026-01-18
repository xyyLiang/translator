    public static UUIDType typeOf(UUID uuid)
    {
        if (uuid == null) {
            return null;
        }
        // Ok: so 4 MSB of byte at offset 6...
        long l = uuid.getMostSignificantBits();
        int typeNibble = (((int) l) >> 12) & 0xF;
        switch (typeNibble) {
        case 0:
            // possibly null?
            if (l == 0L && uuid.getLeastSignificantBits() == l) {
                return UUIDType.UNKNOWN;
            }
            break;
        case 1:
            return UUIDType.TIME_BASED;
        case 2:
            return UUIDType.DCE;
        case 3:
            return UUIDType.NAME_BASED_MD5;
        case 4:
            return UUIDType.RANDOM_BASED;
        case 5:
            return UUIDType.NAME_BASED_SHA1;
        case 6:
            return UUIDType.TIME_BASED_REORDERED;
        case 7:
            return UUIDType.TIME_BASED_EPOCH;
        case 8:
            return UUIDType.FREE_FORM;
        }
        // not recognized: return null
        return null;
    }