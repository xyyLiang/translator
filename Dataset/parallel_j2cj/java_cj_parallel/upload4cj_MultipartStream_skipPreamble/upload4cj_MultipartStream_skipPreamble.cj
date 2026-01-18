    public func skipPreamble(): Bool {
        boundary.copyTo(boundary, 2, 0, boundary.size - 2)
        boundaryLength = boundary.size - 2
        computeBoundaryTable()
        try {
            discardBodyData()
            return readBoundary()
        } catch (e: MalformedStreamException) {
            return false
        } finally {
            boundary.copyTo(boundary, 0, 2, boundary.size - 2)
            boundaryLength = boundary.size
            boundary[0] = CR
            boundary[1] = LF
            computeBoundaryTable()
        }
    }