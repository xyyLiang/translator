    private func addToSet(val: Int64, end: Int64, incr0: Int64, types: Int64): Unit {        
        let set = getSet(types)

        if (types == SECOND || types == MINUTE) {
            if ((val < 0 || val > 59 || end > 59) && (val != ALL_SPEC_INT)) {
                throw ParseException("Minute and Second values must be between 0 and 59", -1)
            }
        } else if (types == HOUR) {
            if ((val < 0 || val > 23 || end > 23) && (val != ALL_SPEC_INT)) {
                throw ParseException("Hour values must be between 0 and 23", -1)
            }
        } else if (types == DAY_OF_MONTH) {
            if ((val < 1 || val > 31 || end > 31) && (val != ALL_SPEC_INT) && (val != NO_SPEC_INT)) {
                throw ParseException("Day of month values must be between 1 and 31", -1)
            }
        } else if (types == MONTH) {
            if ((val < 1 || val > 12 || end > 12) && (val != ALL_SPEC_INT)) {
                throw ParseException("Month values must be between 1 and 12", -1)
            }
        } else if (types == DAY_OF_WEEK) {
            if ((val == 0 || val > 7 || end > 7) && (val != ALL_SPEC_INT) &&  (val != NO_SPEC_INT)) {
                throw ParseException("Day-of-Week values must be between 1 and 7", -1)
            }
        }

        if ((incr0 == 0 || incr0 == -1) && val != ALL_SPEC_INT) {
            if (val != -1) {
                set.add(val)
            } else {
                set.add(NO_SPEC)
            }
            return
        }

        var startAt = val
        var stopAt = end
        var incr = incr0

        if (val == ALL_SPEC_INT && incr <= 0) {
            incr = 1
            set.add(ALL_SPEC) // put in a marker, but also fill values
        }

        if (types == SECOND || types == MINUTE) {
            if (stopAt == -1) {
                stopAt = 59
            }
            if (startAt == -1 || startAt == ALL_SPEC_INT) {
                startAt = 0
            }
        } else if (types == HOUR) {
            if (stopAt == -1) {
                stopAt = 23
            }
            if (startAt == -1 || startAt == ALL_SPEC_INT) {
                startAt = 0
            }
        } else if (types == DAY_OF_MONTH) {
            if (stopAt == -1) {
                stopAt = 31
            }
            if (startAt == -1 || startAt == ALL_SPEC_INT) {
                startAt = 1
            }
        } else if (types == MONTH) {
            if (stopAt == -1) {
                stopAt = 12
            }
            if (startAt == -1 || startAt == ALL_SPEC_INT) {
                startAt = 1
            }
        } else if (types == DAY_OF_WEEK) {
            if (stopAt == -1) {
                stopAt = 7
            }
            if (startAt == -1 || startAt == ALL_SPEC_INT) {
                startAt = 1
            }
        } else if (types == YEAR) {
            if (stopAt == -1) {
                stopAt = TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT
            }
            if (startAt == -1 || startAt == ALL_SPEC_INT) {
                startAt = 1970
            }
        }

        // if the end of the range is before the start, then we need to overflow into 
        // the next day, month etc. This is done by adding the maximum amount for that 
        // type, and using modulus max to determine the value being added.

        var max = -1

        if (stopAt < startAt) {
            match (types) {
              case v where v == SECOND => max = 60
              case v where v == MINUTE => max = 60
              case v where v == HOUR => max = 24
              case v where v == MONTH => max = 12
              case v where v == DAY_OF_WEEK => max = 7 
              case v where v == DAY_OF_MONTH => max = 31 
              case v where v == YEAR => throw IllegalArgumentException("Start year must be less than stop year")
              case _ => ()
            }
            stopAt += max
        }

        for(i in startAt ..= stopAt : incr) {
            if (max == -1) {
                // ie: there's no max to overflow over
                set.add(i)
            } else {
                // take the modulus to get the real value
                var i2 = i % max

                // 1-indexed ranges should not include 0, and should include their max
                if (i2 == 0 && (types == MONTH || types == DAY_OF_WEEK || types == DAY_OF_MONTH) ) {
                    i2 = max
                }

                set.add(i2)
            }
        }
    } 