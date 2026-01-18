    public func release():Unit{
        request = Option<Request>.None
        if(let Some(i) <- response){
            i.close()
        }
        response = Option<Response>.None
    }