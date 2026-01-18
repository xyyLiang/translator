    func check():Unit{
        fileExist = isFileExistToResume()
        infoRight = isInfoRightToResume()
        outputStreamSupport = isOutputStreamSupportResume()
        dirty = !infoRight || !fileExist || !outputStreamSupport
    }