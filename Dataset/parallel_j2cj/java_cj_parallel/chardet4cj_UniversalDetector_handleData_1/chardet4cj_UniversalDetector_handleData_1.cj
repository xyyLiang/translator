    private func processData(buf: Array<Byte>, off: Int32, len: Int32) {
        let maxPos: Int32 = off + len
        if (maxPos <= 0) { throw ChardetException("this length is null") }
        for(i in off..maxPos) {
            var c = buf[Int64(i)] & 0xFF
            if ((c & 0x80) != 0 && c != 0xA0) {
                if (this.inputState != InputState.HIGHBYTE) {
                    this.inputState = InputState.HIGHBYTE
                    match (this.escCharsetProber) {
                        case None => ()
                        case Some(_) => this.escCharsetProber = Option<CharsetProber>.None
                    }
                    if (this.probers.isEmpty()) {
                        this.probers.append(MBCSGroupProber())
                    }
                }
            } else {
                if (this.inputState == InputState.PURE_ASCII && (c == 0x1B || (c == 0x7B && this.lastChar == 0x7E))) {
                    this.inputState = InputState.ESC_ASCII
                }
                if (this.inputState == InputState.PURE_ASCII && onlyPrintableASCII) {
                 onlyPrintableASCII = (c >= 0x20 && c <= 0x7e) || c == 0x0A  || c == 0x0D || c== 0x09
                }
                this.lastChar = buf[Int64(i)]
            }
        }
    }

    public func handleData(buf: Array<Byte>, off: Int32, len: Int32){
        if (this.done) {
            return
        }
        if (len > 0) {
            this.gotData = true
        }
        if (buf.size == 0) {
            throw ChardetException("this buf is empty")
        }
        if (this.start) {
            this.start = false;
            if (len > 3) {
                var detectedBOM: String = detectCharsetFromBOM(buf, off)
                if (!detectedBOM.isEmpty()) {
                 this.detectedCharset = detectedBOM
                    this.done = true
                    return
                }
            }
        }
        processData(buf, off, len)
        var st: ProbingState = ProbingState.NOT_ME
        if (this.inputState == InputState.ESC_ASCII) {
            match (this.escCharsetProber) {  
                case None => this.escCharsetProber = Option<CharsetProber>.Some(EscCharsetProber())
                case Some(_) => ()
            }
            st = this.escCharsetProber.getOrThrow().handleData(buf, off, len)
            if (st == ProbingState.FOUND_IT) {
                this.done = true
                this.detectedCharset = this.escCharsetProber.getOrThrow().getCharSetName()
            }
        } else if (this.inputState == InputState.HIGHBYTE) {
            for(i in 0..this.probers.size){
                st = this.probers[i].handleData(buf, off, len)
                if (st == ProbingState.FOUND_IT) {
                    this.done = true
                    this.detectedCharset = this.probers[i].getCharSetName()
                    return
                }
            }
        } else { return }
    }