  public static int[] toIntArray(Collection<Integer> list) {
    if (list == null || list.isEmpty()) {
      return EMPTY_INT_ARRAY;
    }
    int[] result = new int[list.size()];
    int i = 0;
    for (Integer integer : list) {
      result[i++] = integer;
    }
    return result;
  }