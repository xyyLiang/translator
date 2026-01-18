    private func parseToken(ch1:Char,ch2:Char): Option<String> {
        this.i1 = this.pos
        this.i2 = this.pos
        while (hasChar()) {
            if(this.pos >= this.chars.size){
                throw IndexOutOfBoundsException("offset is bigger than charArray size")
            }
            var ch: Char = this.chars[this.pos]
            if (isOneOf(ch, ch1,ch2)) {
                break
            }
            this.i2++
            this.pos++
        }
        return getToken(false)
    }