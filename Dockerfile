FROM jekyll/jekyll:3.8.3 as build-stage

WORKDIR /tmp

COPY Gemfile* ./

RUN bundle install

WORKDIR /usr/src/app

COPY . .

RUN chown -R jekyll .

RUN jekyll build

FROM nginx:alpine

COPY ${PWD}/templates/default.conf.template /etc/nginx/templates/default.conf.template

COPY --from=build-stage /usr/src/app/_site/ /usr/share/nginx/html
