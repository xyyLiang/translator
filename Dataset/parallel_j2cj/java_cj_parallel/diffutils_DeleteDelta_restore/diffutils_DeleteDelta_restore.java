    @Override
    protected void restore(List<T> target) {
        int position = this.getTarget().getPosition();
        List<T> lines = this.getSource().getLines();
        for (int i = 0; i < lines.size(); i++) {
            target.add(position + i, lines.get(i));
        }
    }