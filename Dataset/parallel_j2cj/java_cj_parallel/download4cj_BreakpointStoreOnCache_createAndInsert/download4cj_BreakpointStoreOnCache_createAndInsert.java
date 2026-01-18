    @NonNull @Override
    public BreakpointInfo createAndInsert(@NonNull DownloadTask task) {
        final int id = task.getId();

        BreakpointInfo newInfo = new BreakpointInfo(id, task.getUrl(), task.getParentFile(),
                task.getFilename());
        synchronized (this) {
            storedInfos.put(id, newInfo);
            unStoredTasks.remove(id);
        }
        return newInfo;
    }