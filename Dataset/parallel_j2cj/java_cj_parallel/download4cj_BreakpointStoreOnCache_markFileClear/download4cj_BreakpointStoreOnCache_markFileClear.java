    @Override public boolean markFileClear(int id) {
        synchronized (fileDirtyList) {
            return fileDirtyList.remove(Integer.valueOf(id));
        }
    }