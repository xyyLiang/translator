    public void setBoundary(byte[] boundary)
            throws IllegalBoundaryException {
        if (boundary.length != boundaryLength - BOUNDARY_PREFIX.length) {
            throw new IllegalBoundaryException(
            "The length of a boundary token cannot be changed");
        }
        System.arraycopy(boundary, 0, this.boundary, BOUNDARY_PREFIX.length,
                boundary.length);
        computeBoundaryTable();
    }