    private static func parseContentRangeFoInstanceLength(contentRange:Option<String>):Int64{
        if(let Some(_) <- contentRange){
        }else{
            return Util.CHUNKED_CONTENT_LENGTH
        }
        let session: Array<String> = contentRange.getOrThrow().split("/")
        if(session.size >= 2){
            try {
                return Int64.parse(session[1])
            } catch (e:Exception) {
                Util.d(TAG, "parse instance length failed with " + contentRange.getOrThrow().toString())
            }
        }
         return -1
    }