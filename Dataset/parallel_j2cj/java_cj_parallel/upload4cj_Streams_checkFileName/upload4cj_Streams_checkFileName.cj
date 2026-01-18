    public static func checkFileName(fileName: Option<String>): Option<String> {
        if (let Some(i) <- fileName) {
            let index: Option<Int64> = i.indexOf('\u{0}')
            if (let Some(_) <- index) {
                let sb: StringBuilder = StringBuilder()
                for (k in 0..i.size) {
                    let c: Char = i.toRuneArray().get(k).getOrThrow()
                    if (c == '\u{0}') {
                        sb.append("\\0")
                    } else {
                        sb.append(c)
                    }
                }
                throw InvalidFileNameException("Invalid file name: " + sb.toString())
            }
        }
        return fileName
    }