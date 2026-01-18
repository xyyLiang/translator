    public func getDouble(key: String) : Float64 {
        let v = get(key);
        match(v) {
            case Some(v:Float64)  => v
            case Some(s:String) => Float64.parse(s)
            case _ => throw Exception("Identified object is not a Double.") 
        }
    }