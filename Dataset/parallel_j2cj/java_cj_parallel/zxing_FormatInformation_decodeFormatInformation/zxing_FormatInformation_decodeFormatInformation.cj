func decodeFormatInformation(maskedFormatInfo1: Int64, maskedFormatInfo2: Int64): ?FormatInformation {
    let formatInfo = doDecodeFormatInformation(maskedFormatInfo1, maskedFormatInfo2)
    if (let Some(f) = formatInfo) {
        return f
    }
    return doDecodeFormatInformation(
        maskedFormatInfo1 ^ FormatInformation.FORMAT_INFO_MASK_QR,
        maskedFormatInfo2 ^ FormatInformation.FORMAT_INFO_MASK_QR
    )
}