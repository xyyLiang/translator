    public func rotate(degrees: Int64) {
        match (degrees % 360) {
            case 0 => ()
            case 90 => rotate90()
            case 180 => rotate180()
            case 270 =>
                rotate90()
                rotate180()
            case _ => throw IllegalArgumentException("degrees must be a multiple of 0, 90, 180, or 270")
        }
    }