    public func decodeMultiple(image: BinaryBitmap, hints: ?HashMap<DecodeHintType, Any>): Array<Result> {
        try {
            return decode0(image, hints, true)
        } catch (e: FormatException) {
            throw NotFoundException()
        } catch (e: ChecksumException) {
            throw NotFoundException()
        }
    }