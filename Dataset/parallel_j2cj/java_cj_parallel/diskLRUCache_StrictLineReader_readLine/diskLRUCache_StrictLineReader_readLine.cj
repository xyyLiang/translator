    public func readLine(): String {
        synchronized (lock) {
            if (buf.isEmpty()) {
                throw DiskLruCacheException("lineReader is closed")
            }

            if (pos >= end) {
                fillBuf()
            }

            for (i in pos..end) {
                if (buf[i] == LF) {
                    var lineEnd = -1
                    if (i != pos && buf[i - 1] == CR) {
                        lineEnd = i-1
                    }else {
                        lineEnd = i
                    }
                    let res = unsafe { String.fromUtf8Unchecked(buf.slice(pos,lineEnd -pos)) }
                    pos = i + 1
                    return res
                }
            }

            var out: ByteArrayStream = ByteArrayStream(end - pos + 80)

            while (true) {
                out.write(buf.slice(pos,end -pos))
                end = -1
                fillBuf()
                for (i in pos..end) {
                    if (buf[i] == LF) {
                        if (i != pos) {
                            out.write(buf.slice(pos,i -pos))
                        }
                        pos = i+1
                        var bytes: Array<Byte> = out.bytes()
                        return bytes.toString()
                    }
                }
            }
            return ""
        }
        
    }