    protected func completeEdit(editor: Editor, success: Bool): Unit {
        synchronized (lock) {
            let entry = editor.entry
            if (!refEq(entry.currentEditor.getOrThrow(), editor)) { throw  Exception("editor is others") }
            if (success && !entry.readable) {
                for (i in 0..valueCount) {
                    if (!editor.written.getOrThrow()[i]) {
                        editor.abort()
                        throw DiskLruCacheException("newly created entry didn't create value for index ${i}")
                    }
                    if (!File.exists(entry.getDirtyFile(i).info.path.toString())) {
                        editor.abort()
                        return
                    }
                }
            }
            for (i in 0..valueCount) {
                let dirty = entry.getDirtyFile(i)
                if (success && File.exists(dirty.info.path.toString()) ) {
                    let clean = entry.getCleanFile(i)
                    File.move(dirty.info.path.toString(),clean.info.path.toString(), true)
                    let oldLength = entry.lengths[i]
                    let newLength = FileInfo(clean.info.path.toString()).length
                    clean.close()
                    entry.lengths[i] = newLength
                    size = size - oldLength + newLength
                } else if (!success) { deleteIfExists(dirty.info.path) }
            }
            redundantOpCount++
            entry.currentEditor = None
            var jw = wirteSink(journalWriter)
            if (entry.readable || success) {
                entry.readable = true
                jw.write((CLEAN + " ").toArray())
                jw.write(entry.key.toArray())
                jw.write(entry.getLengths().toArray())
                jw.write("\n".toArray())
                if (success) {
                    entry.sequenceNumber = nextSequenceNumber
                    nextSequenceNumber++
                }
            } else {
                lruEntries.remove(entry.key)
                jw.write((REMOVE + " ").toArray())
                jw.write(entry.key.toArray())
                jw.write("\n".toArray())
            }
            jw.flush()
            if (size > maxSize || journalRebuildRequired()) { cleanUp() }
        }
    }
