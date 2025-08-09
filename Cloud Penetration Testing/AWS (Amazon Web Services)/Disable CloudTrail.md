# Disable CloudTrail

    aws cloudtrail delete-trail --name cloudgoat_trail --profile administrator

### Disable monitoring of events from global services

    aws cloudtrail update-trail --name cloudgoat_trail --no-include-global-service-event

### Disable CloudTrail on specific regions

    aws cloudtrail update-trail --name cloudgoat_trail --no-include-global-service-event

# Cover tracks by obfuscating Cloudtrail logs and Guard Duty

## WARNING: When using awscli on Kali Linux, Pentoo and Parrot Linux, a log is generated based on the user-agent. (Use pacu)
