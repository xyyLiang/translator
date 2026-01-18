    @Override
    protected void restore(List<T> target) {
        int position = getTarget().getPosition();
        int size = getTarget().size();
        for (int i = 0; i < size; i++) {
            target.remove(position);
        }
    }