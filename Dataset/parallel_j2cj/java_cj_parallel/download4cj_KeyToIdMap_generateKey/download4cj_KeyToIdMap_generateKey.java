    String generateKey(@NonNull DownloadTask task) {
        return task.getUrl() + task.getUri() + task.getFilename();
    }