        private func fastLog(id: String, mType: MessageType, message: String): Unit {
            let tag = LOG_PREFIX + DELIMITER + id + DELIMITER + mType.getValue();
            printLog(tag,message)
        }