  private static void encodeBinary(byte[] bytes,
                                   int startpos,
                                   int count,
                                   int startmode,
                                   StringBuilder sb) {
    if (count == 1 && startmode == TEXT_COMPACTION) {
      sb.append((char) SHIFT_TO_BYTE);
    } else {
      if ((count % 6) == 0) {
        sb.append((char) LATCH_TO_BYTE);
      } else {
        sb.append((char) LATCH_TO_BYTE_PADDED);
      }
    }

    int idx = startpos;
    // Encode sixpacks
    if (count >= 6) {
      char[] chars = new char[5];
      while ((startpos + count - idx) >= 6) {
        long t = 0;
        for (int i = 0; i < 6; i++) {
          t <<= 8;
          t += bytes[idx + i] & 0xff;
        }
        for (int i = 0; i < 5; i++) {
          chars[i] = (char) (t % 900);
          t /= 900;
        }
        for (int i = chars.length - 1; i >= 0; i--) {
          sb.append(chars[i]);
        }
        idx += 6;
      }
    }
    //Encode rest (remaining n<5 bytes if any)
    for (int i = idx; i < startpos + count; i++) {
      int ch = bytes[i] & 0xff;
      sb.append((char) ch);
    }
  }
