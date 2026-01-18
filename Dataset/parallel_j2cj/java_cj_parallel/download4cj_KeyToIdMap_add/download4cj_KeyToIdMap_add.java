    public void add(@NonNull DownloadTask task, int id) {
        final String key = generateKey(task);
        keyToIdMap.put(key, id);
        idToKeyMap.put(id, key);
    }