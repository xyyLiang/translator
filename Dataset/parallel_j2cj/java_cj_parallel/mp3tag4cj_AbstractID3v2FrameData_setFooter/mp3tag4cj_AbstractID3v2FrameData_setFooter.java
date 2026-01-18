 @Override
 public void setFooter(boolean footer) {
  if (this.footer != footer) {
   invalidateDataLength();
   this.footer = footer;
  }
 }