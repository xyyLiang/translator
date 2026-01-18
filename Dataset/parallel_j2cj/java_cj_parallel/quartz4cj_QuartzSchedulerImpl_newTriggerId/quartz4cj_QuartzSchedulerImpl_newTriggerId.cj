    private func newTriggerId() : String{
        var r = random.nextInt64();
        if (r < 0) {
            r = -r;
        }

        let v = 30 +  (DateTime.currentTimeMillis() % 7)
        return "MT_${toRadixString(r,v)}"
    }