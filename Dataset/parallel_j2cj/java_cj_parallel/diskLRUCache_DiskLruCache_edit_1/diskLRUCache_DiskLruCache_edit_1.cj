    protected func edit(key: String, expectedSequenceNumber: Int64): Option<Editor> {
        synchronized (lock) {
            checkNotClosed()
            validateKey(key)
            var entrys: Option<Entry> = lruEntries.get(key)
            var entry = Entry(key, this)
            var hasNull: Bool = false
            match (entrys) {
                case Some(v) => 
                    entry = v
                case None => 
                    hasNull = true
            }
            if (expectedSequenceNumber != ANY_SEQUENCE_NUMBER && (hasNull || entry.sequenceNumber != expectedSequenceNumber)) {
                return None
            }

            if (hasNull) {
                entry = Entry(key, this)
                lruEntries.put(key, entry)
            } 
            match (entry.currentEditor) {
                case Some(_) => 
                    return None
                case None => 
                    ()
            }

            var editor = Editor(entry,this)
            entry.currentEditor = Option<Editor>.Some(editor)

            let jw = journalWriter.getOrThrow()
            jw.write(DIRTY.toArray())
            jw.write(" ".toArray())
            jw.write(key.toArray())
            jw.write("\n".toArray())
            jw.flush()
            return Option<Editor>.Some(editor)
        }
    }