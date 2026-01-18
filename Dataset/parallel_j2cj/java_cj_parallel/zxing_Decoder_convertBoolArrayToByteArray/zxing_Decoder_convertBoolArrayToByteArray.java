  static byte[] convertBoolArrayToByteArray(boolean[] boolArr) {
    byte[] byteArr = new byte[(boolArr.length + 7) / 8];
    for (int i = 0; i < byteArr.length; i++) {
      byteArr[i] = readByte(boolArr, 8 * i);
    }
    return byteArr;
  }