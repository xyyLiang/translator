     static func addRequestHeaderFields(userHeaderField:HashMap<String,ArrayList<String>>,connection:DownloadConnection):Unit{
        var itera:Iterator<String> =  userHeaderField.keys().iterator()
        while(true){
            var optKey:Option<String> = itera.next()
            match(optKey){
                case Some(v)=>
                      let values:ArrayList<String> = userHeaderField.get(v).getOrThrow()
                    for(value in values){
                        connection.addHeader(v, value)
                    }
                case None => break
            }
        }
    }