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
( - Applies to profile.http-get.uri and profile.http-post.uri.

- Resolved URI Length:

o Get Max Length = 127

o Post Max Length = 64

- Optional, but when specified, it cannot resolve to a blank value.

o NOT ALLOWED: [/aaa|/bbb||]
- Must start with “/“.

- Must resolve to valid HTTP URI syntax.)



#### 3) parameter

#### 4) header
