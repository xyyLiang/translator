synchronized boolean cancelLocked(IdentifiedTask task) {
    Util.d(TAG, "cancel manually: " + task.getId());
    final List<DownloadCall> needCallbackCalls = new ArrayList<>();
    final List<DownloadCall> needCancelCalls = new ArrayList<>();

    try {
        filterCanceledCalls(task, needCallbackCalls, needCancelCalls);
    } finally {
        handleCanceledCalls(needCallbackCalls, needCancelCalls);
    }

    return needCallbackCalls.size() > 0 || needCancelCalls.size() > 0;
}