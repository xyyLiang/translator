    public void setTimeRange(String rangeStartingTimeString,
                              String rangeEndingTimeString) {
        String[] rangeStartingTime;
        int rStartingHourOfDay;
        int rStartingMinute;
        int rStartingSecond;
        int rStartingMillis;
        
        String[] rEndingTime;
        int rEndingHourOfDay;
        int rEndingMinute;
        int rEndingSecond;
        int rEndingMillis;
        
        rangeStartingTime = split(rangeStartingTimeString, colon);
        
        if ((rangeStartingTime.length < 2) || (rangeStartingTime.length > 4)) {
            throw new IllegalArgumentException("Invalid time string '" + 
                    rangeStartingTimeString + "'");
        }
        
        rStartingHourOfDay = Integer.parseInt(rangeStartingTime[0]);
        rStartingMinute = Integer.parseInt(rangeStartingTime[1]);
        if (rangeStartingTime.length > 2) {
            rStartingSecond = Integer.parseInt(rangeStartingTime[2]);
        } else {
            rStartingSecond = 0;
        }
        if (rangeStartingTime.length == 4) {
            rStartingMillis = Integer.parseInt(rangeStartingTime[3]);
        } else {
            rStartingMillis = 0;
        }
        
        rEndingTime = split(rangeEndingTimeString, colon);

        if ((rEndingTime.length < 2) || (rEndingTime.length > 4)) {
            throw new IllegalArgumentException("Invalid time string '" + 
                    rangeEndingTimeString + "'");
        }
        
        rEndingHourOfDay = Integer.parseInt(rEndingTime[0]);
        rEndingMinute = Integer.parseInt(rEndingTime[1]);
        if (rEndingTime.length > 2) {
            rEndingSecond = Integer.parseInt(rEndingTime[2]);
        } else {
            rEndingSecond = 0;
        }
        if (rEndingTime.length == 4) {
            rEndingMillis = Integer.parseInt(rEndingTime[3]);
        } else {
            rEndingMillis = 0;
        }
        
        setTimeRange(rStartingHourOfDay,
                     rStartingMinute,
                     rStartingSecond,
                     rStartingMillis,
                     rEndingHourOfDay,
                     rEndingMinute,
                     rEndingSecond,
                     rEndingMillis);
    }
