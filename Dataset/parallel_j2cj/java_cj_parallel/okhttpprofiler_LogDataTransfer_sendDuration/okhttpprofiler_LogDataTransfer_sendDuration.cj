        public func sendDuration(id: String, duration: Int64): Unit {
            logWithHandler(id, MessageType.RESPONSE_TIME("RST"), duration.toString(), 0);
            logWithHandler(id, MessageType.RESPONSE_END("RSD"), "-->", 0);
        }