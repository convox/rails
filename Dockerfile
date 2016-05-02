FROM convox/ruby

RUN apk update
RUN apk add nginx nodejs yaml

ENV PORT 5000

COPY bin/web /app/bin/web
COPY conf/convox.rb /app/config/initializers/convox.rb

CMD ["bin/web"]
