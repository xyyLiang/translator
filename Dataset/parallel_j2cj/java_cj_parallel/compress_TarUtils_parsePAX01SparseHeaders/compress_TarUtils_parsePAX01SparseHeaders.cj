    public static func parsePAX01SparseHeaders(sparseMap:String):ArrayList<TarArchiveStructSparse> {
        try {
            return parseFromPAX01SparseHeaders(sparseMap)
        } catch (ex:Exception ) {
            throw Exception(ex.message)
        }
    } 