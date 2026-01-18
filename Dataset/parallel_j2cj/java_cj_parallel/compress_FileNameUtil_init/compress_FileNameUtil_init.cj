    public init(uncompressSuffix: Map<String, String>, defaultExtension: String) {
        this.uncompressSuffix = uncompressSuffix
        var (lc, sc, lu, su): (Int64, Int64, Int64, Int64) = (Int64.Min, Int64.Max, Int64.Min, Int64.Max)
        for ((k, v) in uncompressSuffix) {
            let cl: Int64 = k.size
            if (lc < cl) {
                lc = cl
            }
            if (sc > cl) {
                sc = cl
            }
            if (v.size > 0) {
                if (!compressSuffix.contains(v)) {
                    compressSuffix.put(v, k)
                }
                if (v.size > lu) {
                    lu = v.size
                }
                if (v.size < su) {
                    su = v.size
                }
            }
        }
        (longestCompressedSuffix, longestUncompressedSuffix) = (lc, lu)
        (shortestCompressedSuffix, shortestUncompressedSuffix) = (sc, su)
        this.defaultExtension = defaultExtension
    }