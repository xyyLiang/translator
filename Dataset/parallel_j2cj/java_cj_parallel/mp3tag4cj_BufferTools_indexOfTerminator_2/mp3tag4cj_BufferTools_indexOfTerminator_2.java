 public static int indexOfTerminator(byte[] bytes, int fromIndex, int terminatorLength) {
  int marker = -1;
  for (int i = fromIndex; i <= bytes.length - terminatorLength; i++) {
   if ((i - fromIndex) % terminatorLength == 0) {
    int matched;
    for (matched = 0; matched < terminatorLength; matched++) {
     if (bytes[i + matched] != 0) break;
    }
    if (matched == terminatorLength) {
     marker = i;
     break;
    }
   }
  }
  return marker;
 }