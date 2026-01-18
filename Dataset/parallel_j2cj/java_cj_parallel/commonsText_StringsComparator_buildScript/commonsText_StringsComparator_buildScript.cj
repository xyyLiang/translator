    private func buildScript(start1: Int64, end1: Int64, start2: Int64, end2: Int64, script: EditScript<Char>): Unit {
        let middle: ?Snake = getMiddleSnake(start1, end1, start2, end2)

        //拆分到不能拆分的最小单元
        //middle?.getStart()==None 效果等同于 java的 ==null
        if (middle?.getStart() == None || middle?.getStart() == end1 && middle?.getDiag() == end1 - end2 ||
            middle?.getEnd() == start1 && middle?.getDiag() == start1 - start2) {
            var i = start1
            var j = start2
            while (i < end1 || j < end2) {
                if (i < end1 && j < end2 && left.get(i) == right.get(j)) {
                    script.append(KeepCommand<Char>(left.get(i).getOrThrow()))
                    i++
                    j++
                } else {
                    //x比y长时删除优先
                    if (end1 - start1 > end2 - start2) {
                        script.append(DeleteCommand<Char>(left.get(i).getOrThrow()))
                        i++
                    } else {
                        script.append(InsertCommand<Char>(right.get(j).getOrThrow()))
                        j++
                    }
                }
            }
        } else {
            let m = middle.getOrThrow()

            buildScript(start1, m.getStart(), start2, m.getStart() - m.getDiag(), script)
            for (i in m.getStart()..m.getEnd()) {
                script.append(KeepCommand<Char>(left.get(i).getOrThrow()))
            }
            buildScript(m.getEnd(), end1, m.getEnd() - m.getDiag(), end2, script)
        }
    }