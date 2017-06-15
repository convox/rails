# convox/rails

Convox base image for Ruby on Rails

## Usage

	FROM convox/rails
	
	# copy only the files needed for bundle install
	COPY Gemfile      /app/Gemfile
	COPY Gemfile.lock /app/Gemfile.lock
	RUN bundle install
	
	# copy only the files needed for assets:precompile
	COPY Rakefile   /app/Rakefile
	COPY config     /app/config
	COPY public     /app/public
	COPY app/assets /app/app/assets
	RUN rake assets:precompile
	
	# copy the rest of the app
	COPY . /app

## Expectations

Application using this image should:

* Copy their source files into `/app`
* Listen for HTTP requests on port `5000`.

## Exports

* Listen for HTTP request on port `4000` and redirects all requests to `https://`.
* Listen for HTTP requests on port `4001` accepting PROXY protocol and injecting `X-Forwarded-For` headers.

## Example Configuration

Using this image in your `docker-compose.yml` should look something like this:

    labels:
      - convox.port.443.protocol=tls
      - convox.port.443.proxy=true
    ports:
      - 80:4000
      - 443:4001

## Includes

### Base Image: [convox/ruby](convox/ruby)

### Standard Ruby development headers

* `libmysqld-dev`
* `libpq-dev`
* `libsqlite3-dev`
* `ruby-dev`

### nginx

* Buffers incoming HTTP requests
* Accept PROXY protocol headers to discover source IP
* Inject `X-Forwarded-Proto` and `X-Forwarded-For`
* Serve `/assets` from disk without hitting the Rails app
