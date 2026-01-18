    public StringBuilder formatNameValuePair(StringBuilder charBuffer, NameValuePair nvp, boolean quote) {

        charBuffer.append(nvp.getName());
        String value = nvp.getValue();
        if (value != null) {
            charBuffer.append('=');
            this.doFormatValue(charBuffer, value, quote);
        }

        return charBuffer;
    }