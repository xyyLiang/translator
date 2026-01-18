    @Nullable public Integer get(@NonNull DownloadTask task) {
        final Integer candidate = keyToIdMap.get(generateKey(task));
        if (candidate != null) return candidate;
        return null;
    }