    protected static void doDeactivate(LockedFile lf1, LockedFile lf2)
    {
        if (lf1 != null) {
            lf1.deactivate();
        }
        if (lf2 != null) {
            lf2.deactivate();
        }
    }