    public func getRequestProperties():HashMap<String, ArrayList<String>>{
        var hashMapList:HashMap<String, ArrayList<String>> = HashMap<String, ArrayList<String>>()
        var header:Option<Header> = Option<Header>.None
        if(let Some(i) <- request){
             header = i.getHeaders()
        }else{
             header = requestBuilder.build().getHeaders()
        }
        var itera:Iterator<(String, ArrayList<String>)> =  header.getOrThrow().iterator()
        while(true){
            var optKey:Option<(String, ArrayList<String>)> = itera.next()
            match(optKey){
                case Some(v)=>
                    var key = v[0]
                    var value = v[1]
                    hashMapList.put(key,value)
                case None => break
            }
        }
        return hashMapList
    }