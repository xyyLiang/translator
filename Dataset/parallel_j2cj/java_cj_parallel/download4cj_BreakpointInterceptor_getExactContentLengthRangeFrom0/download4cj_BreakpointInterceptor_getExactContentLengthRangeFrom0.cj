    func getExactContentLengthRangeFrom0(connected:DownloadConnectionConnected):Int64{
        let contentRangeField:Option<String> = connected.getResponseHeaderField(Util.CONTENT_RANGE)
        var contentLength:Int64 = -1
        if (!Util.isEmpty(contentRangeField)){
            let rightRange:Int64 = getRangeRightFromContentRange(contentRangeField.getOrThrow())
            if (rightRange > 0){
                contentLength = rightRange + 1
            }
        }
        return contentLength
    }