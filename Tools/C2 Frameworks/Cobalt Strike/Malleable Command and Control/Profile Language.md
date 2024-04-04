# Profile Language

### The best way to create a profile is to modify an existing one. Several example profiles are available on Github: https://github.com/cobalt-strike/Malleable-C2-Profiles

### When you open a profile, here is what you will see:

# this is a comment
set global_option "value";
protocol-transaction {
set local_option "value";
client {
# customize client indicators
  }
server {
# customize server indicators
  }
}

### Comments begin with a #and go until the end of the line. The set statement is a way to assign a value to an option. Profiles use { curly braces } to group statements and information together. Statements always end with a semi-colon.

### To help all of this make sense, here’s a partial profile:

http-get {
set uri "/foobar";
