# Lambda and API Gateway checklist

Serverless event driven platform

Runs code in response to events and automatically manages computing resources required by that code

Can trigger from other AWS services or call directly from the API Gateway

A lambda function is a piece of code that is executed whenever is triggered by an event from an event source

API Gateway is an AWS service for creating, publishing, maintaining, monitoring and securing REST, HTTP and WebSocket API

API Gateway can be used to trigger lambda functions in a synchronous (api gateway), asynchronous (event) or stream (Poll Based) way.

If we found a lambda function that access an S3 (Example) its possible to change its code and gain access to the files.

If API Gateway is used, we can enumerate the API to see how its possible to invoke the lambda function (Craft the URL).
