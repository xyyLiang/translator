 @Override
 public int hashCode() {
  return 31 * Objects.hash(compression, dataLength, dataLengthIndicator, encryption, group,
    id, preserveFile, preserveTag, readOnly, unsynchronisation) + Arrays.hashCode(data);
 }