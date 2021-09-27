FROM ruby:2.7.4
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq \
    && apt-get install -y nodejs yarn \
    && mkdir /doc_rails
WORKDIR /doc_rails
COPY Gemfile /doc_rails/Gemfile
COPY Gemfile.lock /doc_rails/Gemfile.lock
RUN bundle install
COPY . /doc_rails

#RUN RAILS_ENV=${RAILS_ENV} bundle exec rails assets:precompile

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD ["rails", "s"]