    @Override
    protected void applyTo(List<T> target) throws PatchFailedException {
        int position = this.getSource().getPosition();
        List<T> lines = this.getTarget().getLines();
        for (int i = 0; i < lines.size(); i++) {
            target.add(position + i, lines.get(i));
        }
    }