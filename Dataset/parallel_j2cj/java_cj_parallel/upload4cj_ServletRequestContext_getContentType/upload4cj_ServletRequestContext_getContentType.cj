    public override func getContentType(): Option<String> {
        let conTypeList = request.headers.get(FileUploadBase.CONTENT_TYPE)
        if(conTypeList.size == 0){
            return Option<String>.None
        }else{
            let contentType = request.headers.get(FileUploadBase.CONTENT_TYPE).iterator().next().getOrThrow()
            return Option<String>.Some(contentType)
        }
    }