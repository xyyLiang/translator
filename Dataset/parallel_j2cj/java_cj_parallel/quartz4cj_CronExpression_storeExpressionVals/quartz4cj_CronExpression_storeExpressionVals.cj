    private func storeExpressionVals(pos: Int64, s: Array<Char>, types: Int64): Unit {

        var i = skipWhiteSpace(pos, s)
        if (i >= s.size) {
            return
        }

        var incr = 0
        var c = s[i]

        var ss = String(s) // todo

        if ((c >= 'A') && (c <= 'Z') && (ss != "L") && (ss != "LW") && (!ss.matches("^L-[0-9]*[W]?"))) {
            var sub = newString(s,i, 3)
            var sval = -1
            var eval = -1
            if (types == MONTH) {
                sval = getMonthNumber(sub) + 1
                if (sval <= 0) {
                    throw ParseException("Invalid Month value: '${sub}'", i)
                }
                if (s.size > i + 3) {
                    c = s[i + 3]
                    if (c == '-') {
                        i += 4
                        sub = newString(s,i, 3)
                        eval = getMonthNumber(sub) + 1
                        if (eval <= 0) {
                            throw ParseException("Invalid Month value: '${sub}'", i)
                        }
                    }
                }
            } else if (types == DAY_OF_WEEK) {
                sval = getDayOfWeekNumber(sub)
                if (sval < 0) {
                    throw ParseException("Invalid Day-of-Week value: '${sub}'", i)
                }
                if (s.size > i + 3) {
                    c = s[i + 3]
                    if (c == '-') {
                        i += 4
                        sub = newString(s,i, 3)
                        eval = getDayOfWeekNumber(sub)
                        if (eval < 0) {
                            throw ParseException("Invalid Day-of-Week value: '${sub}'", i)
                        }
                    } else if (c == '#') {
                        try {
                            i += 4
                            nthdayOfWeek = Int64.parse(newString(s,i))
                            if (nthdayOfWeek < 1 || nthdayOfWeek > 5) {
                                throw Exception()
                            }
                        } catch (e: Exception) {
                            throw ParseException("A numeric value between 1 and 5 must follow the '#' option", i)
                        }
                    } else if (c == 'L') {
                        lastdayOfWeek = true
                        i++
                    }
                }
            } else {
                throw ParseException("Illegal characters for this position: '${sub}'", i)
            }
            if (eval != -1) {
                incr = 1
            }
            addToSet(sval, eval, incr, types)
            return
        }

        if (c == '?') {
            if (i + 1 < s.size && s[i+1] != ' ') { // quartz 原有代码这里有 bug， 下标用的不准确
                throw ParseException("Illegal character after '?': " + s[i].toString(), i)
            }
            if (types != DAY_OF_WEEK && types != DAY_OF_MONTH) {
                throw ParseException("'?' can only be specified for Day-of-Month or Day-of-Week.", i)
            }
            if (types == DAY_OF_WEEK && !lastdayOfMonth  ) { // !lastdayOfMonth  理解不了
                if (daysOfMonth.contains(NO_SPEC_INT)) {
                    throw ParseException("'?' can only be specified for Day-of-Month -OR- Day-of-Week.", i)
                }
            }

            addToSet(NO_SPEC_INT, -1, 0, types)
            return
        }

        if (c == '*' || c == '/') {
            if (c == '*' && (i + 1) >= s.size) {
                addToSet(ALL_SPEC_INT, -1, incr, types)
                return
            } else if (c == '/' && ((i + 1) >= s.size || s[i + 1] == ' ')) { 
                throw ParseException("'/' must be followed by an integer.", i)
            } else if (c == '*') {
                i++
            }

            c = s[i]
            if (c == '/') { // is an increment specified?
                i++
                if (i >= s.size) {
                    throw ParseException("Unexpected end of string.", i)
                }

                incr = getNumericValue(s, i)

                i += incr.toString().size

                checkIncrementRange(incr, types, i)
            } else {
                incr = 1
            }

            addToSet(ALL_SPEC_INT, -1, incr, types)
            return
        } else if (c == 'L') {
            i++
            if (types == DAY_OF_MONTH) {
                lastdayOfMonth = true
            }
            if (types == DAY_OF_WEEK) {
                addToSet(7, 7, 0, types)
            }
            if(types == DAY_OF_MONTH && s.size > i) {
                c = s[i]
                if(c == '-') {
                    var vs = getValue("", s, i+1)
                    lastdayOffset = vs[0]
                    if(lastdayOffset > 30) {
                        throw ParseException("Offset from last day must be <= 30", i+1)
                    }
                    i = vs[1]
                }                        
                if(s.size > i) {
                    c = s[i]
                    if(c == 'W') {
                        nearestWeekday = true
                        i++
                    }
                }
            }
            return
        } else if (c >= '0' && c <= '9') {
            var val = Int64.parse(c.toString())
            i++
            if (i >= s.size) {
                addToSet(val, -1, -1, types)
            } else {
                c = s[i]
                if (c >= '0' && c <= '9') {
                    var vs = getValue(val.toString(), s, i)
                    val = vs[0]
                    i = vs[1]
                }
                checkNext(i, s, val, types)
                return
            }
        } else {
            throw ParseException("Unexpected character: ${c}", i)
        }

        return
    }    