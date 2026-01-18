    public static String decodeText(String text) throws UnsupportedEncodingException {
        // if the text contains any encoded tokens, those tokens will be marked with "=?".  If the
        // source string doesn't contain that sequent, no decoding is required.
        if (text.indexOf(ENCODED_TOKEN_MARKER) < 0) {
            return text;
        }

        int offset = 0;
        int endOffset = text.length();

        int startWhiteSpace = -1;
        int endWhiteSpace = -1;

        StringBuilder decodedText = new StringBuilder(text.length());

        boolean previousTokenEncoded = false;

        while (offset < endOffset) {
            char ch = text.charAt(offset);

            // is this a whitespace character?
            if (LINEAR_WHITESPACE.indexOf(ch) != -1) { // whitespace found
                startWhiteSpace = offset;
                while (offset < endOffset) {
                    // step over the white space characters.
                    ch = text.charAt(offset);
                    if (LINEAR_WHITESPACE.indexOf(ch) != -1) { // whitespace found
                        offset++;
                    } else {
                        // record the location of the first non lwsp and drop down to process the
                        // token characters.
                        endWhiteSpace = offset;
                        break;
                    }
                }
            } else {
                // we have a word token.  We need to scan over the word and then try to parse it.
                int wordStart = offset;

                while (offset < endOffset) {
                    // step over the non white space characters.
                    ch = text.charAt(offset);
                    if (LINEAR_WHITESPACE.indexOf(ch) == -1) { // not white space
                        offset++;
                    } else {
                        break;
                    }

                    //NB:  Trailing whitespace on these header strings will just be discarded.
                }
                // pull out the word token.
                String word = text.substring(wordStart, offset);
                // is the token encoded?  decode the word
                if (word.startsWith(ENCODED_TOKEN_MARKER)) {
                    try {
                        // if this gives a parsing failure, treat it like a non-encoded word.
                        String decodedWord = decodeWord(word);

                        // are any whitespace characters significant?  Append 'em if we've got 'em.
                        if (!previousTokenEncoded && startWhiteSpace != -1) {
                            decodedText.append(text.substring(startWhiteSpace, endWhiteSpace));
                            startWhiteSpace = -1;
                        }
                        // this is definitely a decoded token.
                        previousTokenEncoded = true;
                        // and add this to the text.
                        decodedText.append(decodedWord);
                        // we continue parsing from here...we allow parsing errors to fall through
                        // and get handled as normal text.
                        continue;

                    } catch (ParseException e) {
                        // just ignore it, skip to next word
                    }
                }
                // this is a normal token, so it doesn't matter what the previous token was.  Add the white space
                // if we have it.
                if (startWhiteSpace != -1) {
                    decodedText.append(text.substring(startWhiteSpace, endWhiteSpace));
                    startWhiteSpace = -1;
                }
                // this is not a decoded token.
                previousTokenEncoded = false;
                decodedText.append(word);
            }
        }

        return decodedText.toString();
    }
