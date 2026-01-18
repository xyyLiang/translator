    private func largeLog(id: String, mType: MessageType, content: String): Unit {
        let contentLength = content.size
        if (contentLength > LOG_LENGTH) {
            let parts = contentLength / LOG_LENGTH
            for (i in 0..parts) {
                let start = i * LOG_LENGTH
                var end = start + LOG_LENGTH
                if (end > contentLength) {
                    let printLength = contentLength+LOG_LENGTH-end
                    logWithHandler(id, mType, content.substring(start, printLength), parts);
                }else{
                    let printLength  = LOG_LENGTH
                    logWithHandler(id, mType, content.substring(start, LOG_LENGTH), parts);
                }
            }
        } else {
            logWithHandler(id, mType, content, 0);
        }
    }