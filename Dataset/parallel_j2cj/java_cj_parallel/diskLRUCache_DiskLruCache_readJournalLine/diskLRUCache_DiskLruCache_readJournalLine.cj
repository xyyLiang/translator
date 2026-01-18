    private func readJournalLine(line: String): Unit {
        var firstSpace = -1
        try {
            firstSpace = line.indexOf(" ").getOrThrow()
        } catch (e: Exception) {
            throw DiskLruCacheException("unexpected journal line: ${line}")
        }
        let keyBegin = firstSpace + 1
        var key: String = ""
        var secondSpace = -1
        var secondSpaceds: Bool = false
        try {
            secondSpace = line.indexOf(" ", keyBegin).getOrThrow()
        } catch (e: Exception) {
            secondSpaceds = true
        }
        if (secondSpaceds) {
            key = line[keyBegin..]
            if (firstSpace == REMOVE.size && line.startsWith(REMOVE)) {
                lruEntries.remove(key)
                return
            }
        } else {
            key = line[keyBegin..secondSpace]
        }

        var entry = Entry("",this)
        try {
            entry = lruEntries.get(key).getOrThrow()
        } catch (e: Exception) {
            entry = Entry(key,this)
            lruEntries.put(key, entry)
        }

        if (secondSpace != -1 && firstSpace == CLEAN.size && line.startsWith(CLEAN)) {
            let parts: Array<String> = line[(secondSpace + 1)..].split(" ")
            entry.readable = true
            entry.currentEditor = None
            entry.setLengths(parts)
        } else if (secondSpace == -1 && firstSpace == DIRTY.size && line.startsWith(DIRTY)) {
            entry.currentEditor = Editor(entry,this)
        } else if (secondSpace == -1 && firstSpace == READ.size && line.startsWith(READ)) {
          
        } else {
            throw DiskLruCacheException("unexpected journal line: ${line}")
        }
    }