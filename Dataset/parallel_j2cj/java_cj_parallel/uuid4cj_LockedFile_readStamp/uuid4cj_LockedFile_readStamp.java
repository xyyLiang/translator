    public long readStamp()
    {
        int size;

        try {
            size = (int) mChannel.size();
        } catch (IOException ioe) {
            logger.error("Failed to read file size", ioe);
            return READ_ERROR;
        }

        mWeirdSize = (size != DEFAULT_LENGTH);

        // Let's check specifically empty files though
        if (size == 0) {
            logger.warn("Missing or empty file, can not read timestamp value");
            return READ_ERROR;
        }

        // Let's also allow some slack... but just a bit
        if (size > 100) {
            size = 100;
        }
        byte[] data = new byte[size];
        try {
            mRAFile.readFully(data);
        } catch (IOException ie) {
            logger.error("(file '{}') Failed to read {} bytes", mFile, size, ie);
            return READ_ERROR;
        }

        /* Ok, got data. Now, we could just directly parse the bytes (since
         * it is single-byte encoding)... but for convenience, let's create
         * the String (this is only called once per JVM session)
         */
        char[] cdata = new char[size];
        for (int i = 0; i < size; ++i) {
            cdata[i] = (char) (data[i] & 0xFF);
        }
        String dataStr = new String(cdata);
        // And let's trim leading (and trailing, who cares)
        dataStr = dataStr.trim();

        long result = -1;
        String err = null;

        if (!dataStr.startsWith("[0")
            || dataStr.length() < 3
            || Character.toLowerCase(dataStr.charAt(2)) != 'x') {
            err = "does not start with '[0x' prefix";
        } else {
            int ix = dataStr.indexOf(']', 3);
            if (ix <= 0) {
                err = "does not end with ']' marker";
            } else {
                String hex = dataStr.substring(3, ix);
                if (hex.length() > 16) {
                    err = "length of the (hex) timestamp too long; expected 16, had "+hex.length()+" ('"+hex+"')";
                } else {
                    try {
                        result = Long.parseLong(hex, 16);
                    } catch (NumberFormatException nex) {
                        err = "does not contain a valid hex timestamp; got '"
                            +hex+"' (parse error: "+nex+")";
                    }
                }
            }
        }

        // Unsuccesful?
        if (result < 0L) {
            logger.error("(file '{}') Malformed timestamp file contents: {}", mFile, err);
            return READ_ERROR;
        }

 mLastTimestamp = result;
        return result;
    }
