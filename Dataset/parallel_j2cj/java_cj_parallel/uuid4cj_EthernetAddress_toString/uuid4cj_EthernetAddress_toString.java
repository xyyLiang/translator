    @Override
    public String toString()
    {
        String str = _asString;
        if (str != null) {
            return str;
        }
        
        /* Let's not cache the output here (unlike with UUID), assuming
         * this won't be called as often:
         */
        StringBuilder b = new StringBuilder(17);
        int i1 = (int) (_address >> 32);
        int i2 = (int) _address;

        _appendHex(b, i1 >> 8);
        b.append(':');
        _appendHex(b, i1);
        b.append(':');
        _appendHex(b, i2 >> 24);
        b.append(':');
        _appendHex(b, i2 >> 16);
        b.append(':');
        _appendHex(b, i2 >> 8);
        b.append(':');
        _appendHex(b, i2);
        _asString = str = b.toString();
        return str;
    }
