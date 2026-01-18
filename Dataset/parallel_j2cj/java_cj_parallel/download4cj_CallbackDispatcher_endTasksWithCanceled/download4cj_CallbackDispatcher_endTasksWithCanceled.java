    public void endTasksWithCanceled(@NonNull final Collection<DownloadTask> canceledCollection) {
        if (canceledCollection.size() <= 0) return;

        Util.d(TAG, "endTasksWithCanceled canceled[" + canceledCollection.size() + "]");

        final Iterator<DownloadTask> iterator = canceledCollection.iterator();
        while (iterator.hasNext()) {
            final DownloadTask task = iterator.next();
            if (!task.isAutoCallbackToUIThread()) {
                task.getListener().taskEnd(task, EndCause.CANCELED, null);
                iterator.remove();
            }
        }

        uiHandler.post(new Runnable() {
            @Override public void run() {
                for (DownloadTask task : canceledCollection) {
                    task.getListener().taskEnd(task, EndCause.CANCELED, null);
                }
            }
        });
    }