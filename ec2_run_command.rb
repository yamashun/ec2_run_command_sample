require 'aws-sdk'

Aws.config.update(
  access_key_id:     ENV['SSM_ACCESS_KEY_ID'],
  secret_access_key: ENV['SSM_SECRET_ACCESS_KEY'],
  region:            'ap-northeast-1'
)

Aws::SSM::Client.new.send_command(
  document_name: "AWS-RunShellScript",
  instance_ids: [ENV['EC2_INSTANCE_ID']],
  parameters: {
    commands: [
      "whoami > /tmp/whoami1.txt",
      "su - ubuntu && whoami > /tmp/whoami2.txt"
    ],
    executionTimeout:["3600"]
  },
  timeout_seconds: 600,
)
