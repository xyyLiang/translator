        private func logWithHandler(id: String, mType: MessageType, message: String, partsCount: Int64): Unit {
                 let tag = LOG_PREFIX + DELIMITER + id + DELIMITER + mType.getValue();
                 let logger: SimpleLogger = SimpleLogger()
                 //var s = File("../stdout8.log", AccessMode.Write, OpenMode.Append)
                 //logger.setOutput(s)
                 logger.log(LogLevel.TRACE, tag+SPACE+SPACE+message+SPACE+partsCount.toString())
                 logger.flush()
                 //s.close()
        }