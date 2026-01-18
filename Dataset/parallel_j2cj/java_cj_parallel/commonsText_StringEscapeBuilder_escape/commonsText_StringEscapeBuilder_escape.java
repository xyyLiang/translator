        public Builder escape(final String input) {
            sb.append(translator.translate(input));
            return this;
        }