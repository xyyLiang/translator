    public EthernetAddress(String addrStr)
        throws NumberFormatException
    {
        int len = addrStr.length();
        long addr = 0L;
        
        /* Ugh. Although the most logical format would be the 17-char one
         * (12 hex digits separated by colons), apparently leading zeroes
         * can be omitted. Thus... Can't just check string length. :-/
         */
        for (int i = 0, j = 0; j < 6; ++j) {
            if (i >= len) {
                // Is valid if this would have been the last byte:
                if (j == 5) {
                    addr <<= 8;
                    break;
                }
                throw new NumberFormatException("Incomplete ethernet address (missing one or more digits");
            }
            
            char c = addrStr.charAt(i);
            ++i;
            int value;
            
            // The whole number may be omitted (if it was zero):
            if (c == ':') {
                value = 0;
            } else {
                // No, got at least one digit?
                if (c >= '0' && c <= '9') {
                    value = (c - '0');
                } else if (c >= 'a' && c <= 'f') {
                    value = (c - 'a' + 10);
                } else if (c >= 'A' && c <= 'F') {
                    value = (c - 'A' + 10);
                } else {
                    throw new NumberFormatException("Non-hex character '"+c+"'");
                }
                
                // How about another one?
                if (i < len) {
                    c = addrStr.charAt(i);
                    ++i;
                    if (c != ':') {
                        value = (value << 4);
                        if (c >= '0' && c <= '9') {
                            value |= (c - '0');
                        } else if (c >= 'a' && c <= 'f') {
                            value |= (c - 'a' + 10);
                        } else if (c >= 'A' && c <= 'F') {
                            value |= (c - 'A' + 10);
                        } else {
                            throw new NumberFormatException("Non-hex character '"+c+"'");
                        }
                    }
                }
            }

            addr = (addr << 8) | value;
            
            if (c != ':') {
                if (i < len) {
                    if (addrStr.charAt(i) != ':') {
                        throw new NumberFormatException("Expected ':', got ('"+ addrStr.charAt(i)+"')");
                    }
                    ++i;
                } else if (j < 5) {
                    throw new NumberFormatException("Incomplete ethernet address (missing one or more digits");
                }
            }
        }
        _address = addr;
    }
   