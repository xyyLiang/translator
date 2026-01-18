     public static func enqueues(tasks:Array<DownloadTask>,listener:DownloadListener):Unit{
        for(task in tasks){
            task.listener = listener
        }
        Download4cj.withs().downloadDispatcher().enqueue(tasks)
    }
