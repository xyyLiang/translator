    @NonNull BreakpointLocalCheck createLocalCheck(@NonNull BreakpointInfo info,
                                                   long responseInstanceLength) {
        return new BreakpointLocalCheck(task, info, responseInstanceLength);
    }