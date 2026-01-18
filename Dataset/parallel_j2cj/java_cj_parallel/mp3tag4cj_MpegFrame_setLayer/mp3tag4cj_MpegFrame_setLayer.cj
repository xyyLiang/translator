    public func setLayer(layer: Int32): Unit {
        match (layer) {
            case 1 => this.layer = 3
            case 2 => this.layer = 2
            case 3 => this.layer = 1
            case _ => throw InvalidDataException("Invalid mpeg layer description in frame header")
        }
    }