  ResultList encodeSpecificVersion(Version version) throws WriterException {

    @SuppressWarnings("checkstyle:lineLength")

    int inputLength = stringToEncode.length();

    Edge[][][] edges = new Edge[inputLength + 1][encoders.length()][4];
    addEdges(version, edges, 0, null);

    for (int i = 1; i <= inputLength; i++) {
      for (int j = 0; j < encoders.length(); j++) {
        for (int k = 0; k < 4; k++) {
          if (edges[i][j][k] != null && i < inputLength) {
            addEdges(version, edges, i, edges[i][j][k]);
          }
        }
      }

    }
    int minimalJ = -1;
    int minimalK = -1;
    int minimalSize = Integer.MAX_VALUE;
    for (int j = 0; j < encoders.length(); j++) {
      for (int k = 0; k < 4; k++) {
        if (edges[inputLength][j][k] != null) {
          Edge edge = edges[inputLength][j][k];
          if (edge.cachedTotalSize < minimalSize) {
            minimalSize = edge.cachedTotalSize;
            minimalJ = j;
            minimalK = k;
          }
        }
      }
    }
    if (minimalJ < 0) {
      throw new WriterException("Internal error: failed to encode \"" + stringToEncode + "\"");
    }
    return new ResultList(version, edges[inputLength][minimalJ][minimalK]);
  }
