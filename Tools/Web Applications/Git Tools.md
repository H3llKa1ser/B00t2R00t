# GIT TOOLS

### Git tools are used when we locate an exposed .git folder that contains an entire repository with possibly sensitive information.

## STEPS:

#### 1) gitdumper.sh http://WHATEVER/.git/ repo

## Alternate method: wget

 - wget -r http://DOMAIN.COM/.git

#### 2) Go to the directory where the .git folder is located

#### 3) /path/to/extractor.sh . App

#### 4) git log (Gets all commits in the repository)

#### 5) git show COMMIT_NUMBER (See the specific commit in detail)
