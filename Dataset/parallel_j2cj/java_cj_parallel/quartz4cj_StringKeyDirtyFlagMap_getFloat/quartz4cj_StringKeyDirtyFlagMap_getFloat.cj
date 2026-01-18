    public func getFloat(key: String) : Float32 {
        let v = get(key);
        match(v) {
            case Some(v:Float32)  => v
            case Some(s:String) => Float32.parse(s)
            case _ => throw Exception("Identified object is not a Float.") 
        }
    }