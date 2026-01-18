    protected void doFormatValue(StringBuilder buffer, String value, boolean quote) {
        boolean quoteFlag = quote;
        int i;
        if (!quote) {
            for (i = 0; i < value.length() && !quoteFlag; ++i) {
                quoteFlag = this.isSeparator(value.charAt(i));
            }
        }

        if (quoteFlag) {
            buffer.append('\"');
        }

        for (i = 0; i < value.length(); ++i) {
            char ch = value.charAt(i);
            if (this.isUnsafe(ch)) {
                buffer.append('\\');
            }

            buffer.append(ch);
        }

        if (quoteFlag) {
            buffer.append('\"');
        }

    }
