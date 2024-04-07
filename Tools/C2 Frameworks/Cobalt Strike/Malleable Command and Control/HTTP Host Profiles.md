# HTTP Host Profiles

### Host Profiles is used to define HTTP characteristics (uri, headers, and parameters) that will be used for the HTTP/HTTPS communication traffic for a specific host name. Host Profiles is optional. Host Profiles can be defined for multiple host names.

## About Dynamic Data

### Some fields in http-host-profiles group support a dynamic value syntax. Beacons will randomly select one of the optional values in the specified dynamic syntax. Dynamic syntax is wrapped by square brackets with values separated by "|".

## Features

#### 1) Dynamic syntax can be an entire value.

#### 2) Dynamic syntax can be embedded in static text.

#### 3) Dynamic syntax can have one or more blank options as a selected value.

#### 4) Dynamic syntax can have multiple dynamic items.

### The settings are:

#### 1) host-name (  The host-name field is a fixed string that links the Host Profile to matching HTTP Hosts field on the HTTP/HTTPS listener definitions. The field is required and case sensitive. It does NOT support embedded dynamic syntax (“[a|b|c]”).

#### 2) uri 

 Applies to profile.http-get.uri and profile.http-post.uri.

- Resolved URI Length:

o Get Max Length = 127

o Post Max Length = 64

- Optional, but when specified, it cannot resolve to a blank value.

o NOT ALLOWED: [/aaa|/bbb||]
- Must start with “/“.

- Must resolve to valid HTTP URI syntax.

#### 3) parameter

Applies to profile.http-get.uri and profile.http-post.uri.

- Up to 10 parameters in a single Host Profile get/post definition.

- Supports embedded dynamic data syntax in the name and value.

- If/when the name resolves to a blank value, the parameter will be
dropped.

- Blank parameter values are supported.


#### 4) header

Applies to profile.http-get.uri and profile.http-post.uri.

- Up to 10 headers in a single Host Profile get/post definition.

- Supports embedded dynamic data syntax in the name and value.

- If/when the name resolves to a blank value, the header will be
dropped.

- If/when the value resolves to a blank value, the header will be
dropped.

## Restrictions

- Up to 8 host profiles used per listener/beacon

- 1024 byte limit on space for all profiles used in a beacon (use small simple definitions if possible)

- Maximum tokens in a dynamic field: 32

## Host Profile Linting

- The linting process DOES NOT include Host Profile settings in the default/variant profile
sample data it generates. The process does not know which hosts will be assigned to
which listeners and which listeners will be assigned to the default or various profile
variants to generate the examples.

- The linting process includes several checks for the defined host profiles.

- The Host Profile get/post URI’s must resolve to unique URI’s to identify HTTP requests
appropriately. The linting feature will test for possible URI collisions. Linting does not
know which profile variants might use specific host profiles, so the linting process
checks for duplicates in a larger scope (all variants) than may be actually required.

-  Linting requires the process resolve every potential URI, and header/parameter name.
Complex dynamic data can result in very large sets of results, which will impact
performance and memory.
