    public func remove(key: String): Bool {
        synchronized (lock) {
            checkNotClosed()
            validateKey(key)
            match (lruEntries.get(key)) {
                case Some(k) => 
                    match (k.currentEditor) {
                        case Some(_) => return false
                        case None => ()
                    }
                    for (i in 0..valueCount) {
                        let file = k.getCleanFile(i)
                        file.close()
                        deleteIfExists(file.info.path)
                        size -= k.lengths[i]
                        k.lengths[i] = 0
                    }
                    redundantOpCount++
                    var jw = wirteSink(journalWriter)
                    jw.write(REMOVE.toArray())
                    jw.write(" ".toArray())
                    jw.write(key.toArray())
                    jw.write("\n".toArray())
                    lruEntries.remove(key)

                    if (journalRebuildRequired()) {
                        cleanUp()
                    }

                    return true
                case None => return false
            }
        }
    }