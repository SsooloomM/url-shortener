FROM ruby:3.4.6

# Install dependencies
RUN apt-get update -qq && apt-get install -y postgresql-client

# Set working directory
WORKDIR /app

# Cache gems if Gemfile hasn't changed
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 4 --retry 3

# Copy the app
COPY . .

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]