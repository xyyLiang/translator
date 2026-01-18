  private static char randomize255State(char ch, int codewordPosition) {
    int pseudoRandom = ((149 * codewordPosition) % 255) + 1;
    int tempVariable = ch + pseudoRandom;
    if (tempVariable <= 255) {
      return (char) tempVariable;
    } else {
      return (char) (tempVariable - 256);
    }
  }