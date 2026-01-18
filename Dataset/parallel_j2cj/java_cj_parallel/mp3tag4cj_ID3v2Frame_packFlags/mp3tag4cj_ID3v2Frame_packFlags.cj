    private func packFlags(): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(2, {_ => 0})
        bytes[0] = BufferTools.setBit(bytes[0], Int64(PRESERVE_TAG_BIT), preserveTag)
        bytes[0] = BufferTools.setBit(bytes[0], Int64(PRESERVE_FILE_BIT), preserveFile)
        bytes[0] = BufferTools.setBit(bytes[0], Int64(READ_ONLY_BIT), readOnly)
        bytes[1] = BufferTools.setBit(bytes[1], Int64(GROUP_BIT), group)
        bytes[1] = BufferTools.setBit(bytes[1], Int64(COMPRESSION_BIT), compression)
        bytes[1] = BufferTools.setBit(bytes[1], Int64(ENCRYPTION_BIT), encryption)
        bytes[1] = BufferTools.setBit(bytes[1], Int64(UNSYNCHRONISATION_BIT), unsynchronisation)
        bytes[1] = BufferTools.setBit(bytes[1], Int64(DATA_LENGTH_INDICATOR_BIT), dataLengthIndicator)
        return bytes
    }