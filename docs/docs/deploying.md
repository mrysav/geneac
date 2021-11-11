# Deploying Geneac in Production

**If you just want to run Geneac locally for testing, you should be looking at [Developer Quickstart](Development/quickstart.md) instead!**

## Heroku + AWS

Let's be clear: I want to pay as little as possible to host my own Geneac while also offloading
as much of the burden of managing infrastructure as I can. This has led me to deploy Geneac
to Heroku for the main app servers and AWS for the other stuff. This allows me to run my
personal Geneac instances for at most, a few dollars per month.

### Step 1: Provision Infrastructure

In order to deploy to AWS, you need to have a few things:

1. An AWS account (duh)
1. A domain registered with Route 53 and verified to send email in SES (optional, but recommended)

The easiest way to get going is to deploy the CloudFormation template located in `script/geneac-aws.yml`.

This will create all the resources you need, in addition to an IAM user. The credentials for that user
will be stored in a secret deployed to AWS Secrets Manager, which you can view on the AWS Console.

### Step 2: Deploy to Heroku

If you already have a [Heroku](https://heroku.com) account you can click this to get up and running:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/mrysav/geneac)

However, the `app.json` might not be fully up to date with the environment variables you need.

Here is a list of variables that are currently required to deploy Geneac:

AWS configuration values:

1. `AWS_ACCESS_KEY_ID`
1. `AWS_REGION`
1. `AWS_SECRET_ACCESS_KEY`
1. `S3_BUCKET_NAME` - This is just the bucket name, not the full URL to the bucket. You can get this after deploying the resources in Step \#1.

Values that configure email sending:

1. `MAILER_HOSTNAME` - This is the hostname that will be used in ActionMailer to generate links back your instance. If you're deploying to Heroku without a custom domain, that would look like `my-geneac.herokuapp.com`
1. `MAILER_SENDER` - This is the full email address that your AWS user is able to send mail via SES from, such as `no-reply@geneac.net`.

App configuration values:

1. `RACK_ENV`, `RAILS_ENV` - Both of these should probably be `production`.
1. `RAILS_LOG_TO_STDOUT` - This should probably be set to `enabled` if you are on Heroku so you can view all of the logs.
1. `RAILS_SERVE_STATIC_FILES` - This should be `enabled`.
1. `SECRET_KEY_BASE` - You can generate this with `rake secret` if it is not already generated for you.

## Docker (unsupported)

Previously, I had deployed things with Docker and set up containers with things like MinIO to replace S3. You can find those efforts in `docker/`, but I don't support anything there. I'd be happy to review a PR to improve it, though.
