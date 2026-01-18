    private void inspectTaskEnd(DownloadCache cache, @NonNull EndCause cause,
                                @Nullable Exception realCause) {
        // non-cancel handled on here
        if (cause == EndCause.CANCELED) {
            throw new IllegalAccessError("can't recognize cancelled on here");
        }

        synchronized (this) {
            if (canceled) return;
            finishing = true;
        }

        store.onTaskEnd(task.getId(), cause, realCause);
        if (cause == EndCause.COMPLETED) {
            store.markFileClear(task.getId());
            OkDownload.with().processFileStrategy()
                    .completeProcessStream(cache.getOutputStream(), task);
        }

        OkDownload.with().callbackDispatcher().dispatch().taskEnd(task, cause, realCause);
    }