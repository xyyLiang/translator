    private static func isAcceptRanges(connected:DownloadConnectionConnected):Bool{
        if (connected.getResponseCode() == Util.HTTP_PARTIAL){
            return true
        }
        try{
            let acceptRanges:String = connected.getResponseHeaderField(Util.ACCEPT_RANGES).getOrThrow()
            return "bytes".equals(acceptRanges)
        }catch(e:Exception){
            return false
        }
    }