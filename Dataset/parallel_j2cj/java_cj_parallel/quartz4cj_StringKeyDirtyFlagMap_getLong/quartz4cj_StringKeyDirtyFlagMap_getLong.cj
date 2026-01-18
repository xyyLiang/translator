    public func getLong(key: String) : Int64 {
        let v = get(key);
        match(v) {
            case Some(v:Int64)  => v
            case Some(s:String) => Int64.parse(s)
            case _ => throw Exception("Identified object is not a Long.") 
        }
    }