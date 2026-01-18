    public func execute(listener:DownloadListener):Unit{
        this.listener = listener
        Download4cj.withs().downloadDispatcher().execute(this)
    }