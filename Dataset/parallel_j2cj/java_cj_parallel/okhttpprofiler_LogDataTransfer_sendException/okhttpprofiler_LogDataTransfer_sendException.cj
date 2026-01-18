        public func sendException(id: String, ex: Exception): Unit {
            logWithHandler(id, MessageType.RESPONSE_ERROR("REE"), ex.message, 0);
        }