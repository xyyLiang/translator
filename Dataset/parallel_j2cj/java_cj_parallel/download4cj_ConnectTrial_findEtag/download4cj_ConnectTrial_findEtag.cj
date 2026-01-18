    private static func findEtag(connected:DownloadConnectionConnected):String{
        try{
            return connected.getResponseHeaderField(Util.ETAG).getOrThrow()
        }catch(e:Exception){
            return ""
        }
    }