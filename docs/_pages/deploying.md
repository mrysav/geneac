---
layout: default
title: Deploying to Docker
nav_order: 3
---

{: .warn }
If you just want to run Geneac locally for testing, you should be looking at [Developer Quickstart](development/quickstart) instead!

{: .info }
Geneac used to run easily on Heroku. It should _still_ run easily on Heroku, but I
no longer run it there and can't guarantee that it will be easy.

## Cloud Infrastructure

Geneac requires an S3 (or S3-compatible) bucket, and optionally, it can use SES for sending email.

`script/geneac-aws.yml` is a CloudFormation template that you can use to create the required IAM User, Bucket,
and policy associated with each to get going. **This will not reveal the credentials to you,** so to get those you
will need to go into the AWS console and create new credentials for the user manually, and copy them down.

## Docker

Docker's not just for experts!

Geneac is bundled up into a nice ~~little~~ container hosted on the GitHub Container Registry,
which you can pull yourself.

```bash
$ docker pull ghcr.io/mrysav/geneac:latest
```

You can run the container as-is, but there are some environment variables you'll want to configure first.

## Environment Variables

AWS configuration values:

1. `AWS_ACCESS_KEY_ID`
1. `AWS_REGION`
1. `AWS_SECRET_ACCESS_KEY`
1. `S3_BUCKET_NAME`

Infrastructure:

1. `DATABASE_URL` - in the form of `postgres://[username]:[password]@[hostname]:[port]/[database_name]`
1. `REDIS_URL` - in the form of `redis://[hostname]:[port]`

Values that configure email sending:

1. `MAILER_HOSTNAME` - This is the hostname that will be used in ActionMailer to generate links back your instance.
1. `MAILER_SENDER` - This is the full email address that your AWS user is able to send mail via SES from, such as `no-reply@geneac.net`.

App configuration values:

1. `RACK_ENV`, `RAILS_ENV` - Both of these should probably be `production`.
1. `RAILS_LOG_TO_STDOUT` - This should probably be set to `enabled` so you don't miss any logs.
1. `RAILS_SERVE_STATIC_FILES` - This should be `enabled`.
1. `SECRET_KEY_BASE` - You can generate this with `rake secret` if it is not already generated for you.

## Example

I use Docker Compose to manage my containers, so here is my setup:

```yaml
version: '3'

volumes:
  pg_data:

services:
  postgres:
    # The version of postgres used should match the version of the client in
    # the Geneac container for the backup rake task to work.
    # As of writing this is version 13.
    image: postgres:13
    environment:
      # this can be anything you want. Make sure the file permissions are
      # restrictive enough that the file can't be seen by anyone else though!
      POSTGRES_PASSWORD: my-postgres-password-here
    ports:
      - '5432:5432'
    volumes:
      - pg_data:/var/lib/postgresql/data

  redis:
    image: redis:latest
    ports:
      - ':6379'

  prod-web:
    image: ghcr.io/mrysav/geneac:latest
    command: ['sh', '/usr/bin/rails_web.sh']
    ports:
      - '3001:3001'
    depends_on:
      - postgres
      - redis
    # This file contains all my environment variables, as above
    env_file: docker.prod.env

  prod-worker:
    image: ghcr.io/mrysav/geneac:latest
    command: ['sh', '/usr/bin/rails_worker.sh']
    depends_on:
      - postgres
      - redis
    env_file: docker.prod.env
```
