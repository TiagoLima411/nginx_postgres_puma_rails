FROM ruby:2.6
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client vim
RUN mkdir /rails_app
WORKDIR /rails_app
COPY Gemfile /rails_app/Gemfile
COPY Gemfile.lock /rails_app/Gemfile.lock
RUN bundle install
COPY . /rails_app
EXPOSE 4200
CMD ["bundle", "exec", "rails", "s", "-p", "4200", "-b", "0.0.0.0"]
#CMD ["bundle", "exec", "puma", "-C", "confing/puma.rb"]
