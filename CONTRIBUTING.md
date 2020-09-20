# Contributing Guide

## Code of Conduct

We welcome pull requests from everyone. By participating in this project, you
agree to abide by the [code of conduct](CODE_OF_CONDUCT.md).

## Getting Started

Geneac is a genealogy CMS (Content Management System) built on [Ruby on Rails](https://rubyonrails.org).

As much as possible Geneac attemps to do things "The Rails Way." To that end, the best way to learn about
Ruby on Rails is the [official Rails documentation.](https://guides.rubyonrails.org/getting_started.html).

A few key libraries/gems that would also be helpful to learn about before contributing would be:

* [Devise](https://github.com/heartcombo/devise)
* [Administrate](https://github.com/thoughtbot/administrate)
* [Pundit](https://github.com/varvet/pundit)
* [Webpacker](https://github.com/rails/webpacker)
* [RSpec](https://rspec.info/)

Finally, since Heroku is the primary deployment target, I also recommend reading about [twelve-factor apps](https://12factor.net/).

### Opening a PR

1. Fork the repo,
2. Complete the setup for local development, outlined below,
3. Run the test suite with `rake`,
4. Make your changes,
5. Push your fork and open a pull request.

A good PR will solve the smallest problem it possibly can, have good test
coverage and (where necessary) have internationalisation support.

### Running the application locally

For local development, it is recommended you have:

* Ruby & Bundler (see `.ruby-version` for current supported version)
  * [rbenv](https://github.com/sstephenson/rbenv) is recommended.
* NodeJS + Yarn (see `.node-version` for current supported version)
  * [nodenv](https://github.com/nodenv/nodenv) is recommended.
* [foreman](https://github.com/ddollar/foreman)-compatible launcher for Procfile-based launch
* PostgreSQL
* Redis

If this is your first time running geneac, you need to configure the database:

```bash
rails db:create db:schema:load
```

For local development I also recommend generating simulated test data that you can browse. There is a rake task for doing this:

```bash
rails generate:testdata
```

Finally, you can start the server and worker processes with:

```bash
# Starts server and webpack-dev-server
foreman start -f Procfile.dev
```

## Repository Structure

The application's source code lives in the `app` and `lib` subdirectories.

The application test code (the 'spec') lives in the `spec` subdirectory.

## Security

For security inquiries or vulnerability reports, please email
<mitchell.rysavy@gmail.com>.
