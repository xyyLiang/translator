 public int read() throws IOException {
  byte[] data = new byte[1];
  int nrOfBytesRead = this.read(data, 0, 1);
  if (nrOfBytesRead >= 0){
   return data[0];
  }
  return -1;
 }