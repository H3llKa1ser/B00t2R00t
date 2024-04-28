# AWS CloudTrail commands

## Tool: awscli

 - aws cloudtrail list-trails (List trails)

 - aws cloudtrail delete-trail --name EXAMPLE_TRAIL --profile NAME (Disabling CloudTrail)

 - aws cloudtrail update-trail --name EXAMPLE_TRAIL --no-include-global-service-event (Disable monitoring of events from global events)

 - aws cloudtrail update-trail --name example_trail --no-include-global-service-event --region REGION (Disable CloudTrail on specific regions)
