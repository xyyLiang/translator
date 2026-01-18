    private func getMiddleSnake(start1: Int64, end1: Int64, start2: Int64, end2: Int64): ?Snake {
        let m: Int64 = end1 - start1
        let n: Int64 = end2 - start2
        if (m == 0 || n == 0) {
            return None
        }

        let delta: Int64 = m - n //反向k的中心
        let sum: Int64 = n + m
        let offset: Int64
        if (sum % 2 == 0) {
            offset = sum / 2
        } else {
            offset = (sum + 1) / 2
        }

        vDown[1 + offset] = start1 //正向
        vUp[1 + offset] = end1 + 1 //反向

        for (d in 0..=offset) {
            //Down
            for (k in -d..=d : 2) {
                //First step
                let i: Int64 = k + offset
                if (k == -d || k != d && vDown[i - 1] < vDown[i + 1]) {
                    vDown[i] = vDown[i + 1] //向下
                } else {
                    vDown[i] = vDown[i - 1] + 1 //向右
                }

                var x: Int64 = vDown[i]
                var y: Int64 = x - start1 + start2 - k // -(start1-start2) 减原始k

                //斜边
                while (x < end1 && y < end2 && left.get(x) == right.get(y)) {
                    x++
                    vDown[i] = x
                    y++
                }

                //Second step
                //奇数，正向结束，保证正向k没有超出上一轮反向k的范围
                if (delta % 2 != 0 && delta - d <= k && k <= delta + d) {
                    if (vUp[i - delta] <= vDown[i]) { //NOPMD
                        return buildSnake(vUp[i - delta], k + start1 - start2, end1, end2)
                    }
                }
            }

            //Up
            for (k in delta - d..=delta + d : 2) {
                //First step
                let i: Int64 = k + offset - delta //与正向x保持一致
                if (k == delta - d || k != delta + d && vUp[i + 1] <= vUp[i - 1]) {
                    vUp[i] = vUp[i + 1] - 1 //向左
                } else {
                    vUp[i] = vUp[i - 1] //向上
                }

                var x: Int64 = vUp[i] - 1 //左边从0开始
                var y: Int64 = x - start1 + start2 - k

                //斜边
                while (x >= start1 && y >= start2 && left.get(x) == right.get(y)) {
                    vUp[i] = x
                    x--
                    y--
                }

                //Second step
                //偶数，反向结束，保证反向k没有超出这一轮正向k的范围
                if (delta % 2 == 0 && -d <= k && k <= d) {
                    if (vUp[i] <= vDown[i + delta]) { //NOPMD                        
                        return buildSnake(vUp[i], k + start1 - start2, end1, end2)
                    }
                }
            }
        }

        throw Exception("Internal Error")
    }