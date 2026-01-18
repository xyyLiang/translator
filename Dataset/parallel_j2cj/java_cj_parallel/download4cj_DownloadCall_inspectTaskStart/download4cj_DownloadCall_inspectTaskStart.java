    private void inspectTaskStart() {
        store.onTaskStart(task.getId());
        OkDownload.with().callbackDispatcher().dispatch().taskStart(task);
    }