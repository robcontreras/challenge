FROM ruby:2.7.2
RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update -qq && apt-get install -y build-essential nodejs git yarn nano
RUN mkdir /synak_challenge
COPY . /synak_challenge
WORKDIR synak_challenge
RUN chmod +x docker/entrypoint.sh
RUN gem install bundler -v="2.1.4"
RUN gem install rails -v="6.1.3.2"