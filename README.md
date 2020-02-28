# Geneac

[![Build Status](https://travis-ci.com/mrysav/geneac.svg?branch=master)](https://travis-ci.com/mrysav/geneac)
[![Test Coverage](https://api.codeclimate.com/v1/badges/4f02be904a9d52414167/test_coverage)](https://codeclimate.com/github/mrysav/geneac/test_coverage)

## [Homepage](https://mrysav.github.io/geneac)

## Quickstart

If you already have a [Heroku](https://heroku.com) account you can click this to get up and running:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Requirements

If you want to run your own instance of Geneac, you must be familiar with Ruby on Rails web applications. This is the stack I used for development:

* Ruby & Bundler (see `.ruby-version` for version info)
  * You can use [rbenv](https://github.com/sstephenson/rbenv) to keep versions clean and separated.
* NodeJS + Yarn (see `.nvmrc` for version)
  * You can use NVM or [nodenv](https://github.com/nodenv/nodenv) to keep versions separated. (nodenv will require [nodenv-nvmrc](https://github.com/ouchxp/nodenv-nvmrc) to use `.nvmrc`)
* [foreman](https://github.com/ddollar/foreman)-compatible launcher for Procfile-based launch
* PostgreSQL

If this is your first time running geneac, you need to configure the database:

    rails db:create db:migrate

And to start:

    foreman start
    bin/webpack-dev-server start

## Contributing

If you have an idea for a feature or suggestion, feel free submit a pull request or send me an email! [mitchell.rysavy@gmail.com](mailto:mitchell.rysavy@gmail.com)
