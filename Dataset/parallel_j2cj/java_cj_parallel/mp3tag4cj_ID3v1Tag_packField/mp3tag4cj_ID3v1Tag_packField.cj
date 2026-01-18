    private func packField(bytes: Array<Int8>, value: Option<String>, maxLength: Int32, offset: Int32): Unit {
        match (value) {
            case Some(x) => BufferTools.stringIntoByteBuffer(x, 0, min(x.size, Int64(maxLength)), bytes, Int64(offset))
            case None => ()
        }
    }