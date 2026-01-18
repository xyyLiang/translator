    public func putFileWrapperParams(key: String, fileWrappers: ArrayList<FileWrapper>): Unit {
        if (!(key.isEmpty()) && !(fileWrappers.isEmpty())) {
            for (fileWrapper in fileWrappers) {
                put(key, fileWrapper)
            }
        }
    }