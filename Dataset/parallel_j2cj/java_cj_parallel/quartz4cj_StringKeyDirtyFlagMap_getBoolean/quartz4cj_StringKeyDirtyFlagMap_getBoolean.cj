    public func getBoolean(key: String) : Bool {
        let v = get(key);
        match(v) {
            case Some(v:Bool)  => v
            case Some(s:String) => Bool.parse(s)
            case _ => throw Exception("Identified object is not a Boolean.") 
        }
    }