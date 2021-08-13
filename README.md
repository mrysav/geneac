# Geneac

[![Test Coverage](https://api.codeclimate.com/v1/badges/4f02be904a9d52414167/test_coverage)](https://codeclimate.com/github/mrysav/geneac/test_coverage)

- **[Homepage](https://mrysav.github.io/geneac)**

- **[Demo Site](https://geneac-demo.herokuapp.com/)**

## Quickstart

### Docker

Docker is the preferred method for running Geneac locally for development.

`docker-compose.yml` contains a basic configuration you can use to run Postgres and Redis. Ruby must be installed locally. To develop geneac, you can run these commands:

```bash
# Start Postgres and Redis locally, with Docker
docker-compose up -d

# Install dependencies
bundle install

# Create the database
rails db:create db:schema:load

# Start the app!
foreman start -f Procfile.dev
```

For deploying a production instance of Geneac with all of the dependencies running in Docker, including Minio for S3-compatible storage, `docker-compose.prod.sample.yml` provides a starting point for configuration.

### Heroku

If you already have a [Heroku](https://heroku.com) account you can click this to get up and running:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This will provision the Heroku Postgres and Redis instances for you, but you will need to supply your S3 storage configuration yourself.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for a guide on making contributions.
