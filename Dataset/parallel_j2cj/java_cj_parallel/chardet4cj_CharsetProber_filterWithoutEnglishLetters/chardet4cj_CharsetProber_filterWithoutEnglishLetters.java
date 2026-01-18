 public ByteBuffer filterWithoutEnglishLetters(final byte[] buf, int offset, int length) {
        ByteBuffer out = ByteBuffer.allocate(length);
        
        boolean meetMSB = false;
        byte c;

        int prevPtr = offset;
        int curPtr = offset;
        int maxPtr = offset + length;
        
        for (; curPtr<maxPtr; ++curPtr) {
            c = buf[curPtr];
            if (!isAscii(c)) {
                meetMSB = true;
            } else if (isAsciiSymbol(c)) {
                // current char is a symbol, most likely a punctuation.
                // we treat it as segment delimiter
                if (meetMSB && curPtr > prevPtr) {
                    // this segment contains more than single symbol,
                    // and it has upper ASCII, we need to keep it
                    out.put(buf, prevPtr, (curPtr-prevPtr));
                    out.put((byte)ASCII_SP);
                    prevPtr = curPtr + 1;
                    meetMSB = false;
                } else {
                    // ignore current segment.
                    // (either because it is just a symbol or just an English word)
                    prevPtr = curPtr + 1;
                }
            }
        }
        
        if (meetMSB && curPtr > prevPtr) {
            out.put(buf, prevPtr, (curPtr-prevPtr));
        }
        
        return out;
    }
 