public long getTotalLength() {
    if (isChunked()) return getTotalOffset();

    long length = 0;
    for (BlockInfo block : blockInfoList) {
        length += block.getContentLength();
    }
    return length;
}