  private static char randomize253State(int codewordPosition) {
    int pseudoRandom = ((149 * codewordPosition) % 253) + 1;
    int tempVariable = PAD + pseudoRandom;
    return (char) (tempVariable <= 254 ? tempVariable : tempVariable - 254);
  }