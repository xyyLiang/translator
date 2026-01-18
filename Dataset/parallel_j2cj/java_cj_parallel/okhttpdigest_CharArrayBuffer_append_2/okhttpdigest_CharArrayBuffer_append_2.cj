    public func append(b: CharArrayBuffer, off: Int32, len: Int32) {
         if(!b.isEmpty()) {
             this.append(b.buffer, off, len)
         }
    }