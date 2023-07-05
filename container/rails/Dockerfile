FROM ruby:3.0.0

RUN apt-get update -qq && apt-get install -y nodejs
WORKDIR /app
COPY ./src /app
RUN bundle config --local set path 'vendor/bundle' \ && bundle install