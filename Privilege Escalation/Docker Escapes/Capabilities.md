# Capabilities

### 1) Read files from host filesystem

    debugfs -R 'cat /root/root.txt' /dev/loopNUMp1

OR

    dd if=/dev/loopNUMp1 bs=1M count=200 | strings | grep FLAG

