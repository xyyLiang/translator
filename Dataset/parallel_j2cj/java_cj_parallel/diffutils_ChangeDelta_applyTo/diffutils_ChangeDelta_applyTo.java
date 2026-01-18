    @Override
    protected void applyTo(List<T> target) throws PatchFailedException {
        int position = getSource().getPosition();
        int size = getSource().size();
        for (int i = 0; i < size; i++) {
            target.remove(position);
        }
        int i = 0;
        for (T line : getTarget().getLines()) {
            target.add(position + i, line);
            i++;
        }
    }