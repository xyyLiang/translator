    static func getRangeRightFromContentRange(contentRange:String):Int64{
        let r = CONTENT_RANGE_RIGHT_VALUE.matcher(contentRange)
        let matchDataArray:Option<Array<MatchData>> = r.findAll()
        match(matchDataArray){
            case Some(md)
                =>
                return Int64.parse(md.get(0).getOrThrow().matchStr(1))
            case None
                =>
                return -1
        }
    }