    @OverflowWrapping 
    public static func nameUUIDFromBytes(name: Array<Int8>): UUID {
        var md: MessageDigest = MessageDigest(DigestType.MD5)
        var md5Bytes: Array<Int8> = md.digest(input: name)
        md5Bytes[6]  &= Int8(0x0f)  /* clear version        */
        md5Bytes[6]  |= Int8(0x30)  /* set to version 3     */
        md5Bytes[8]  &= Int8(0x3f)  /* clear variant        */
        md5Bytes[8]  |= Int8(0x80)  /* set to IETF variant  */
        return UUID(Int8ToUInt8(md5Bytes))
    }