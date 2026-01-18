    func addEdge(edges: Array<Array<Array<?Edge>>>, position: Int64, edge: Edge) {
        let vertexIndex = position + edge.characterLength
        let modeEdges = edges[vertexIndex][edge.charsetEncoderIndex]
        let modeOrdinal = getCompactedOrdinal(edge.mode)
        if (let Some(m) = modeEdges[modeOrdinal]) {
            if (m.cachedTotalSize > edge.cachedTotalSize) {
                modeEdges[modeOrdinal] = edge
            }
        } else {
            modeEdges[modeOrdinal] = edge
        }
    }