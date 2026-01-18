    private static func findInstanceLength(connected:DownloadConnectionConnected):Int64{
        let instanceLength:Int64 = parseContentRangeFoInstanceLength(connected.getResponseHeaderField(Util.CONTENT_RANGE))
        if (instanceLength != Util.CHUNKED_CONTENT_LENGTH){
            return instanceLength
        }
        return Util.CHUNKED_CONTENT_LENGTH
    }