    private static func parseContentDisposition(contentDisposition:Option<String>):Option<String>{
        if(let Some(_) <- contentDisposition){
        }else{
            return Option<String>.None
        }
        try{
            var fileName:Option<String> = Option<String>.None
            var isM:Bool = false
            var m0 = CONTENT_DISPOSITION_QUOTED_PATTERN.matcher(contentDisposition.getOrThrow())
            var matchData0 = m0.find()
            match(matchData0){
                case Some(s) =>
                    if (s.groupNumber() > 0) {
                        fileName = s.matchStr(1)
                    }else{
                        fileName = Option<String>.None
                    }
                case None =>
                    isM = true
                }
            if(let Some(_) <- fileName){
                if(fileName.getOrThrow().contains("../")){
                    throw  DownloadSecurityException("The filename [" + fileName.getOrThrow() + "] from the response is not allowable, because it contains '../', which can raise the directory traversal vulnerability");
                }
            }
            return fileName
        }catch(ex:IllegalStateException){
        }
        return Option<String>.None
    }