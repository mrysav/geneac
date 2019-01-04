# Geneac

Geneac is a follow-up to my previous genealogy app [familiar](https://github.com/mrysav/familiar). I am abandoning familiar since I mostly created all the features myself and I am sick of fixing a million little problems when I just want to work on the site. With Geneac, I hope to leverage better, more Rails-like technologies like Devise and Administrate to avoid writing line upon line of boilerplate code.

## Quickstart

If you already have a [Heroku](https://heroku.com) account you can click this to get up and running:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Requirements

If you want to run your own instance of Geneac, you must be familiar with Ruby on Rails web applications. This is the stack I used for development:

* Ruby & Bundler (see `.ruby-version` for version info) (installing with [rbenv](https://github.com/sstephenson/rbenv) is highly recommended)
* [foreman](https://github.com/ddollar/foreman)-compatible launcher for Procfile-based launch
* PostgreSQL

If this is your first time running geneac, you need to configure the database:

    rails db:create db:migrate

And to start:

    foreman start

## Roadmap

Geneac 0.1 Roadmap:

* [x] Admin console
* [x] Image uploads
* [x] Note posting
* [ ] Tags
* [ ] Full text search
* [ ] Configurable privacy settings
* [ ] Sensibly designed views

Geneac 0.2 Roadmap:

* [ ] Facebook login
* [ ] Data import/export to own format via rake task
* [ ] Search and identification of people mentioned in notes

Contributing
---

If you have an idea for a feature or suggestion, feel free submit a pull request or send me an email! [mitchell.rysavy@gmail.com](mailto:mitchell.rysavy@gmail.com)
