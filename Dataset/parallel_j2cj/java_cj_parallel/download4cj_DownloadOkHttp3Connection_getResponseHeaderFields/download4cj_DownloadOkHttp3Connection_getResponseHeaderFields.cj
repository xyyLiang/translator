    public func getResponseHeaderFields():Option<HashMap<String,ArrayList<String>>>{
        if(let Some(i) <- response){
            var header:Header = i.getHeaders()
            var hashMapList:HashMap<String, ArrayList<String>> = HashMap<String, ArrayList<String>>()
            var itera:Iterator<(String, ArrayList<String>)> =  header.iterator()
            while(true){
            var optKey:Option<(String, ArrayList<String>)> = itera.next()
                match(optKey){
                    case Some(v)=>
                        var key = v[0]
                        var value = v[1]
                        hashMapList.put(key,value)
                    case None =>
                        break
                }
            }
            return hashMapList
        }else{
            return Option<HashMap<String,ArrayList<String>>>.None
        }
    }