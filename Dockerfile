FROM convox/ruby

RUN apt-get update && apt-get -y install libmysqld-dev libpq-dev libsqlite3-dev nginx nodejs tzdata

ENV PORT 5000

COPY bin/web /app/bin/web
COPY conf/convox.rb /app/config/initializers/convox.rb
COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["bin/web"]
