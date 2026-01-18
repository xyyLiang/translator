    public static func getGzipStreamContents(ins: InputStream): String {
        let dins: DecompressInputStream = DecompressInputStream(ins, wrap: GzipFormat, bufLen: 4096)
        let res: String = getStreamContents(dins, isGzipStream: true)
        dins.close()
        return res
    }