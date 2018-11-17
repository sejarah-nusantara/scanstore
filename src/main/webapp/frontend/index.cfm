<cfif isDefined("url.ping")>
	<cfoutput>{ success:#application.beanFactory.getBean('userSessionController').userIsLoggedIn()# }</cfoutput>
<cfelseif application.forceConfig>
	<cfoutput>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<!-- ========================================================================================== >
		Copyright SilkUnion 2013
	< =========================================================================================== -->
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" type="text/css" media="screen" href="resources/css/support.css">
		<link rel="icon" type="image/png" href="resources/images/application.png" />
		<link rel="shortcut icon" type="image/png" href="resources/images/application.png" />
		<title>DASA - Scanstore - Wizard</title>
	</head>
	<body>
		<h1>Scanstore - Start Wizard</h1>
		<p>The scanstore cannot be started with the current configured settings, please change them accordingly.</p>
		<p><b>Note:</b> All fields behind the solid bullets are mandatory.</p>
		<hr />
	<cfinclude template="../properties/editor.cfm">
	<cfif NOT application.forceConfig>
		<cflocation url="./" addtoken="false" />
	</cfif>
		<hr />
	</body>
	</html>
	</cfoutput>
<cfelse>
	<cfoutput>
	<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
	<!-- ========================================================================================== >
		Copyright SilkUnion 2013
	< =========================================================================================== -->
	<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
	<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=1280" />
		<title>DASA - Scanstore</title>
		<link rel="stylesheet" type="text/css" href="resources/css/ext-all-gray.css" />
		<link rel="stylesheet" type="text/css" href="resources/plugins/clearbutton.css">
		<link rel="stylesheet" type="text/css" href="resources/css/scanstore.css">
		<link rel="icon" type="image/png" href="resources/images/application.png" />
		<link rel="shortcut icon" type="image/png" href="resources/images/application.png" />
		<script type="text/javascript" src="resources/scripts/sha256.js"></script>
	<cfif application.settings.DEBUG>
		<script type="text/javascript" src="ext-all-debug.js"></script>
	<cfelse>
		<script type="text/javascript" src="ext-all.js"></script>
	</cfif>
		<script type="text/javascript" src="resources/plugins/html5chunkupload.js"></script>
		<script type="text/javascript" src="resources/plugins/clearbutton.js"></script>
		<script type="text/javascript" src="resources/plugins/passwordstrength.js"></script>
		<script type="text/javascript" src="scanstore.js"></script>
		<script type="text/javascript">
			<cfif structKeyExists(application.settings,"VERSION")>Scanstore.version = '#application.settings.VERSION#';</cfif>
			<cfif application.settings.DEBUG>Scanstore.version += ' - DEBUG';</cfif>
			<cfif structKeyExists(application.settings,"PAGESIZE")>Scanstore.pagesize = '#application.settings.PAGESIZE#';</cfif>
			<cfif structKeyExists(application.settings,"REPOSITORY_URL")>Scanstore.repositoryurl = '#application.settings.REPOSITORY_URL#';</cfif>
		</script>
	</head>
	<body>
		<div id="loader">Loading resources, please wait...</div>
		<script type="text/javascript">
			showLoader();
		</script>
	</body>
	</html>
	</cfoutput>
</cfif>