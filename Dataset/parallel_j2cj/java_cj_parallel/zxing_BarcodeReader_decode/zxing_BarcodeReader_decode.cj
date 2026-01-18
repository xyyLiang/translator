    public open func decode(image: BinaryBitmap, hints: ?HashMap<DecodeHintType, Any>): Result {
        try {
            doDecode(image, hints)
        } catch (nfe: NotFoundException) {
            let tryHarder = if (let Some(h) = hints) {
                h.contains(DecodeHintType.TRY_HARDER)
            } else {
                false
            }
            if (tryHarder && image.isRotateSupported()) {
                let rotatedImage = image.rotateCounterClockwise()
                let result = doDecode(rotatedImage, hints)
                let metadata = result.resultMetadata
                var orientation = 270
                if (let Some(h) = metadata) {
                    if (let Some(r) = h.get(ResultMetadataType.ORIENTATION)) {
                        orientation = (orientation + (r as Int64).getOrThrow()) % 360
                    }
                }
                result.putMetadata(ResultMetadataType.ORIENTATION, orientation)
                if (let Some(p) = result.resultPoints) {
                    let height = Float64(rotatedImage.binarizer.source.height)
                    for (i in 0..p.size) {
                        p[i] = ResultPoint(height - p[i].y - 1.0, p[i].x)
                    }
                }
                result
            } else {
                throw nfe
            }
        }
    }