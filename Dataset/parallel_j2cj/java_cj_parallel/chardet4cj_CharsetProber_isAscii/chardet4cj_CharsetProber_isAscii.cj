    private func isAscii(b: Byte): Bool {
  return ((Int64(b) & 0x80) == 0)
 }