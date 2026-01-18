    public func get(key: String): Option<Snapshot> {
        synchronized (lock) { 
            checkNotClosed()
            validateKey(key)

            var entryso: Option<Entry> = lruEntries.get(key)
            var entry = Entry(key, this)
            match (entryso) {
                case Some(v) => 
                    entry = v
                case None => 
                    return None
            }

            if (!entry.readable) {
                return None
            }

            var ins: Array<File> = Array<File>(valueCount, item: unsafe{zeroValue<File>()})
            for (i in 0..valueCount) {
                ins[i] = entry.getCleanFile(i)
            }
            redundantOpCount++
            let jw = journalWriter.getOrThrow()
            jw.write(READ.toArray())
            jw.write(" ".toArray())
            jw.write(key.toArray())
            jw.write("\n".toArray())

            if (journalRebuildRequired()) {
                 cleanUp()
            }
            return Snapshot(key, entry.sequenceNumber, ins, entry.lengths, this)
        }
    }