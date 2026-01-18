    public init(addrStr:String){

        let len = addrStr.size
        var addr:Int64 = 0
        var i = 0
        for(j in 0..6){

            if(i >= len){
                if(j == 5){
                    addr = addr << 8
                    break
                }
                throw NumberFormatException("Incomplete ethernet address (missing one or more digits")
            }

            var c : Char = addrStr.toRuneArray()[i]
            i++
            var value:Int64 = 0
            if(c == ':'){
                value = 0
            }else{
                if(c >= '0' && c <= '9'){
                    value = Int64(charToUInt32(c)-charToUInt32('0'))
                }else if (c >= 'a' && c <= 'f') {
                    value = Int64((charToUInt32(c) - charToUInt32('a') + 10))
                }else if (c >= 'A' && c <= 'F') {
                    value = Int64((charToUInt32(c) - charToUInt32('A') + 10))
                }else{
                     throw NumberFormatException("Non-hex character '"+c.toString()+"'")
                }

                if(i < len){
                    c = addrStr.toRuneArray()[i]
                    i++
                    if(c != ':'){
                         value = (value << 4)
                        if (c >= '0' && c <= '9') {
                            value |= Int64((charToUInt32(c) - charToUInt32('0')))
                        }else if (c >= 'a' && c <= 'f') {
                            value |= Int64((charToUInt32(c) - charToUInt32('a') + 10))
                        }else if (c >= 'A' && c <= 'F') {
                            value |= Int64((charToUInt32(c) - charToUInt32('A') + 10))
                        }else{
                            throw NumberFormatException("Non-hex character '"+c.toString()+"'")
                        }
                    }
                }
            }

            addr = (addr << 8) | value

            if (c != ':') {
                if (i < len) {
                    if (addrStr.toRuneArray()[i] != ':') {
                        throw NumberFormatException("Expected ':', got ('"+ addrStr.toRuneArray()[i].toString()+"')")
                    }
                    i++
                }else if(j < 5){
                    throw NumberFormatException("Incomplete ethernet address (missing one or more digits")
                }
            }
        }
        _address = addr
    }