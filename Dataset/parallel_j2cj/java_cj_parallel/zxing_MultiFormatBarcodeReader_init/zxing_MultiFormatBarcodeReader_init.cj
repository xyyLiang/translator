    public init(hints: ?HashMap<DecodeHintType, Any>) {
        let possibleFormats: ?HashSet<BarcodeFormat> = if (let Some(h) = hints) {
            if (let Some(p) = h.get(DecodeHintType.POSSIBLE_FORMATS)) {
                p as HashSet<BarcodeFormat>
            } else {
                None
            }
        } else {
            None
        }
        let useCode39CheckDigit: Bool = if (let Some(h) = hints) {
            h.contains(DecodeHintType.ASSUME_CODE_39_CHECK_DIGIT)
        } else {
            false
        }
        let mReaders = ArrayList<BarcodeReader>()
        if (let Some(p) = possibleFormats) {
            if (p.contains(BarcodeFormat.EAN_13) || p.contains(BarcodeFormat.UPC_A) || p.contains(BarcodeFormat.EAN_8) ||
                p.contains(BarcodeFormat.UPC_E)) {
                mReaders.append(MultiFormatUPCEANReader(hints))
            }
            if (p.contains(BarcodeFormat.CODE_39)) {
                mReaders.append(Code39Reader(useCode39CheckDigit))
            }
            if (p.contains(BarcodeFormat.CODE_93)) {
                mReaders.append(Code93Reader())
            }
            if (p.contains(BarcodeFormat.CODE_128)) {
                mReaders.append(Code128Reader())
            }
            if (p.contains(BarcodeFormat.ITF)) {
                mReaders.append(ITFReader())
            }
            if (p.contains(BarcodeFormat.CODABAR)) {
                mReaders.append(CodaBarReader())
            }
            if (p.contains(BarcodeFormat.RSS_14)) {
                mReaders.append(RSS14Reader())
            }
            if (p.contains(BarcodeFormat.RSS_EXPANDED)) {
                mReaders.append(RSSExpandedReader())
            }
        }
        if (mReaders.isEmpty()) {
            mReaders.append(MultiFormatUPCEANReader(hints))
            mReaders.append(Code39Reader())
            mReaders.append(CodaBarReader())
            mReaders.append(Code93Reader())
            mReaders.append(Code128Reader())
            mReaders.append(ITFReader())
            mReaders.append(RSS14Reader())
            mReaders.append(RSSExpandedReader())
        }
        this.readers = mReaders.toArray()
    }
