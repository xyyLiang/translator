  private static int findMinimums(float[] charCounts, int[] intCharCounts, int min, byte[] mins) {
    for (int i = 0; i < 6; i++) {
      int current = (intCharCounts[i] = (int) Math.ceil(charCounts[i]));
      if (min > current) {
        min = current;
        Arrays.fill(mins, (byte) 0);
      }
      if (min == current) {
        mins[i]++;
      }
    }
    return min;
  }