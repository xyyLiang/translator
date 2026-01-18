    private func isXingFrame(bytes: Array<Int8>, offset: Int32): Bool {
        if (bytes.size >= Int64(offset) + Int64(XING_MARKER_OFFSET_1) + 3) {
            if ("Xing" ==
                BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_1, 4).
                getOrDefault({ => ""})
            ) {
                return true
            }
            if ("Info" ==
                BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_1, 4).
                getOrDefault({ => ""})
            ) {
                return true
            }
            if (bytes.size >= Int64(offset + XING_MARKER_OFFSET_2 + 3)) {
                if ("Xing" ==
                    BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_2, 4).
                    getOrDefault({ => ""})
                ) {
                    return true
                }
                if ("Info" ==
                    BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_2, 4).
                    getOrDefault({ => ""})
                ) {
                    return true
                }
                if (bytes.size >= Int64(offset + XING_MARKER_OFFSET_3 + 3)) {
                    if ("Xing" ==
                        BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_3, 4).
                        getOrDefault({ => ""})
                    ) {
                        return true
                    }
                    if ("Info" ==
                        BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_3, 4).
                        getOrDefault({ => ""})
                    ) {
                        return true
                    }
                }
            }
        }
        return false
    }