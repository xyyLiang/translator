    public open func getNextIncludedTime(timeStamp: Int64 ) :Int64 {
        if (timeStamp <= 0) {
            throw IllegalArgumentException( "timeStamp must be greater 0");
        }

        if ( let Some(cal) <- baseCalendar) {
            return cal.getNextIncludedTime(timeStamp);
        }

        return timeStamp;
    }