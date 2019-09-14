FROM ruby:2.6

WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY . .

ENTRYPOINT ["/usr/local/bin/ruby", "update.rb"]
