    func decodeInternal(image: BinaryBitmap): Result {
        if (let Some(readers) = this.readers) {
            for (reader in readers) {
                try {
                    return reader.decode(image, hints)
                } catch (re: ReaderException) {
                    // continue
                }
            }
            if (let Some(hints) = this.hints) {
                if (hints.contains(DecodeHintType.ALSO_INVERTED)) {
                    image.binarizer.blackMatrix().flip()
                    for (reader in readers) {
                        try {
                            return reader.decode(image, hints)
                        } catch (re: ReaderException) {
                            // continue
                        }
                    }
                }
            }
        }
        throw NotFoundException()
    }