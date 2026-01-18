    public func getResponseHeaderField(name:String):Option<String>{
         if(let Some(i) <- response){
            if(let Some(j) <- i.getHeader(name)){
                return j
            }else{
                return Option<String>.None
            }
         }else{
            return Option<String>.None
         }
    }