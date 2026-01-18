    @Override
    public long getNextIncludedTime(long timeInMillis) {
        long nextIncludedTime = timeInMillis + oneMillis;
        
        while (!isTimeIncluded(nextIncludedTime)) {
            if (!invertTimeRange) {
                //If the time is in a range excluded by this calendar, we can
                // move to the end of the excluded time range and continue 
                // testing from there. Otherwise, if nextIncludedTime is 
                // excluded by the baseCalendar, ask it the next time it 
                // includes and begin testing from there. Failing this, add one
                // millisecond and continue testing.
                if ((nextIncludedTime >= 
                        getTimeRangeStartingTimeInMillis(nextIncludedTime)) && 
                    (nextIncludedTime <= 
                        getTimeRangeEndingTimeInMillis(nextIncludedTime))) {
                    
                    nextIncludedTime = 
                        getTimeRangeEndingTimeInMillis(nextIncludedTime) + 
                            oneMillis;
                } else if ((getBaseCalendar() != null) && 
                        (!getBaseCalendar().isTimeIncluded(nextIncludedTime))){
                    nextIncludedTime = 
                        getBaseCalendar().getNextIncludedTime(nextIncludedTime);
                } else {
                    nextIncludedTime++;
                }
            } else {
                //If the time is in a range excluded by this calendar, we can
                // move to the end of the excluded time range and continue 
                // testing from there. Otherwise, if nextIncludedTime is 
                // excluded by the baseCalendar, ask it the next time it 
                // includes and begin testing from there. Failing this, add one
                // millisecond and continue testing.
                if (nextIncludedTime < 
                        getTimeRangeStartingTimeInMillis(nextIncludedTime)) {
                    nextIncludedTime = 
                        getTimeRangeStartingTimeInMillis(nextIncludedTime);
                } else if (nextIncludedTime > 
                        getTimeRangeEndingTimeInMillis(nextIncludedTime)) {
                    //(move to start of next day)
                    nextIncludedTime = getEndOfDayJavaCalendar(nextIncludedTime).getTime().getTime();
                    nextIncludedTime += 1l; 
                } else if ((getBaseCalendar() != null) && 
                        (!getBaseCalendar().isTimeIncluded(nextIncludedTime))){
                    nextIncludedTime = 
                        getBaseCalendar().getNextIncludedTime(nextIncludedTime);
                } else {
                    nextIncludedTime++;
                }
            }
        }
        
        return nextIncludedTime;
    }
