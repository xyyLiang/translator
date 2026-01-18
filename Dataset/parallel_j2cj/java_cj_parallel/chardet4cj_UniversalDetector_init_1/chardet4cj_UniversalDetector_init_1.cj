    public init (listener: ?CharsetListener) {
        this.listener = listener
        this.escCharsetProber = Option<CharsetProber>.None
        match (this.escCharsetProber) {
            case None => ()
            case Some(_) => this.escCharsetProber.getOrThrow().reset()
        }
        for (i in 0..this.probers.size) {
            this.probers[i].reset()
        }
    }