<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- ========================================================================================== >
	Copyright SilkUnion 2013
< =========================================================================================== -->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" media="screen" href="../frontend/resources/css/support.css">
	<link rel="icon" type="image/png" href="../frontend/resources/images/application.png" />
	<link rel="shortcut icon" type="image/png" href="../frontend/resources/images/application.png" />
	<title>DASA - Scanstore - Reset Database</title>
</head>
<body>
	<h1>Scanstore - Reset Database</h1>
	<hr />
	<cfif structCount(form) gt 0>
		<cffile action="read" file="database.sql" variable="sql" />
		<cfquery datasource="scanstore" name="sqlscript">
			<cfoutput>#preserveSingleQuotes(replace(sql,"%NEWPASSWORD%",hash(hash(form.newpass,"SHA-256")&":admin","SHA-256"),"ALL"))#</cfoutput>
		</cfquery>
		<h3>Reset Database <i>successfully</i></h3>
	<cfelse>
		<h3>Reset Database</h3>
	</cfif>
	<p><b>Warning:</b> resetting the database will remove all existing users, (re)create all tables, and create a new "admin" user.</p>
	<form method="post">
	<ul>
		<li><i>new "admin" password</i> :
		<input type="password" name="newpass"></li>
	</ul>
	<input type="submit">
	</form>
	<hr />
	<ul>
		<li><a href="../">Back</a></li>
	</ul>
</body>
</html>
</cfoutput>