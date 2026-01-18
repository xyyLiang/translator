    public Date getFireTimeBefore(Date end) {
        if (end.getTime() < getStartTime().getTime()) {
            return null;
        }

        int numFires = computeNumTimesFiredBetween(getStartTime(), end);

        return new Date(getStartTime().getTime() + (numFires * repeatInterval));
    }
