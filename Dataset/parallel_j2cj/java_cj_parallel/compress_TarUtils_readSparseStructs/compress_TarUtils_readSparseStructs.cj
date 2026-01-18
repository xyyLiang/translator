    static func readSparseStructs(buffer: Array<Byte>, offset: Int64, entries: Int64): ArrayList<TarArchiveStructSparse> {
        let sparseHeaders: ArrayList<TarArchiveStructSparse> = ArrayList<TarArchiveStructSparse>()
        for (i in 0..entries) {
            try {
                let sparseHeader: TarArchiveStructSparse = parseSparse(buffer,
                    offset + i * (TarConstants.SPARSE_OFFSET_LEN + TarConstants.SPARSE_NUMBYTES_LEN))

                if (sparseHeader.getOffset()<0) {
                    throw Exception("Corrupted TAR archive, sparse entry with negative offset")
                }
                if (sparseHeader.getNumbytes()<0) {
                    throw Exception("Corrupted TAR archive, sparse entry with negative numbytes")
                }
                sparseHeaders.append(sparseHeader)
            } catch (ex: IllegalArgumentException) {
                // thrown internally by parseOctalOrBinary
                throw Exception("Corrupted TAR archive, sparse entry is invalid")
            }
        }
        return sparseHeaders
    }