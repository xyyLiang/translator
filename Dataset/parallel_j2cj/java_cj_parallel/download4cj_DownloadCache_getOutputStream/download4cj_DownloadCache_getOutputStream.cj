    func getOutputStream():MultiPointOutputStream{
        if(let Some(_) <- outputStream){
        }else{
            throw IllegalArgumentException()
        }
        return outputStream.getOrThrow()
    }