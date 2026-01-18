    @Override
    public int hashCode() {
        return (int) _address ^ (int) (_address >>> 32);
    }