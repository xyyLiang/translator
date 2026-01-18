    public func setVersion(version: Int32): Unit {
        match (version) {
            case 0 => this.version = MPEG_VERSION_2_5
            case 2 => this.version = MPEG_VERSION_2_0
            case 3 => this.version = MPEG_VERSION_1_0
            case _ => throw InvalidDataException("Invalid mpeg audio version in frame header")
        }
    }