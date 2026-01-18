    public static UUID constructUUID(UUIDType type, byte[] uuidBytes)
    {
        // first, ensure type is ok
        int b = uuidBytes[BYTE_OFFSET_TYPE] & 0xF; // clear out high nibble
        b |= type.raw() << 4;
        uuidBytes[BYTE_OFFSET_TYPE] = (byte) b;
        // second, ensure variant is properly set too
        b = uuidBytes[UUIDUtil.BYTE_OFFSET_VARIATION] & 0x3F; // remove 2 MSB
        b |= 0x80; // set as '10'
        uuidBytes[BYTE_OFFSET_VARIATION] = (byte) b;
        return uuid(uuidBytes);
    }