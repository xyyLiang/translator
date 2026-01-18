    public init(headerBuf: Array<Byte>) {
        var offset: Int64 = 0
        this.sparseHeaders = TarUtils.readSparseStructs(headerBuf, 0, TarConstants.SPARSE_HEADERS_IN_EXTENSION_HEADER)
        offset += TarConstants.SPARSELEN_GNU_SPARSE
        this.isExtended = TarUtils.parseBoolean(headerBuf, offset)
    }