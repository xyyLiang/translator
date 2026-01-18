    @Override
    public synchronized int findOrCreateId(@NonNull DownloadTask task) {
        final Integer candidate = keyToIdMap.get(task);
        if (candidate != null) return candidate;

        final int size = storedInfos.size();
        for (int i = 0; i < size; i++) {
            final BreakpointInfo info = storedInfos.valueAt(i);
            if (info != null && info.isSameFrom(task)) {
                return info.id;
            }
        }

        final int unStoredSize = unStoredTasks.size();
        for (int i = 0; i < unStoredSize; i++) {
            final IdentifiedTask another = unStoredTasks.valueAt(i);
            if (another == null) continue;
            if (another.compareIgnoreId(task)) return another.getId();
        }

        final int id = allocateId();
        unStoredTasks.put(id, task.mock(id));
        keyToIdMap.add(task, id);
        return id;
    }