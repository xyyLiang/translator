    public func decode(image: BinaryBitmap, hints: ?HashMap<DecodeHintType, Any>): Result {
        let result = decode0(image, hints, false)
        if (result.size == 0) {
            throw NotFoundException()
        } else {
            result[0]
        }
    }