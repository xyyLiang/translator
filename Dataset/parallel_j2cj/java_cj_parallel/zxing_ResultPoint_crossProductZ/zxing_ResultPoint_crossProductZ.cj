public func crossProductZ(pointA: ResultPoint, pointB: ResultPoint, pointC: ResultPoint): Float64 {
    let x = pointB.x
    let y = pointB.y
    ((pointC.x - x) * (pointA.y - y)) - ((pointC.y - y) * (pointA.x - x))
}