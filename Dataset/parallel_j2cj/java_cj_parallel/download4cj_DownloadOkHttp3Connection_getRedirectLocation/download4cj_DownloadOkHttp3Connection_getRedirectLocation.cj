    public func getRedirectLocation():Option<String>{
        let priorRes:Option<Response> = response.getOrThrow().getPrevResponse()
         if(let Some(i) <- priorRes){
            if(response.getOrThrow().isSuccess() && i.isRedirect()){
                return response.getOrThrow().getRequest().getUrl().toString()
            }
        }
        return Option<String>.None
    }