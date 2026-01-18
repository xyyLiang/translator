    public func encode(
        contents: String,
        format: BarcodeFormat,
        width: Int64,
        height: Int64,
        hints: ?HashMap<EncodeHintType, Any>
    ): BitMatrix {
        let writer: Writer = match (format) {
            case EAN_8 => EAN8Writer()

            case UPC_E => UPCEWriter()

            case EAN_13 => EAN13Writer()

            case UPC_A => UPCAWriter()

            case QR_CODE => QRCodeWriter()

            case CODE_39 => Code39Writer()

            case CODE_93 => Code93Writer()

            case CODE_128 => Code128Writer()

            case ITF => ITFWriter()

            case PDF_417 => PDF417Writer()

            case CODABAR => CodaBarWriter()

            case DATA_MATRIX => DataMatrixWriter()
            
            case AZTEC => AztecWriter()

            case _ => throw IllegalArgumentException("No encoder available for format ${format}")
        }

        writer.encode(contents, format, width, height, hints)
    }