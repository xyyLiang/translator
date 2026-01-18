    public override func parseInformation(): String {
        if (this.information.size != HEADER_SIZE + GTIN_SIZE + WEIGHT_SIZE + DATE_SIZE) {
            throw NotFoundException()
        }

        let buf = StringBuilder()

        encodeCompressedGtin(buf, HEADER_SIZE)
        encodeCompressedWeight(buf, HEADER_SIZE + GTIN_SIZE, WEIGHT_SIZE)
        encodeCompressedDate(buf, HEADER_SIZE + GTIN_SIZE + WEIGHT_SIZE)

        buf.toString()
    }