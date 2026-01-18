    public static void enqueue(DownloadTask[] tasks, DownloadListener listener) {
        for (DownloadTask task : tasks) {
            task.listener = listener;
        }
        OkDownload.with().downloadDispatcher().enqueue(tasks);
    }