    public func getResponseCode():Int64{
        if(let Some(i) <- response){
            return i.getCode()
        }else{
            throw  ReadWriteException("Please invoke execute first!")
        }
    }