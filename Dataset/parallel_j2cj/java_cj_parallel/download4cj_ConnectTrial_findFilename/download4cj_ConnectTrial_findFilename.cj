    private static func findFilename(connected:DownloadConnectionConnected):String{
        let optStr:Option<String> = connected.getResponseHeaderField(Util.CONTENT_DISPOSITION)
        if(let Some(_) <- optStr){
            return parseContentDisposition(optStr).getOrThrow()
        }else{
            return ""
        }
    }