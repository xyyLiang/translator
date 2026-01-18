    public void check() {
        fileExist = isFileExistToResume();
        infoRight = isInfoRightToResume();
        outputStreamSupport = isOutputStreamSupportResume();
        dirty = !infoRight || !fileExist || !outputStreamSupport;
    }