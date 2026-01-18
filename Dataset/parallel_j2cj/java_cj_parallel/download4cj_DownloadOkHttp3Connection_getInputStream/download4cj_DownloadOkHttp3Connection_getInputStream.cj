    public func getInputStream():Source{
        if(let Some(_) <- response){
        }else{
            throw  ReadWriteException("Please invoke execute first!")
        }
        let body:Option<ResponseBody> = response.getOrThrow().getBody()
        if(let Some(i) <- body){
            return i.getSource()
        }else{
            throw  ReadWriteException("no body found on response!")
        }
    }
