    private func readJournal(): Unit {
        var reader: StrictLineReader =  StrictLineReader(File(journalFile, Open(true,true)), Util.US_ASCII)

        try {
            let magic = reader.readLine()
            let version = reader.readLine()
            let appVersionString = reader.readLine()
            let valueCountString = reader.readLine()
            let blank = reader.readLine()
            if (MAGIC != (magic) || VERSION_1 != (version) || ("${appVersion}") != (appVersionString) || ("${valueCount}") != (valueCountString) || "" != (blank)) {
                
                throw DiskLruCacheException("unexpected journal header: [${magic}, ${version}, ${valueCountString}, ${blank}]")
            }

            var lineCount = 0

            while (true) {
                try {
                    readJournalLine(reader.readLine())
                    lineCount++
                } catch (e: Exception) {
                    break
                }
            }
            redundantOpCount = lineCount - lruEntries.size
        } finally {
            reader.close()
        }
    }