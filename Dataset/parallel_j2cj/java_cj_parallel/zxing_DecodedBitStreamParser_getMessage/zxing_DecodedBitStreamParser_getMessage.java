  private static String getMessage(byte[] bytes, int start, int len) {
    StringBuilder sb = new StringBuilder();
    int shift = -1;
    int set = 0;
    int lastset = 0;
    for (int i = start; i < start + len; i++) {
      char c = SETS[set].charAt(bytes[i]);
      switch (c) {
        case LATCHA:
          set = 0;
          shift = -1;
          break;
        case LATCHB:
          set = 1;
          shift = -1;
          break;
        case SHIFTA:
        case SHIFTB:
        case SHIFTC:
        case SHIFTD:
        case SHIFTE:
          lastset = set;
          set = c - SHIFTA;
          shift = 1;
          break;
        case TWOSHIFTA:
          lastset = set;
          set = 0;
          shift = 2;
          break;
        case THREESHIFTA:
          lastset = set;
          set = 0;
          shift = 3;
          break;
        case NS:
          int nsval = (bytes[++i] << 24) + (bytes[++i] << 18) + (bytes[++i] << 12) + (bytes[++i] << 6) + bytes[++i];
          sb.append(new DecimalFormat("000000000").format(nsval));
          break;
        case LOCK:
          shift = -1;
          break;
        default:
          sb.append(c);
      }
      if (shift-- == 0) {
        set = lastset;
      }
    }
    while (sb.length() > 0 && sb.charAt(sb.length() - 1) == PAD) {
      sb.setLength(sb.length() - 1);
    }
    return sb.toString();
  }
