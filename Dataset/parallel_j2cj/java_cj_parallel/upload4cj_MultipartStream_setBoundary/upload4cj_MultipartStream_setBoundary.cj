    public func setBoundary(boundary: Array<UInt8>) {
        if (boundary.size != boundaryLength - BOUNDARY_PREFIX.size) {
            throw IllegalBoundaryException("The length of a boundary token cannot be changed");
        }

        boundary.copyTo(this.boundary, 0, BOUNDARY_PREFIX.size, boundary.size)
        computeBoundaryTable()
    }