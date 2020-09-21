# frozen_string_literal: true

if Rails.application.config.active_storage.service == :amazon
  aws_region_present = ENV['AWS_REGION'].present?
  s3_endpoint_present = ENV['S3_ENDPOINT'].present?

  raise 'Cannot specify both AWS_REGION and S3_ENDPOINT!' if aws_region_present && s3_endpoint_present

  raise 'Must specify either AWS_REGION or S3_ENDPOINT!' unless aws_region_present || s3_endpoint_present
end
