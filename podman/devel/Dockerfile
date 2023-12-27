FROM ruby:3.2.2

ENV RAILS_ENV=development

RUN apt update -qq && \
  apt install -y --no-install-recommends build-essential libpq-dev curl && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && \
  apt-key add /root/yarn-pubkey.gpg && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
  apt update && \
  apt install -y --no-install-recommends nodejs yarn \
    iputils-ping uuid openjdk-17-jre-headless graphviz iproute2 && \
  setcap cap_net_raw+p `which ping` && \
  apt clean && rm -rf /var/lib/apt/lists/*

#   apt install -y --no-install-recommends  libgtk-3-0 libgtk2.0-dev && \

WORKDIR /app

COPY Gemfile* ./
RUN bundle install -j $(nproc)

COPY package.json yarn.lock ./
RUN yarn install --ignore-scripts

CMD ["rails", "server", "-b", "0.0.0.0"]
