    @Override public synchronized void remove(int id) {
        storedInfos.remove(id);
        if (unStoredTasks.get(id) == null) sortedOccupiedIds.remove(Integer.valueOf(id));
        keyToIdMap.remove(id);
    }