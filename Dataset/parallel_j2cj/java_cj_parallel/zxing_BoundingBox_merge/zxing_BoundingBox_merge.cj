    static func merge(leftBox: ?BoundingBox, rightBox: ?BoundingBox): ?BoundingBox {
        if (let None = leftBox) {
            rightBox
        } else if (let None = rightBox) {
            leftBox
        } else if (let (Some(l), Some(r)) = (leftBox, rightBox)) {
            BoundingBox(l.image, l.topLeft, l.bottomLeft, r.topRight, r.bottomRight)
        } else {
            None
        }
    }