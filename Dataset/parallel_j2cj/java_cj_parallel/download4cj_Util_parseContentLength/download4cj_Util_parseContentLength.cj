     static func parseContentLength(contentLength:Option<String>):Int64{
        if(let Some(_) <- contentLength){
        }else{
            return CHUNKED_CONTENT_LENGTH
        }
        try {
            return Int64.parse(contentLength.getOrThrow())
        } catch (ignored:Exception) {
            Util.d("Util", "parseContentLength failed parse for '" + contentLength.getOrThrow() + "'")
        }

        return CHUNKED_CONTENT_LENGTH

    }