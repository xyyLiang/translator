    public static void cancel(DownloadTask[] tasks) {
        OkDownload.with().downloadDispatcher().cancel(tasks);
    }