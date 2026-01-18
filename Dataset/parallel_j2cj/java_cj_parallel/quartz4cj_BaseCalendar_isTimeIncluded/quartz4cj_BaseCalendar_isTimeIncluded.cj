    public open func isTimeIncluded(timeStamp: Int64) : Bool {

        if (timeStamp <= 0) {
            throw IllegalArgumentException( "timeStamp must be greater 0");
        }

        if ( let Some(cal) <- baseCalendar ) {
            if (!cal.isTimeIncluded(timeStamp)) { 
                return false; 
            }
        }

        return true;
    }