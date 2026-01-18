 private boolean isXingFrame(byte[] bytes, int offset) {
  if (bytes.length >= offset + XING_MARKER_OFFSET_1 + 3) {
   if ("Xing".equals(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_1, 4)))
    return true;
   if ("Info".equals(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_1, 4)))
    return true;
   if (bytes.length >= offset + XING_MARKER_OFFSET_2 + 3) {
    if ("Xing".equals(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_2, 4)))
     return true;
    if ("Info".equals(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_2, 4)))
     return true;
    if (bytes.length >= offset + XING_MARKER_OFFSET_3 + 3) {
     if ("Xing".equals(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_3, 4)))
      return true;
     if ("Info".equals(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset + XING_MARKER_OFFSET_3, 4)))
      return true;
    }
   }
  }
  return false;
 }