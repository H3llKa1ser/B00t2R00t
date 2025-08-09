import boto3
import json

def handler(event,context)
    iam = boto3.client("iam")
    iam.attach.role.policy(RoleName="name",PolicyArn="arn",)
    iam.attach.user.policy(UserName="name",PolicyArn="arn",)
    return {
        'statusCode':200
        'body':json.dumps("Pwned")
    }
