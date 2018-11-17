<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- ========================================================================================== >
	Copyright SilkUnion 2013
< =========================================================================================== -->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" media="screen" href="frontend/resources/css/support.css">
	<link rel="icon" type="image/png" href="frontend/resources/images/application.png" />
	<link rel="shortcut icon" type="image/png" href="frontend/resources/images/application.png" />
	<title>DASA - Scanstore - Portal</title>
</head>
<body>
	<h1>Scanstore - Portal</h1>
	<hr />
	<h3>application.properties <a href="./properties/">edit</a></h3>
	<ul>
	<cfloop collection="#application.settings#" item="setting">
		<li><i>#setting#</i> : <b>#application.settings[setting]#</b></li>
	</cfloop>
	</ul>
	<p>
		This file should be altered to accomodate the current environment.
	</p>
	<hr />
	<ul>
		<li><h2><a href="./frontend/">Application</a></h2></li>
		<li><h2><a href="./frontend/manual/">Manual</a></h2></li>
		<li><a href="./monitoring">Monitoring</a></li>
		<li><a href="./?reinit">Reset Application</a></li>
		<li><a href="./sql/">Reset Database</a></li>
		<li><a href="./lucee/admin/server.cfm">Lucee Administrator</a></li>
		<li><a href="./documentation/">Technical Documentation</a></li>
	</ul>
</body>
</html>
</cfoutput>
