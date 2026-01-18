    public func enqueue(listener:DownloadListener):Unit{
        this.listener = listener
        Download4cj.withs().downloadDispatcher().enqueue(this)
    }