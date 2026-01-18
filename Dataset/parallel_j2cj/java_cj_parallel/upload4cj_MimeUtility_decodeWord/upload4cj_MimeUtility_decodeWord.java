    private static String decodeWord(String word) throws ParseException, UnsupportedEncodingException {
        // encoded words start with the characters "=?".  If this not an encoded word, we throw a
        // ParseException for the caller.

        if (!word.startsWith(ENCODED_TOKEN_MARKER)) {
            throw new ParseException("Invalid RFC 2047 encoded-word: " + word);
        }

        int charsetPos = word.indexOf('?', 2);
        if (charsetPos == -1) {
            throw new ParseException("Missing charset in RFC 2047 encoded-word: " + word);
        }

        // pull out the character set information (this is the MIME name at this point).
        String charset = word.substring(2, charsetPos).toLowerCase(Locale.ENGLISH);

        // now pull out the encoding token the same way.
        int encodingPos = word.indexOf('?', charsetPos + 1);
        if (encodingPos == -1) {
            throw new ParseException("Missing encoding in RFC 2047 encoded-word: " + word);
        }

        String encoding = word.substring(charsetPos + 1, encodingPos);

        // and finally the encoded text.
        int encodedTextPos = word.indexOf(ENCODED_TOKEN_FINISHER, encodingPos + 1);
        if (encodedTextPos == -1) {
            throw new ParseException("Missing encoded text in RFC 2047 encoded-word: " + word);
        }

        String encodedText = word.substring(encodingPos + 1, encodedTextPos);

        // seems a bit silly to encode a null string, but easy to deal with.
        if (encodedText.length() == 0) {
            return "";
        }

        try {
            // the decoder writes directly to an output stream.
            ByteArrayOutputStream out = new ByteArrayOutputStream(encodedText.length());

            byte[] encodedData = encodedText.getBytes(US_ASCII_CHARSET);

            // Base64 encoded?
            if (encoding.equals(BASE64_ENCODING_MARKER)) {
                Base64Decoder.decode(encodedData, out);
            } else if (encoding.equals(QUOTEDPRINTABLE_ENCODING_MARKER)) { // maybe quoted printable.
                QuotedPrintableDecoder.decode(encodedData, out);
            } else {
                throw new UnsupportedEncodingException("Unknown RFC 2047 encoding: " + encoding);
            }
            // get the decoded byte data and convert into a string.
            byte[] decodedData = out.toByteArray();
            return new String(decodedData, javaCharset(charset));
        } catch (IOException e) {
            throw new UnsupportedEncodingException("Invalid RFC 2047 encoding");
        }
    }
