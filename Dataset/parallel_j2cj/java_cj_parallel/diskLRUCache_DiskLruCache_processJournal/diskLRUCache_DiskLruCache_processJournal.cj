private func processJournal(): Unit {
        deleteIfExists(journalFileTmp)
        var str = ArrayList<String>()
        for (key in lruEntries.keys()) {
            let entry = lruEntries[key]
            match (entry.currentEditor) {
                case None =>
                    for (i in 0..valueCount) {
                        size += entry.lengths[i]
                    }
                case Some(_) =>
                    entry.currentEditor = None
                    for (i in 0..valueCount) {
                        let cleanfiles = entry.getCleanFile(i)
                        cleanfiles.close()
                        let dirtyfiles = entry.getDirtyFile(i)
                        dirtyfiles.close()
                        deleteIfExists(cleanfiles.info.path)
                        deleteIfExists(dirtyfiles.info.path)
                    }
                    str.append(key)
            }
        }
        lruEntries.removeAll(str)
    }