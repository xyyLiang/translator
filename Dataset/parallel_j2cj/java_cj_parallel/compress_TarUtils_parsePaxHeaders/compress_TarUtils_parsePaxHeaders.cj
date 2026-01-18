    @OverflowWrapping
    public static func parsePaxHeaders(inputStream: InputStream,
                                    sparseHeaders: ?ArrayList<TarArchiveStructSparse>, 
                                    globalPaxHeaders: Map<String, String>): Map<String, String> {
        return parsePaxHeaders(inputStream, sparseHeaders, globalPaxHeaders, -1)      
    }