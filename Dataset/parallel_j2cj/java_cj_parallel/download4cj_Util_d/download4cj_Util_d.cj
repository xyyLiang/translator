     static func d(tag:String,msg:String):Unit{
        let logger:SimpleLogger = SimpleLogger()
        logger.log(LogLevel.DEBUG,tag+"--"+msg)
    }