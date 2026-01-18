    static func maybeReturnResult(result: Result): Result {
        let text = result.text
        if (text.charAt(0) == '0') {
            let upcaResult = Result(text[1..text.size], None, result.resultPoints, BarcodeFormat.UPC_A)
            if (let Some(r) = result.resultMetadata) {
                upcaResult.putAllMetadata(r)
            }
            upcaResult
        } else {
            throw FormatException()
        }
    }