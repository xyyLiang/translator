    public static void resetBlockIfDirty(BlockInfo info) {
        boolean isDirty = false;

        if (info.getCurrentOffset() < 0) {
            isDirty = true;
        } else if (info.getCurrentOffset() > info.getContentLength()) {
            isDirty = true;
        }

        if (isDirty) {
            w("resetBlockIfDirty", "block is dirty so have to reset: " + info);
            info.resetBlock();
        }
    }