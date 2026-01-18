    public func append(str: String) {
        var sth: String = str
        if(sth.isEmpty()) {
            sth = "null"
        }
        let strlen: Int32 = Int32(sth.size)
        let newlen: Int32 = this.len + strlen
        if(newlen > Int32(this.buffer.capacity())) {
            this.expand(newlen)
        }

        let toChar: Array<Char> = sth.toCharArray()
        this.buffer.appendAll(toChar)
        this.len = newlen

    }
