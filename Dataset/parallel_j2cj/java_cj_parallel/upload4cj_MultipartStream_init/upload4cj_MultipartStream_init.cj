    public init(input: InputStream, boundary: Option<Array<UInt8>>, bufSize: Int64, pNotifier: Option<ProgressNotifier>) {
        if (boundary == Option<Array<UInt8>>.None) {
            throw IllegalArgumentException("boundary may not be null")
        }

        this.boundaryLength = boundary.getOrThrow().size + BOUNDARY_PREFIX.size

        if (bufSize < this.boundaryLength + 1) {
            throw IllegalArgumentException("The buffer size specified for the MultipartStream is too small")
        }
        this.input = input
        this.bufSize = max(bufSize, boundaryLength * 2)

        this.buffer = Array<UInt8>(this.bufSize, item: 0)
        this.notifier = pNotifier

        this.boundary = Array<UInt8>(this.boundaryLength, item: 0)
        this.boundaryTable = Array<Int64>(this.boundaryLength + 1, item: 0)
        this.keepRegion = this.boundary.size

        BOUNDARY_PREFIX.copyTo(this.boundary, 0, 0, BOUNDARY_PREFIX.size)

        boundary.getOrThrow().copyTo(this.boundary, 0, BOUNDARY_PREFIX.size, boundary.getOrThrow().size)
        computeBoundaryTable()
        head = 0
        tail = 0
    }