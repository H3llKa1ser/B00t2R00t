# Clone Site

### Before sending an exploit to a target, it helps to dress it up. Cobalt Strike’s website clone tool can help with this. The website clone tool makes a local copy of a website with some code added to fix links and images so they work as expected.

### To clone a website, go to Site Management -> Clone Site.

### It’s possible to embed an attack into a cloned site. Write the URL of your attack in the Embed field and Cobalt Strike will add it to the cloned site with an IFRAME. Click the ... button to select one of the running client-side exploits.

### Cloned websites can also capture keystrokes. Check the Log keystrokes on cloned site box. This will insert a JavaScript key logger into the cloned site.

### Check Enable SSL to serve this content over SSL. This option is available when you specify a valid SSL certificate in your Malleable C2 profile. Make sure the Host field matches the CN field of your SSL certificate. This will avoid a situation where this feature fails because of a mismatch between these fields.

