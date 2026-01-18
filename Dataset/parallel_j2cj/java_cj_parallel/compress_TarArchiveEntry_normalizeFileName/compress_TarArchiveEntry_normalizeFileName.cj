    private static func normalizeFileName(fileNameLet: String, preserveAbsolutePath: Bool): String {
        var fileName = fileNameLet
        if (!preserveAbsolutePath) {
            let osname: String = CURRENT_OS

            if (osname != "") {
                if (osname.startsWith("windows")) {
                    if (fileName.size > 2) {
                        let ch1 = fileName[0]
                        let ch2 = fileName[1]
                        if (ch2 == ':' && (ch1 >= 'a' && ch1 <= 'z' || ch1 >= 'A' && ch1 <= 'Z')) {
                            fileName = String(fileName.toRuneArray()[2..])  // D: C: c: 
                        }
                    }
                } else if (osname.contains("netware")) {
                    let fileNameChars = fileName.toRuneArray()
                    for (i in 0..fileNameChars.size where fileNameChars[i] == ':') {
                        fileName = String(fileName.toRuneArray()[i+1..])
                        break
                    }
                }
            }
        }
        while (!preserveAbsolutePath && fileName.startsWith("/")) {
            fileName = String(fileName.toRuneArray()[1..])
        }
        return fileName
    }