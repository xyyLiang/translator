    protected Date getFireTimeAfter(Date afterTime, boolean ignoreEndTime) {
        if (complete) {
            return null;
        }

        // increment afterTme by a second, so that we are 
        // comparing against a time after it!
        if (afterTime == null) {
            afterTime = new Date();
        }

        long startMillis = getStartTime().getTime();
        long afterMillis = afterTime.getTime();
        long endMillis = (getEndTime() == null) ? Long.MAX_VALUE : getEndTime()
                .getTime();

        if (!ignoreEndTime && (endMillis <= afterMillis)) {
            return null;
        }

        if (afterMillis < startMillis) {
            return new Date(startMillis);
        }

        
        long secondsAfterStart = 1 + (afterMillis - startMillis) / 1000L;

        Date time = null;
        long repeatLong = getRepeatInterval();
        
        Calendar aTime = Calendar.getInstance();
        aTime.setTime(afterTime);

        Calendar sTime = Calendar.getInstance();
        if(timeZone != null)
            sTime.setTimeZone(timeZone);
        sTime.setTime(getStartTime());
        sTime.setLenient(true);
        
        if(getRepeatIntervalUnit().equals(IntervalUnit.SECOND)) {
            long jumpCount = secondsAfterStart / repeatLong;
            if(secondsAfterStart % repeatLong != 0)
                jumpCount++;
            sTime.add(Calendar.SECOND, getRepeatInterval() * (int)jumpCount);
            time = sTime.getTime();
        }
        else if(getRepeatIntervalUnit().equals(IntervalUnit.MINUTE)) {
            long jumpCount = secondsAfterStart / (repeatLong * 60L);
            if(secondsAfterStart % (repeatLong * 60L) != 0)
                jumpCount++;
            sTime.add(Calendar.MINUTE, getRepeatInterval() * (int)jumpCount);
            time = sTime.getTime();
        }
        else if(getRepeatIntervalUnit().equals(IntervalUnit.HOUR)) {
            long jumpCount = secondsAfterStart / (repeatLong * 60L * 60L);
            if(secondsAfterStart % (repeatLong * 60L * 60L) != 0)
                jumpCount++;
            sTime.add(Calendar.HOUR_OF_DAY, getRepeatInterval() * (int)jumpCount);
            time = sTime.getTime();
        }
        else { // intervals a day or greater ...

            int initialHourOfDay = sTime.get(Calendar.HOUR_OF_DAY);
            
            if(getRepeatIntervalUnit().equals(IntervalUnit.DAY)) {
                sTime.setLenient(true);
                
                // Because intervals greater than an hour have an non-fixed number 
                // of seconds in them (due to daylight savings, variation number of 
                // days in each month, leap year, etc. ) we can't jump forward an
                // exact number of seconds to calculate the fire time as we can
                // with the second, minute and hour intervals.   But, rather
                // than slowly crawling our way there by iteratively adding the 
                // increment to the start time until we reach the "after time",
                // we can first make a big leap most of the way there...
                
                long jumpCount = secondsAfterStart / (repeatLong * 24L * 60L * 60L);
                // if we need to make a big jump, jump most of the way there, 
                // but not all the way because in some cases we may over-shoot or under-shoot
                if(jumpCount > 20) {
                    if(jumpCount < 50)
                        jumpCount = (long) (jumpCount * 0.80);
                    else if(jumpCount < 500)
                        jumpCount = (long) (jumpCount * 0.90);
                    else
                        jumpCount = (long) (jumpCount * 0.95);
                    sTime.add(java.util.Calendar.DAY_OF_YEAR, (int) (getRepeatInterval() * jumpCount));
                }
                
                // now baby-step the rest of the way there...
                while(!sTime.getTime().after(afterTime) &&
                        (sTime.get(java.util.Calendar.YEAR) < YEAR_TO_GIVEUP_SCHEDULING_AT)) {            
                    sTime.add(java.util.Calendar.DAY_OF_YEAR, getRepeatInterval());
                }
                while(daylightSavingHourShiftOccurredAndAdvanceNeeded(sTime, initialHourOfDay, afterTime) &&
                        (sTime.get(java.util.Calendar.YEAR) < YEAR_TO_GIVEUP_SCHEDULING_AT)) {
                    sTime.add(java.util.Calendar.DAY_OF_YEAR, getRepeatInterval());
                }
                time = sTime.getTime();
            }
            else if(getRepeatIntervalUnit().equals(IntervalUnit.WEEK)) {
                sTime.setLenient(true);
    
                // Because intervals greater than an hour have an non-fixed number 
                // of seconds in them (due to daylight savings, variation number of 
                // days in each month, leap year, etc. ) we can't jump forward an
                // exact number of seconds to calculate the fire time as we can
                // with the second, minute and hour intervals.   But, rather
                // than slowly crawling our way there by iteratively adding the 
                // increment to the start time until we reach the "after time",
                // we can first make a big leap most of the way there...
                
                long jumpCount = secondsAfterStart / (repeatLong * 7L * 24L * 60L * 60L);
                // if we need to make a big jump, jump most of the way there, 
                // but not all the way because in some cases we may over-shoot or under-shoot
                if(jumpCount > 20) {
                    if(jumpCount < 50)
                        jumpCount = (long) (jumpCount * 0.80);
                    else if(jumpCount < 500)
                        jumpCount = (long) (jumpCount * 0.90);
                    else
                        jumpCount = (long) (jumpCount * 0.95);
                    sTime.add(java.util.Calendar.WEEK_OF_YEAR, (int) (getRepeatInterval() * jumpCount));
                }
                
                while(!sTime.getTime().after(afterTime) &&
                        (sTime.get(java.util.Calendar.YEAR) < YEAR_TO_GIVEUP_SCHEDULING_AT)) {            
                    sTime.add(java.util.Calendar.WEEK_OF_YEAR, getRepeatInterval());
                }
                while(daylightSavingHourShiftOccurredAndAdvanceNeeded(sTime, initialHourOfDay, afterTime) &&
                        (sTime.get(java.util.Calendar.YEAR) < YEAR_TO_GIVEUP_SCHEDULING_AT)) {
                    sTime.add(java.util.Calendar.WEEK_OF_YEAR, getRepeatInterval());
                }
                time = sTime.getTime();
            }
            else if(getRepeatIntervalUnit().equals(IntervalUnit.MONTH)) {
                sTime.setLenient(true);
    
                // because of the large variation in size of months, and 
                // because months are already large blocks of time, we will
                // just advance via brute-force iteration.
                
                while(!sTime.getTime().after(afterTime) &&
                        (sTime.get(java.util.Calendar.YEAR) < YEAR_TO_GIVEUP_SCHEDULING_AT)) {            
                    sTime.add(java.util.Calendar.MONTH, getRepeatInterval());
                }
                while(daylightSavingHourShiftOccurredAndAdvanceNeeded(sTime, initialHourOfDay, afterTime) &&
                        (sTime.get(java.util.Calendar.YEAR) < YEAR_TO_GIVEUP_SCHEDULING_AT)) {
                    sTime.add(java.util.Calendar.MONTH, getRepeatInterval());
                }
                time = sTime.getTime();
            }
            else if(getRepeatIntervalUnit().equals(IntervalUnit.YEAR)) {
    
                while(!sTime.getTime().after(afterTime) &&
                        (sTime.get(java.util.Calendar.YEAR) < YEAR_TO_GIVEUP_SCHEDULING_AT)) {            
                    sTime.add(java.util.Calendar.YEAR, getRepeatInterval());
                }
                while(daylightSavingHourShiftOccurredAndAdvanceNeeded(sTime, initialHourOfDay, afterTime) &&
                        (sTime.get(java.util.Calendar.YEAR) < YEAR_TO_GIVEUP_SCHEDULING_AT)) {
                    sTime.add(java.util.Calendar.YEAR, getRepeatInterval());
                }
                time = sTime.getTime();
            }
        } // case of interval of a day or greater
        
        if (!ignoreEndTime && (endMillis <= time.getTime())) {
            return null;
        }

        return time;
    }
