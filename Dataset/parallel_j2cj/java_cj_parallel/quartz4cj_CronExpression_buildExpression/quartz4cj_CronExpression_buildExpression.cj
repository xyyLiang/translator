    private func buildExpression(expression: String): Unit {
        expressionParsed = true

        try {
            var exprOn: Int64 = SECOND

            let exprsTok = expression.replace("\t"," ").split(" ", removeEmpty: true)
            var idx = 0
            while (idx < exprsTok.size && exprOn <= YEAR) {
                let expr = exprsTok[idx].trim()
                idx++

                // throw an exception if L is used with other days of the month
                if(exprOn == DAY_OF_MONTH && expr.contains("L") && expr.size > 1 && expr.contains(",")) {
                    throw ParseException("Support for specifying 'L' and 'LW' with other days of the month is not implemented", -1)
                }
                // throw an exception if L is used with other days of the week
                if(exprOn == DAY_OF_WEEK && expr.contains("L") && expr.size > 1  && expr.contains(",")) {
                    throw ParseException("Support for specifying 'L' with other days of the week is not implemented", -1)
                }
                if(exprOn == DAY_OF_WEEK && expr.contains("#")  && substring(expr,(expr.indexOf("#") ?? -1 ) + 1).contains("#") ) {
                    throw ParseException("Support for specifying multiple \"nth\" days is not implemented.", -1)
                }

                let vTok = expr.split(",",removeEmpty: true)
                for( v in vTok ) {
                    storeExpressionVals(0, v.toRuneArray(), exprOn)
                }

                exprOn++
            }

            if (exprOn <= DAY_OF_WEEK) {
                throw ParseException("Unexpected end of expression.", expression.size)
            }

            if (exprOn <= YEAR) {
                storeExpressionVals(0, "*".toRuneArray(), YEAR)
            }

            let dayOfMSpec = !getSet(DAY_OF_MONTH).contains(NO_SPEC)
            let dayOfWSpec = !getSet(DAY_OF_WEEK).contains(NO_SPEC)

            if (!dayOfMSpec || dayOfWSpec) {
                if (!dayOfWSpec || dayOfMSpec) {
                    throw ParseException( "Support for specifying both a day-of-week AND a day-of-month parameter is not implemented.", 0)
                }
            }

        } catch (pe: ParseException) {
            throw pe
        } catch (e: Exception) {
            throw ParseException("Illegal cron expression format (${e.message})", 0)
        }
    }    