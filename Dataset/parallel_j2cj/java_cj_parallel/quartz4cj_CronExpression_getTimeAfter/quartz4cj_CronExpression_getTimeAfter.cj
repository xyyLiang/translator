    public func getTimeAfter(afterTime0: DateTime): ?DateTime {
        let cl = Calendars.getInstance(getTimeZone())

        var afterTime = resetMillis(afterTime0).addSeconds(1)  // CronTrigger does not deal with milliseconds
        cl.setTime(afterTime) 

        var gotOne = false

        // loop until we've computed the next time, or we've past the endTime
        while (!gotOne) {

            if(cl.get(Calendars.YEAR) > 2999) { // prevent endless loop...
                return None
            }

            var sec = cl.get(Calendars.SECOND)
            var min = cl.get(Calendars.MINUTE)

            // get second.................................................
            var st = seconds.tailSet(sec)
            if (st.size != 0) {
                sec = st.firstValue()
            } else {
                sec = seconds.firstValue()
                min++
                cl.set(Calendars.MINUTE, min)
            }
            cl.set(Calendars.SECOND, sec)

            min = cl.get(Calendars.MINUTE)
            var hr = cl.get(Calendars.HOUR_OF_DAY)

            var t = -1

            // get minute.................................................
            st = minutes.tailSet(min)
            if (st.size != 0) {
                t = min
                min = st.firstValue()
            } else {
                min = minutes.firstValue()
                hr++
            }
            if (min != t) {
                cl.set(Calendars.SECOND, 0)
                cl.set(Calendars.MINUTE, min)
                setCalendarHour(cl, hr)
                continue
            }
            cl.set(Calendars.MINUTE, min)

            hr = cl.get(Calendars.HOUR_OF_DAY)

            var day = cl.get(Calendars.DAY_OF_MONTH)
            t = -1

            // get hour...................................................
            st = hours.tailSet(hr)
            if (st.size != 0) {
                t = hr
                hr = st.firstValue()
            } else {
                hr = hours.firstValue()
                day++
            }
            if (hr != t) {
                cl.set(Calendars.SECOND, 0)
                cl.set(Calendars.MINUTE, 0)
                cl.set(Calendars.DAY_OF_MONTH, day)
                setCalendarHour(cl, hr)
                continue
            }
            cl.set(Calendars.HOUR_OF_DAY, hr)

            day = cl.get(Calendars.DAY_OF_MONTH)
            var mon = cl.get(Calendars.MONTH)
            t = -1
            var tmon = mon
            
            // get day...................................................
            var dayOfMSpec = !daysOfMonth.contains(NO_SPEC)
            var dayOfWSpec = !daysOfWeek.contains(NO_SPEC)
            if (dayOfMSpec && !dayOfWSpec) { // get day by day of month rule
                st = daysOfMonth.tailSet(day)
                if (lastdayOfMonth) {
                    if(!nearestWeekday) {
                        t = day
                        day = getLastDayOfMonth(mon, cl.get(Calendars.YEAR))
                        day -= lastdayOffset
                        if(t > day) {
                            mon++
                            if(mon > 12) { 
                                mon = 1
                                tmon = 3333 // ensure test of mon != tmon further below fails
                                cl.add(Calendars.YEAR, 1)
                            }
                            day = 1
                        }
                    } else {
                        t = day
                        day = getLastDayOfMonth(mon, cl.get(Calendars.YEAR))
                        day -= lastdayOffset
                        
                        var tcal: Calendars = Calendars.getInstance(getTimeZone())
                        tcal.set(Calendars.MILLISECOND, 0)
                        tcal.set(Calendars.SECOND, 0)
                        tcal.set(Calendars.MINUTE, 0)
                        tcal.set(Calendars.HOUR_OF_DAY, 0)
                        tcal.set(Calendars.DAY_OF_MONTH, day)
                        tcal.set(Calendars.MONTH, mon)
                        tcal.set(Calendars.YEAR, cl.get(Calendars.YEAR))
                        
                        var ldom: Int64 = getLastDayOfMonth(mon, cl.get(Calendars.YEAR))
                        var dow: Int64 = tcal.get(Calendars.DAY_OF_WEEK)

                        if(dow == Calendars.SATURDAY && day == 1) {
                            day += 2
                        } else if(dow == Calendars.SATURDAY) {
                            day -= 1
                        } else if(dow == Calendars.SUNDAY && day == ldom) { 
                            day -= 2
                        } else if(dow == Calendars.SUNDAY) { 
                            day += 1
                        }
                    
                        tcal.set(Calendars.SECOND, sec)
                        tcal.set(Calendars.MINUTE, min)
                        tcal.set(Calendars.HOUR_OF_DAY, hr)
                        tcal.set(Calendars.DAY_OF_MONTH, day)
                        tcal.set(Calendars.MONTH, mon)
                        let nTime = tcal.getTime()
                        if(nTime < afterTime) {
                            day = 1
                            mon++
                        }
                    }
                } else if(nearestWeekday) {
                    t = day
                    day = daysOfMonth.firstValue()

                    var tcal: Calendars = Calendars.getInstance(getTimeZone())
                    tcal.set(Calendars.MILLISECOND, 0)
                    tcal.set(Calendars.SECOND, 0)
                    tcal.set(Calendars.MINUTE, 0)
                    tcal.set(Calendars.HOUR_OF_DAY, 0)
                    tcal.set(Calendars.DAY_OF_MONTH, day)
                    tcal.set(Calendars.MONTH, mon)
                    tcal.set(Calendars.YEAR, cl.get(Calendars.YEAR))
                    
                    var ldom: Int64 = getLastDayOfMonth(mon, cl.get(Calendars.YEAR))
                    var dow: Int64 = tcal.get(Calendars.DAY_OF_WEEK)

                    if(dow == Calendars.SATURDAY && day == 1) {
                        day += 2
                    } else if(dow == Calendars.SATURDAY) {
                        day -= 1
                    } else if(dow == Calendars.SUNDAY && day == ldom) { 
                        day -= 2
                    } else if(dow == Calendars.SUNDAY) { 
                        day += 1
                    }
                        
                    tcal.set(Calendars.SECOND, sec)
                    tcal.set(Calendars.MINUTE, min)
                    tcal.set(Calendars.HOUR_OF_DAY, hr)
                    tcal.set(Calendars.DAY_OF_MONTH, day)
                    tcal.set(Calendars.MONTH, mon)
                    let nTime = tcal.getTime()
                    if(nTime < afterTime) {
                        day = daysOfMonth.firstValue()
                        mon++
                    }
                } else if (st.size != 0) {
                    t = day
                    day = st.firstValue()
                    // make sure we don't over-run a short month, such as february
                    var lastDay = getLastDayOfMonth(mon, cl.get(Calendars.YEAR))
                    if (day > lastDay) {
                        day = daysOfMonth.firstValue()
                        mon++
                    }
                } else {
                    day = daysOfMonth.firstValue()
                    mon++
                }
                
                if (day != t || mon != tmon) {
                    cl.set(Calendars.SECOND, 0)
                    cl.set(Calendars.MINUTE, 0)
                    cl.set(Calendars.HOUR_OF_DAY, 0)
                    cl.set(Calendars.DAY_OF_MONTH, day)
                    cl.set(Calendars.MONTH, mon ) 
                    continue
                }
            } else if (dayOfWSpec && !dayOfMSpec) { // get day by day of week rule
                if (lastdayOfWeek) { // are we looking for the last XXX day of the month?
                    var dow: Int64 = daysOfWeek.firstValue() // desired
                    // d-o-w
                    var cDow: Int64 = cl.get(Calendars.DAY_OF_WEEK) // current d-o-w

                    var daysToAdd: Int64 = 0
                    if (cDow < dow) {
                        daysToAdd = dow - cDow
                    }
                    if (cDow > dow) {
                        daysToAdd = dow + (7 - cDow)
                    }

                    var lDay = getLastDayOfMonth(mon, cl.get(Calendars.YEAR))

                    if (day + daysToAdd > lDay) { // did we already miss the last one?
                        cl.set(Calendars.SECOND, 0)
                        cl.set(Calendars.MINUTE, 0)
                        cl.set(Calendars.HOUR_OF_DAY, 0)
                        cl.set(Calendars.DAY_OF_MONTH, 1)
                        cl.set(Calendars.MONTH, mon+1)
                        continue
                    }

                    // find date of last occurrence of this day in this month...
                    while ((day + daysToAdd + 7) <= lDay) {
                        daysToAdd += 7
                    }

                    day += daysToAdd

                    if (daysToAdd > 0) {
                        cl.set(Calendars.SECOND, 0)
                        cl.set(Calendars.MINUTE, 0)
                        cl.set(Calendars.HOUR_OF_DAY, 0)
                        cl.set(Calendars.DAY_OF_MONTH, day)
                        cl.set(Calendars.MONTH, mon )
                        continue
                    }

                } else if (nthdayOfWeek != 0) {

                    // are we looking for the Nth XXX day in the month?
                    var dow: Int64 = daysOfWeek.firstValue() // desired
                    // d-o-w
                    var cDow: Int64 = cl.get(Calendars.DAY_OF_WEEK) // current d-o-w

                    var daysToAdd: Int64 = 0
                    if (cDow < dow) {
                        daysToAdd = dow - cDow
                    } else if (cDow > dow) {
                        daysToAdd = dow + (7 - cDow)
                    }

                    var dayShifted: Bool = false
                    if (daysToAdd > 0) {
                        dayShifted = true
                    }

                    day += daysToAdd
                    var weekOfMonth = day / 7
                    if (day % 7 > 0) {
                        weekOfMonth++
                    }

                    daysToAdd = (nthdayOfWeek - weekOfMonth) * 7
                    day += daysToAdd
                    if (daysToAdd < 0 || day > getLastDayOfMonth(mon, cl.get(Calendars.YEAR))) {
                        cl.set(Calendars.SECOND, 0)
                        cl.set(Calendars.MINUTE, 0)
                        cl.set(Calendars.HOUR_OF_DAY, 0)
                        cl.set(Calendars.DAY_OF_MONTH, 1)
                        cl.set(Calendars.MONTH, mon+1) 
                        continue
                    } else if (daysToAdd > 0 || dayShifted) {
                        cl.set(Calendars.SECOND, 0)
                        cl.set(Calendars.MINUTE, 0)
                        cl.set(Calendars.HOUR_OF_DAY, 0)
                        cl.set(Calendars.DAY_OF_MONTH, day)
                        cl.set(Calendars.MONTH, mon) 
                        continue
                    }
                } else {
                    var cDow: Int64 = cl.get(Calendars.DAY_OF_WEEK) // current d-o-w
                    var dow: Int64 = daysOfWeek.firstValue() // desired
                    // d-o-w
                    st = daysOfWeek.tailSet(cDow)
                    if (st.size > 0) {
                        dow = st.firstValue()
                    }

                    var daysToAdd: Int64 = 0
                    if (cDow < dow) {
                        daysToAdd = dow - cDow
                    }
                    if (cDow > dow) {
                        daysToAdd = dow + (7 - cDow)
                    }

                    var lDay = getLastDayOfMonth(mon, cl.get(Calendars.YEAR))

                    if (day + daysToAdd > lDay) { // will we pass the end of the month?
                        cl.set(Calendars.SECOND, 0)
                        cl.set(Calendars.MINUTE, 0)
                        cl.set(Calendars.HOUR_OF_DAY, 0)
                        cl.set(Calendars.DAY_OF_MONTH, 1)
                        cl.set(Calendars.MONTH, mon+1)  
                        continue
                    } else if (daysToAdd > 0) { // are we swithing days?
                        cl.set(Calendars.SECOND, 0)
                        cl.set(Calendars.MINUTE, 0)
                        cl.set(Calendars.HOUR_OF_DAY, 0)
                        cl.set(Calendars.DAY_OF_MONTH, day + daysToAdd)
                        cl.set(Calendars.MONTH, mon)
                        continue
                    }
                }
            } else { // dayOfWSpec && !dayOfMSpec
                throw Exception("Support for specifying both a day-of-week AND a day-of-month parameter is not implemented.")
            }
            cl.set(Calendars.DAY_OF_MONTH, day)

            mon = cl.get(Calendars.MONTH) 
            var year = cl.get(Calendars.YEAR)
            t = -1

            // test for expressions that never generate a valid fire date, but keep looping...
            if (year > TimeUtil.YEAR_TO_GIVEUP_SCHEDULING_AT) {
                return None
            }

            // get month...................................................
            st = months.tailSet(mon)
            if (st.size != 0) {
                t = mon
                mon = st.firstValue()
            } else {
                mon = months.firstValue()
                year++
            }
            if (mon != t) {
                cl.set(Calendars.SECOND, 0)
                cl.set(Calendars.MINUTE, 0)
                cl.set(Calendars.HOUR_OF_DAY, 0)
                cl.set(Calendars.DAY_OF_MONTH, 1)
                cl.set(Calendars.MONTH, mon)  
                cl.set(Calendars.YEAR, year)
                continue
            }
            cl.set(Calendars.MONTH, mon) 

            year = cl.get(Calendars.YEAR)
            t = -1

            // get year...................................................
            st = years.tailSet(year)
            if (st.size != 0) {
                t = year
                year = st.firstValue()
            } else {
                return None // ran out of years...
            }

            if (year != t) {
                cl.set(Calendars.SECOND, 0)
                cl.set(Calendars.MINUTE, 0)
                cl.set(Calendars.HOUR_OF_DAY, 0)
                cl.set(Calendars.DAY_OF_MONTH, 1)
                cl.set(Calendars.MONTH, 1)  
                cl.set(Calendars.YEAR, year)
                continue
            }
            cl.set(Calendars.YEAR, year)

            gotOne = true
        } // while( !done )

        return cl.getTime()
    }