    public static func parseFromPAX01SparseHeaders(sparseMap: String): ArrayList<TarArchiveStructSparse> {
        let sparseHeaders: ArrayList<TarArchiveStructSparse> = ArrayList<TarArchiveStructSparse>()
        let sparseHeaderStrings = sparseMap.split(",")
        if (sparseHeaderStrings.size % 2 == 1) {
            throw Exception("Corrupted TAR archive. Bad format in GNU.sparse.map PAX Header")
        }
        var i = 0 
        while (i < sparseHeaderStrings.size) {
            var sparseOffset: Int64 = 0
            try {
                sparseOffset = Int64.parse(sparseHeaderStrings[i])
            } catch (ex: Exception) {
                throw Exception("Corrupted TAR archive. Sparse struct offset contains a non-numeric value")
            }
            if (sparseOffset < 0) {
                throw Exception("Corrupted TAR archive. Sparse struct offset contains negative value")
            }
            var sparseNumbytes: Int64 = -1
            try {
                sparseNumbytes = Int64.parse(sparseHeaderStrings[i + 1])
            } catch (ex: Exception) {
                throw  Exception("Corrupted TAR archive. Sparse struct numbytes contains a non-numeric value")
            }
            if (sparseNumbytes < 0) {
                throw  Exception("Corrupted TAR archive. Sparse struct numbytes contains negative value")
            }
            sparseHeaders.append(TarArchiveStructSparse(sparseOffset, sparseNumbytes))
            i += 2
        }
        return sparseHeaders
    }