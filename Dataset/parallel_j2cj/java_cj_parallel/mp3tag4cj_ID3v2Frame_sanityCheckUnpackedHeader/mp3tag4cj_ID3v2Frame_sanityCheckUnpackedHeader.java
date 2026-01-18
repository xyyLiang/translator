 protected void sanityCheckUnpackedHeader() throws InvalidDataException {
  for (int i = 0; i < id.length(); i++) {
   if (!((id.charAt(i) >= 'A' && id.charAt(i) <= 'Z') || (id.charAt(i) >= '0' && id.charAt(i) <= '9'))) {
    throw new InvalidDataException("Not a valid frame - invalid tag " + id);
   }
  }
 }