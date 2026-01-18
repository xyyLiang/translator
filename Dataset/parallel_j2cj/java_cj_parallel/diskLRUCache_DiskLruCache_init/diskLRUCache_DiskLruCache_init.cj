private init(directory: Directory, appVersion: Int64, valueCount: Int64, maxSize: Int64) {
        this.directory = directory
        this.appVersion = appVersion
        this.journalFile = directory.info.path.join(JOURNAL_FILE)
        this.journalFileTmp = directory.info.path.join(JOURNAL_FILE_TEMP)
        this.journalFileBackup = directory.info.path.join(JOURNAL_FILE_BACKUP)
        this.valueCount = valueCount
        this.maxSize = maxSize

    }