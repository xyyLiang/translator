    public static func copy(inputStream: Option<InputStream>, outputStream: Option<OutputStream>,
        closeOutputStream: Bool, buffer: Array<UInt8>): Int64 {
        var output: Option<OutputStream> = outputStream
        var input: Option<InputStream> = inputStream
        try {
            var total = 0
            while (true) {
                let res = input.getOrThrow().read(buffer)
                if (res <= 0) { //原来-1 兼容其他流改<=0
                    break
                }
                if (res > 0) {
                    total += res
                    if (let Some(i) <- output) {
                        let bytesRes = buffer.slice(0, res)
                        i.write(bytesRes)
                    }
                }
            }

            if (let Some(j) <- output) {
                if (!closeOutputStream) {
                    j.flush()
                }
            }

            let conInput = input as ItemInputStream
            if (let Some(k) <- conInput) {
                k.close()
            }
            return total
        } finally {
            input = Option<InputStream>.None
            output = Option<OutputStream>.None
        }
    }