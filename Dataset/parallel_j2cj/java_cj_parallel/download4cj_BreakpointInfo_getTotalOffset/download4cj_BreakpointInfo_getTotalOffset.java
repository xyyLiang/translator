public long getTotalOffset() {
    long offset = 0;
    for (BlockInfo block : blockInfoList) {
        offset += block.getCurrentOffset();
    }
    return offset;
}