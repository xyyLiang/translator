    private func rebuildJournal(): Unit {
        synchronized (lock) {
            match (journalWriter) {
                case None =>
                    ()
                case Some(s) =>
                    s.close()
            }
            
            var filejournals: File
            if (File.exists(journalFileTmp)) {
                filejournals = File(journalFileTmp, Open(true,true))
            } else {
                filejournals = File(journalFileTmp, Create(true))
            }
            var writer = ReallBufferSink(FileSink(filejournals))
            try {
                writer.write(MAGIC.toArray())
                writer.write("\n".toArray())
                writer.write(VERSION_1.toArray())
                writer.write("\n".toArray())
                writer.write("${appVersion}".toArray())
                writer.write("\n".toArray())
                writer.write("${valueCount}".toArray())
                writer.write("\n".toArray())
                writer.write("\n".toArray())
                for (entry in lruEntries.values()) {
                    match (entry.currentEditor) {
                        case Some(_) =>
                            writer.write((DIRTY+ " ").toArray())
                            writer.write(entry.key.toArray())
                            writer.write("\n".toArray())
                        case None =>
                            writer.write((CLEAN+ " ").toArray())
                            writer.write(entry.key.toArray())
                            writer.write(entry.getLengths().toArray())
                            writer.write("\n".toArray())
                    }
                }
            } finally {
                writer.close()
            }
            if (File.exists(journalFile)) {
                renameTo(journalFile, journalFileBackup, true);
            }  
            renameTo(journalFileTmp, journalFile, false);
            if (File.exists(journalFileBackup)) {
                File.delete(journalFileBackup)
            }   
            journalWriter = ReallBufferSink(FileSink(File(journalFile, Append)))
        }
    }
