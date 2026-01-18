    public func getString(key: String) : String {
        let v = get(key);
        match(v) {
            case Some(s:String) => s
            case _ => throw Exception("Identified object is not a String.") 
        }
    }