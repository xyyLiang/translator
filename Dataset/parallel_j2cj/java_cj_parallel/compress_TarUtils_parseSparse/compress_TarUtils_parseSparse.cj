    public static func parseSparse(buffer: Array<Byte>, offset: Int64): TarArchiveStructSparse {
        let sparseOffset: Int64 = parseOctalOrBinary(buffer, offset, TarConstants.SPARSE_OFFSET_LEN)
        let sparseNumbytes: Int64 = parseOctalOrBinary(buffer, offset + TarConstants.SPARSE_OFFSET_LEN, TarConstants.SPARSE_NUMBYTES_LEN)
        return TarArchiveStructSparse(sparseOffset, sparseNumbytes)
    }