# Spear Phishing

### The most common way into an organization’s network is through spear phishing. Cobalt Strike's spear phishing tool allows you to send pixel perfect spear phishing messages using an arbitrary message as a template.

## Targets

### Before you send a phishing message, you should assemble a list of targets. Cobalt Strike expects targets in a text file. Each line of the file contains one target. The target may be an email address. You may also use an email address, a tab, and a name. If provided, a name helps Cobalt Strike customize each phish.

## Templates

### Next, you need a phishing template. The nice thing about templates is that you may reuse them between engagements. Cobalt Strike uses saved email messages as its templates. Cobalt Strike will strip attachments, deal with encoding issues, and rewrite each template for each phishing attack.

### If you’d like to create a custom template, compose a message and send it to yourself. Most email clients have a way to get the original message source. In Gmail, click the down arrow next to Reply and select Show original. Save this message to a file and then congratulate yourself— you’ve made your first Cobalt Strike phishing template.

### You may want to customize your template with Cobalt Strike’s tokens. Cobalt Strike replaces the following tokens in your templates:

### 1) %To%
