    private func doDeactivate(lf1: ?LockedFile, lf2: ?LockedFile) {
        if (let Some(_) <- lf1) {
            lf1.getOrThrow().deactivate();
        }

        if (let Some(_) <- lf2) {
            lf2.getOrThrow().deactivate();
        }
    }