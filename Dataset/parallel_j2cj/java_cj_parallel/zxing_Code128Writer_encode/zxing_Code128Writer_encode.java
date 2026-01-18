  @Override
  public boolean[] encode(String contents, Map<EncodeHintType,?> hints) {

    int forcedCodeSet = check(contents, hints);

    boolean hasCompactionHint = hints != null && hints.containsKey(EncodeHintType.CODE128_COMPACT) &&
        Boolean.parseBoolean(hints.get(EncodeHintType.CODE128_COMPACT).toString());

    return hasCompactionHint ? new MinimalEncoder().encode(contents) : encodeFast(contents, forcedCodeSet);
  }