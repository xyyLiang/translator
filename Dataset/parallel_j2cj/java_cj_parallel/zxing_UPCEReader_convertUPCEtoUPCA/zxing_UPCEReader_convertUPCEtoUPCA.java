  public static String convertUPCEtoUPCA(String upce) {
    char[] upceChars = new char[6];
    upce.getChars(1, 7, upceChars, 0);
    StringBuilder result = new StringBuilder(12);
    result.append(upce.charAt(0));
    char lastChar = upceChars[5];
    switch (lastChar) {
      case '0':
      case '1':
      case '2':
        result.append(upceChars, 0, 2);
        result.append(lastChar);
        result.append("0000");
        result.append(upceChars, 2, 3);
        break;
      case '3':
        result.append(upceChars, 0, 3);
        result.append("00000");
        result.append(upceChars, 3, 2);
        break;
      case '4':
        result.append(upceChars, 0, 4);
        result.append("00000");
        result.append(upceChars[4]);
        break;
      default:
        result.append(upceChars, 0, 5);
        result.append("0000");
        result.append(lastChar);
        break;
    }
    // Only append check digit in conversion if supplied
    if (upce.length() >= 8) {
      result.append(upce.charAt(7));
    }
    return result.toString();
  }
