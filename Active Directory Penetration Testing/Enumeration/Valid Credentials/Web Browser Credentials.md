# Web Browser Credentials

## Mozilla Firefox

#### Profile Locations

Linux

    /home/<Username>/.mozilla/firefox/xxxx.default

MacOS

    /Users/<Username>/Library/Application\ Support/Firefox/Profiles/xxxx.default'

Windows

    C:\Users\<Username>\AppData\Roaming\Mozilla\Firefox\Profiles\xxxx.default

### 1) Firefox_decrypt

Github: https://github.com/unode/firefox_decrypt

    python3 firefox_decrypt.py <ProfileFolder>

### 2) LaZagne (Works for Chrome as well)

    laZagne.exe browsers browsers

## Google Chrome

#### Profile Locations

Linux

    /home/<Username>/.config/google-chrome/default

MacOS

    Users/<Username>/Library/Application Support/Google/Chrome/Default

Windows

    C:\Users\<Username>\AppData\Local\Google\Chrome\User Data\Default

### 1) Metaploit

    use post/windows/gather/enum_chrome
