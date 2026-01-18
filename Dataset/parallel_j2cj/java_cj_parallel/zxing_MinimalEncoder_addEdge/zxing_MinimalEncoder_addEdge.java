  void addEdge(Edge[][][] edges, int position, Edge edge) {
    int vertexIndex = position + edge.characterLength;
    Edge[] modeEdges = edges[vertexIndex][edge.charsetEncoderIndex];
    int modeOrdinal = getCompactedOrdinal(edge.mode);
    if (modeEdges[modeOrdinal] == null || modeEdges[modeOrdinal].cachedTotalSize > edge.cachedTotalSize) {
      modeEdges[modeOrdinal] = edge;
    }
  }
