    public static UUID uuid(String id)
    {
        if (id == null) {
            throw new NullPointerException();
        }
        if (id.length() != 36) {
            throw new NumberFormatException("UUID has to be represented by the standard 36-char representation");
        }

        long lo, hi;
        lo = hi = 0;
        
        for (int i = 0, j = 0; i < 36; ++j) {
         
            // Need to bypass hyphens:
            switch (i) {
            case 8:
            case 13:
            case 18:
            case 23:
                if (id.charAt(i) != '-') {
                    throw new NumberFormatException("UUID has to be represented by the standard 36-char representation");
                }
                ++i;
            }
            int curr;
            char c = id.charAt(i);

            if (c >= '0' && c <= '9') {
                curr = (c - '0');
            } else if (c >= 'a' && c <= 'f') {
                curr = (c - 'a' + 10);
            } else if (c >= 'A' && c <= 'F') {
                curr = (c - 'A' + 10);
            } else {
                throw new NumberFormatException("Non-hex character at #"+i+": '"+c
                        +"' (value 0x"+Integer.toHexString(c)+")");
            }
            curr = (curr << 4);

            c = id.charAt(++i);

            if (c >= '0' && c <= '9') {
                curr |= (c - '0');
            } else if (c >= 'a' && c <= 'f') {
                curr |= (c - 'a' + 10);
            } else if (c >= 'A' && c <= 'F') {
                curr |= (c - 'A' + 10);
            } else {
                throw new NumberFormatException("Non-hex character at #"+i+": '"+c
                        +"' (value 0x"+Integer.toHexString(c)+")");
            }
            if (j < 8) {
             hi = (hi << 8) | curr;
            } else {
             lo = (lo << 8) | curr;
            }
            ++i;
        }  
        return new UUID(hi, lo);
    }