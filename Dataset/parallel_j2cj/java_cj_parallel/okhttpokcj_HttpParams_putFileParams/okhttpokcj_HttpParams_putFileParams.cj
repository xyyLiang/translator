    public func putFileParams(key: String, files: ArrayList<FileInfo>): Unit {
        if (!(key.isEmpty()) && !(files.isEmpty())) {
            for (file in files) {
                put(key, file);
            }
        }
    }