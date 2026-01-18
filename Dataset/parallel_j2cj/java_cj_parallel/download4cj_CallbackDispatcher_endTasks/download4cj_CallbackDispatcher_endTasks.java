    public void endTasks(@NonNull final Collection<DownloadTask> completedTaskCollection,
                         @NonNull final Collection<DownloadTask> sameTaskConflictCollection,
                         @NonNull final Collection<DownloadTask> fileBusyCollection) {
        if (completedTaskCollection.size() == 0 && sameTaskConflictCollection.size() == 0
                && fileBusyCollection.size() == 0) {
            return;
        }

        Util.d(TAG, "endTasks completed[" + completedTaskCollection.size()
                + "] sameTask[" + sameTaskConflictCollection.size()
                + "] fileBusy[" + fileBusyCollection.size() + "]");

        if (completedTaskCollection.size() > 0) {
            final Iterator<DownloadTask> iterator = completedTaskCollection.iterator();
            while (iterator.hasNext()) {
                final DownloadTask task = iterator.next();
                if (!task.isAutoCallbackToUIThread()) {
                    task.getListener().taskEnd(task, EndCause.COMPLETED, null);
                    iterator.remove();
                }
            }
        }