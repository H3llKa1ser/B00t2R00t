Test-NetConnection -Port 445 192.168.10.10 (check 445 is on) 1..1024 | % {echo ((New-Object Net.Sockets.TcpClient).Connect("192.168.50.151", $)) "TCP port $ is open"} 2>$null
