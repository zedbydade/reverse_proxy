FROM ruby:3.2.0

WORKDIR /usr/src/app

COPY . .

RUN bundle install

EXPOSE 80

ENV NAME World

ENTRYPOINT ["ruby", "lib/main.rb"]
