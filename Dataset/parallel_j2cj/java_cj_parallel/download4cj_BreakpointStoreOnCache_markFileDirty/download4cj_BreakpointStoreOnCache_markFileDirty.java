    @Override
    public boolean markFileDirty(int id) {
        if (!fileDirtyList.contains(id)) {
            synchronized (fileDirtyList) {
                if (!fileDirtyList.contains(id)) {
                    fileDirtyList.add(id);
                    return true;
                }
            }
        }
        return false;
    }