 public ID3v2CommentFrameData(boolean unsynchronisation, String language, EncodedText description, EncodedText comment) {
  super(unsynchronisation);
  if (description != null && comment != null && description.getTextEncoding() != comment.getTextEncoding()) {
   throw new IllegalArgumentException("description and comment must have same text encoding");
  }
  this.language = language;
  this.description = description;
  this.comment = comment;
 }
