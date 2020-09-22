# Geneac

[![Build Status](https://travis-ci.com/mrysav/geneac.svg?branch=master)](https://travis-ci.com/mrysav/geneac)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4f02be904a9d52414167/test_coverage)](https://codeclimate.com/github/mrysav/geneac/test_coverage)

* **[Homepage](https://mrysav.github.io/geneac)**

* **[Demo Site](https://geneac-demo.herokuapp.com/)**

## Quickstart

### Prerequisites

A few things are assumed to be setup to run your own instance of Geneac:

* Postgres
* Redis
* S3-compatible storage (can be S3, Minio, B2, Spaces, etc)

### Heroku

If you already have a [Heroku](https://heroku.com) account you can click this to get up and running:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This will provision the Heroku Postgres and Redis instances for you, but you will need to supply your S3 storage configuration yourself.

### Docker

Geneac can be deployed using Docker (see the provided Dockerfile) but the Postgres, Redis and S3 configurations have to be supplied via environment variables.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for a guide on making contributions.
