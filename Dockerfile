
FROM ruby:3.0
ENV APP /opt/server
WORKDIR $APP

COPY Gemfile Gemfile.lock $APP

RUN bundle install -j 10 --quiet

COPY . $APP

EXPOSE 8080

CMD bundle exec