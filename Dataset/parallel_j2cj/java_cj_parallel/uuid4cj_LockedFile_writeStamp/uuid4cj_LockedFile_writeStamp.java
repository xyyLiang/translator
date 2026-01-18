    public void writeStamp(long stamp)
        throws IOException
    {
 // Let's do sanity check first:
 if (stamp <= mLastTimestamp) {
     /* same stamp is not dangerous, but pointless... so warning,
      * not an error:
      */
     if (stamp == mLastTimestamp) {
         logger.warn("(file '{}') Trying to re-write existing timestamp ({})", mFile, stamp);
  return;
     }
     throw new IOException(""+mFile+" trying to overwrite existing value ("+mLastTimestamp+") with an earlier timestamp ("+stamp+")");
 }

        // Need to initialize the buffer?
        if (mWriteBuffer == null) {
            mWriteBuffer = ByteBuffer.allocate(DEFAULT_LENGTH);
            mWriteBuffer.put(0, (byte) '[');
            mWriteBuffer.put(1, (byte) '0');
            mWriteBuffer.put(2, (byte) 'x');
            mWriteBuffer.put(19, (byte) ']');
            mWriteBuffer.put(20, (byte) '\r');
            mWriteBuffer.put(21, (byte) '\n');
        }

        // Converting to hex is simple
        for (int i = 18; i >= 3; --i) {
            int val = (((int) stamp) & 0x0F);
            mWriteBuffer.put(i, (byte) HEX_DIGITS.charAt(val));
            stamp = (stamp >> 4);
        }
        // and off we go:
        mWriteBuffer.position(0); // to make sure we always write it all
        mChannel.write(mWriteBuffer, 0L);
        if (mWeirdSize) {
            mRAFile.setLength(DEFAULT_LENGTH);
            mWeirdSize = false;
        }

        // This is probably not needed (as the random access file is supposedly synced)... but let's be safe:
        mChannel.force(false);

        // And that's it!
    }