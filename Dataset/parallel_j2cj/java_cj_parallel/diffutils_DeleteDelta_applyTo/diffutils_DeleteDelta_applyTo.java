    @Override
    protected void applyTo(List<T> target) throws PatchFailedException {
        int position = getSource().getPosition();
        int size = getSource().size();
        for (int i = 0; i < size; i++) {
            target.remove(position);
        }
    }