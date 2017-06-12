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
* Listen for HTTP requests on port `3000`.

## Example Configuration

Using this image in your `docker-compose.yml` should look something like this:

    labels:
      - convox.port.80.protocol=http
      - convox.port.443.protocol=https
    ports:
      - 80:3000
      - 443:3000

## Includes

### Standard Ruby development headers

* `libmysqld-dev`
* `libpq-dev`
* `libsqlite3-dev`
* `ruby-dev`
