    @OverflowWrapping
    public static func typeOf(uuid: UUID): ?UUIDType {
        // Ok: so 4 MSB of byte at offset 6...
        let l: Int64 = getMostSignificantBits(uuid)
        let typeNibble: Int32 = (Int32(l) >> 12) & 0xF
        
        match (typeNibble) {
            case 0 =>
                if (l == 0 && getLeastSignificantBits(uuid) == l) {
                    return UUIDType.UNKNOWN
                }
            case 1 =>
                return UUIDType.TIME_BASED
            case 2 =>
                return UUIDType.DCE
            case 3 =>
                return UUIDType.NAME_BASED_MD5
            case 4 =>
                return UUIDType.RANDOM_BASED
            case 5 =>
                return UUIDType.NAME_BASED_SHA1
            case 6 =>
                return UUIDType.TIME_BASED_REORDERED
            case 7 =>
                return UUIDType.TIME_BASED_EPOCH
            case 8 =>
                return UUIDType.FREE_FORM
            case _ => 
                return Option<UUIDType>.None
        }
        return Option<UUIDType>.None
    }