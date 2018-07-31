require 'aws-sdk-s3'

Aws.config.update({
  bucket: 'my-recipe-box',
  region: 'us-west-2',
})
