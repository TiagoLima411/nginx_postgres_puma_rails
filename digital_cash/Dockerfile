FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim nano
RUN mkdir /digital_cash
WORKDIR /digital_cash
COPY Gemfile /digital_cash/Gemfile
COPY Gemfile.lock /digital_cash/Gemfile.lock
RUN bundle install
COPY . /digital_cash
EXPOSE 3000
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
#CMD ["bundle", "exec", "puma", "-C", "confing/puma.rb"]
