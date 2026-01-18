    public void discardProcess(@NonNull DownloadTask task) throws IOException {
        // Remove target file.
        final File file = task.getFile();
        // Do nothing, because the filename hasn't found yet.
        if (file == null) return;

        if (file.exists() && !file.delete()) {
            throw new IOException("Delete file failed!");
        }
    }