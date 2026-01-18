func squaredDistance(a: FinderPattern, b: FinderPattern): Float64 {
    let x = a.x - b.x
    let y = a.y - b.y
    return x * x + y * y
}