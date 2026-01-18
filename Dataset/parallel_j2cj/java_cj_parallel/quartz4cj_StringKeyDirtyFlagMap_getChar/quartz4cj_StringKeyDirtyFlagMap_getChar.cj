    public func getChar(key: String) : Char {
        let v = get(key);
        match(v) {
            case Some(v:Char)  => v
            case Some(s:String) => s.toRuneArray()[0]
            case _ => throw Exception("Identified object is not a Character.") 
        }
    }