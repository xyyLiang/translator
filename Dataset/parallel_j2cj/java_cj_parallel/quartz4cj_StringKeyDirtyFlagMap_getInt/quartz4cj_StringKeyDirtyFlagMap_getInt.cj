    public func getInt(key: String) : Int32 {
        let v = get(key);
        match(v) {
            case Some(v:Int32)  => v
            case Some(s:String) => Int32.parse(s)
            case _ => throw Exception("Identified object is not a Integer.") 
        }
    }