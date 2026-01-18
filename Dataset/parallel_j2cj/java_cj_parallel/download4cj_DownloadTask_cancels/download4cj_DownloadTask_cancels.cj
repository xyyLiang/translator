    public static func cancels(tasks:Array<DownloadTask>):Unit{
        Download4cj.withs().downloadDispatcher().cancel(tasks)
    }