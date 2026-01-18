    public func setTimeRange( rangeStartingTimeString: String,
                              rangeEndingTimeString: String) : Unit  {
 
        let rangeStartingTime = split(rangeStartingTimeString, colon);

        if ((rangeStartingTime.size < 2) || (rangeStartingTime.size > 4)) {
            throw IllegalArgumentException("Invalid time string '${rangeStartingTimeString}'");
        }

        let rStartingHourOfDay = Int64.parse(rangeStartingTime[0]);
        let rStartingMinute = Int64.parse(rangeStartingTime[1]);
        let rStartingSecond = if (rangeStartingTime.size > 2) {
            Int64.parse(rangeStartingTime[2]);
        } else {
             0;
        }
        let rStartingMillis = if (rangeStartingTime.size == 4) {
            Int64.parse(rangeStartingTime[3]);
        } else {
            0;
        }


        let rEndingTime = split(rangeEndingTimeString, colon);

        if ((rEndingTime.size < 2) || (rEndingTime.size > 4)) {
            throw IllegalArgumentException("Invalid time string '${rangeEndingTimeString}'");
        }
        
        let rEndingHourOfDay = Int64.parse(rEndingTime[0]);
        let rEndingMinute = Int64.parse(rEndingTime[1]);
        let rEndingSecond = if (rEndingTime.size > 2) {
            Int64.parse(rEndingTime[2]);
        } else {
            0;
        }
        let rEndingMillis = if (rEndingTime.size == 4) {
            Int64.parse(rEndingTime[3]);
        } else {
            0;
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