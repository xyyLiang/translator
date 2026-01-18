    private static func isOneOf(ch: Char, chs: Array<Char>): Bool {
        if(!chs.isEmpty()) {
            let arr: Array<Char> = chs
            let len = chs.size

            for (i in 0..len) {

                let ch2 = arr[i]
                if(ch == ch2) {
                    return true
                }
            }
        }

        return false
    }