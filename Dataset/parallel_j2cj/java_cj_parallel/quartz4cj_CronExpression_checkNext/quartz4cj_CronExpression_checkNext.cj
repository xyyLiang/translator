    private func checkNext(pos: Int64, s: Array<Char>, val: Int64, types: Int64): Unit {
        var end = -1
        var i = pos

        if (i >= s.size) {
            addToSet(val, end, -1, types)
            return
        }

        var c = s[i]

        if (c == 'L') {
            if (types == DAY_OF_WEEK) {
                if(val < 1 || val > 7) {
                    throw ParseException("Day-of-Week values must be between 1 and 7", -1)
                }
                lastdayOfWeek = true
            } else {
                throw ParseException("'L' option is not valid here. (pos=${i})")
            }
            let set = getSet(types)
            set.add(val)
            i++
            return
        }

        if (c == 'W') {
            if (types == DAY_OF_MONTH) {
                nearestWeekday = true
            } else {
                throw ParseException("'W' option is not valid here. (pos=" + i.toString() + ")", i)
            }
            if(val > 31) {
                throw ParseException("The 'W' option does not make sense with values larger than 31 (max number of days in a month)", i) 
            }
            let set = getSet(types)
            set.add(val)
            i++
            return
        }

        if (c == '#') {
            if (types != DAY_OF_WEEK) {
                throw ParseException("'#' option is not valid here. (pos=" + i.toString() + ")", i)
            }
            i++
            try {
                nthdayOfWeek = Int64.parse(newString(s,i))
                if (nthdayOfWeek < 1 || nthdayOfWeek > 5) {
                    throw Exception()
                }
            } catch (e: Exception) {
                throw ParseException("A numeric value between 1 and 5 must follow the '#' option", i)
            }

            let set  = getSet(types)
            set.add(val)
            i++
            return
        }

        if (c == '-') {
            i++
            c = s[i]
            let v = Int64.parse(c.toString())
            end = v
            i++
            if (i >= s.size) {
                addToSet(val, end, 1, types)
                return
            }
            c = s[i]
            if (c >= '0' && c <= '9') {
                let vs = getValue(v.toString(), s, i)
                end = vs[0]
                i = vs[1]
            }

            if (i < s.size ) {
                c = s[i]
                if( c == '/' ) {
                    i++
                    c = s[i]
                    let v2 = Int64.parse(c.toString())
                    i++
                    if (i >= s.size) {
                        addToSet(val, end, v2, types)
                        return
                    }
                    c = s[i]
                    if (c >= '0' && c <= '9') {
                        let vs = getValue(v2.toString(), s, i)
                        let v3 = vs[0]
                        addToSet(val, end, v3, types)
                        i = vs[1]
                        return
                    } else {
                        addToSet(val, end, v2, types)
                        return
                    }
                } else {
                    addToSet(val, end, 1, types)
                    return
                }
            } else {
                addToSet(val, end, 1, types)
                return
            }
        }

        if (c == '/') {
            if ((i + 1) >= s.size || s[i + 1] == ' ') {
                throw ParseException("'/' must be followed by an integer.", i)
            }

            i++
            c = s[i]
            let v2 = Int64.parse(c.toString())
            i++
            if (i >= s.size) {
                checkIncrementRange(v2, types, i)
                addToSet(val, end, v2, types)
                return
            }
            c = s[i]
            if (c >= '0' && c <= '9') {
                let vs = getValue(v2.toString(), s, i)
                let v3 = vs[0]
                checkIncrementRange(v3, types, i)
                addToSet(val, end, v3, types)
                i = vs[1]
                return
            } else {
                throw ParseException("Unexpected character '" + c.toString() + "' after '/'", i)
            }
        }

        addToSet(val, end, 0, types)
        i++
        return
    }