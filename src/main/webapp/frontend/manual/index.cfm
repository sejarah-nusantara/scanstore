
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<!-- ========================================================================================== >
	Copyright SilkUnion 2012
< =========================================================================================== -->
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" type="text/css" media="screen" href="../resources/css/support.css">
	<link rel="stylesheet" href="../imageviewer/resources/jquery/jquery-ui-1.10.3.custom.min.css">
	<link rel="icon" type="image/png" href="../resources/images/help.png" />
	<link rel="shortcut icon" type="image/png" href="../resources/images/help.png" />
	<title>DASA - Scanstore - Manual</title>
</head>
<body>
	<h1><a href="##h" title="Back to top" name="h">Scanstore - Manual</a></h1><hr />
	<ul class="float">
	<li><a href="##g0"><img src="../resources/images/application.png" /> Global functionality</a>
		<ul>
			<li><a href="##g1">Action icons</a></li>
			<li><a href="##g2">Context menus</a></li>
			<li><a href="##g3">Column settings</a></li>
			<li><a href="##g4">Column sorting</a></li>
		</ul>
	</li>
	<li><a href="##a0"><img src="../resources/images/door_in.png" /> Authentication</a>
		<ul>
			<li><a href="##a1">Login</a></li>
			<li><a href="##a2">Logout</a></li>
		</ul>
	</li>
	<li><a href="##im0"><img src="../resources/images/package.png" /> Import management</a>
		<ul>
			<li><a href="##im1">Upload scan collection</a></li>
			<li><a href="##im2">Upload & import scan collection</a></li>
			<li><a href="##im3">Import scan collection</a></li>
			<li><a href="##im4">Remove import</a></li>
			<li><a href="##im5">View log</a></li>
			<li><a href="##im6">Local upload</a></li>
		</ul>
	</li>
	<li><a href="##sm0"><img src="../resources/images/photos.png" /> Scan management</a>
		<ul>
			<li><a href="##sm1">Edit scan</a></li>
			<li><a href="##sm2">Change scan sequence</a></li>
			<li><a href="##sm3">Remove scan</a></li>
		</ul>
	</li>
	<li><a href="##sim0"><img src="../resources/images/pictures.png" /> Scan image management</a>
		<ul>
			<li><a href="##sim1">Add scan image</a></li>
			<li><a href="##sim2">Replace scan image</a></li>
			<li><a href="##sim3">Remove scan image</a></li>
			<li><a href="##sim5">Download scan image</a></li>
			<li><a href="##sim6">Set publication scan image</a></li>
		</ul>
	</li>
	<li><a href="##fi0"><img src="../resources/images/folder.png" /> Archive File management</a>
		<ul>
			<li><a href="##fi1">Publish archive file</a></li>
			<li><a href="##fi1">Remove scans from archive file</a></li>
		</ul>
	</li>
	<li><a href="##us0"><img src="../resources/images/group.png" /> User management</a>
		<ul>
			<li><a href="##us1">Add user</a></li>
			<li><a href="##us2">Edit user</a></li>
			<li><a href="##us3">Remove user</a></li>
		</ul>
	</li>
	<li><a href="##iv0"><img src="../resources/images/picture_editor.png" /> Image viewer</a>
		<ul>
			<li><a href="##iv1">Controls</a></li>
			<li><a href="##iv2">Filters</a></li>
		</ul>
	</li>
	</ul>
	<!--- GLOBAL FUNCTIONALITY --->
	<hr /><h2><a href="##h" title="Back to top" name="g0"><img src="../resources/images/application.png" /> Global functionality</a></h2>
	<p>
		The application manages 5 types of objects. All of them feature there own visual representation as presented below.
		These icons are used on tabs throughout the application for navigational purposes.
		<hr />
		<img src="../resources/images/photo.png" /> Represents a scan object, it's used on the scan edit tabs and scan metadata panel.
		<hr />
		<img src="../resources/images/photos.png" /> Represents scan management and it's used on the scan management tab.
		<hr />
		<img src="../resources/images/pictures.png" /> Represents a scan image object and it's used on scan images panel.
		<hr />
		<img src="../resources/images/package.png" /> Represents import management and it's used on the import management tab.
		<hr />
		<img src="../resources/images/folder.png" /> Represents archive file management and it's used on the archive file management tab.
		<hr />
		<img src="../resources/images/user.png" /> Represents an user object and it's used on the user edit tabs.
		<hr />
		<img src="../resources/images/group.png" /> Represents user management and it's used on the user management tab.
		<hr />
		<img src="../resources/images/picture_editor.png" /> Represents the image viewer and it's used on the image viewer tabs.
		<hr />
		<img src="../resources/images/page_white.png" /> Represents the log viewer and it's used on the log viewer window.
		<hr />
	</p>
	<p>
		Some overviews will feature a set of indaction icons for each record.
		This list will give explanatory information about the icons used throughout these overviews.
		<hr />
		<img src="../resources/images/accept.png" /> Represents a true or completed value
		<hr />
		<img src="../resources/images/unknown.png" /> Represents an unknown or empty value
		<hr />
		<img src="../resources/images/exclamation.png" /> Represents a state that needs your attention
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="g1">Action icons</a></h3>
	<p>
		Each overview and editable item will feature a set of action buttons. You be able to click on them to initiate it's action.
		This list will give explanatory information about the action icons on buttons used throughout the application.
		<hr />
		<img src="../resources/images/arrow_rotate_anticlockwise.png" /> Cancels a user or scan edit and closes it's edit panel if applicable.
		<hr />
		<img src="../resources/images/delete.png" /> Deletes a user or scan edit, closes it's edit panel or cancels an ungoing scan collection upload.
		<hr />
		<img src="../resources/images/disk.png" /> Saves a user or scan edit and closes it's edit panel.
		<hr />
		<img src="../resources/images/compress_go.png" /> Opens a popup to allow you to upload and add metadata to a scan collection archive to import it directly in the repository.
		<hr />
		<img src="../resources/images/compress.png" /> Opens a popup to allow you to upload scan collection archive.
		<hr />
		<img src="../resources/images/door_out.png" /> Will loggoff the currently loggedin user.
		<hr />
		<img src="../resources/images/door_in.png" /> Will validate and login supplied user.
		<hr />
		<img src="../resources/images/folder_back.png" /> Marks the file private.
		<hr />
		<img src="../resources/images/folder_go.png" /> Marks the file public.
		<hr />
		<img src="../resources/images/group_delete.png" /> Deletes all selected users.
		<hr />
		<img src="../resources/images/group_save.png" /> Saves all pending changes to users who were edited inline.
		<hr />
		<img src="../resources/images/user_add.png" /> Adds a new user and opens the edit user panel.
		<hr />
		<img src="../resources/images/user_delete.png" /> Deletes an user.
		<hr />
		<img src="../resources/images/user_edit.png" /> Opens the edit user panel.
		<hr />
		<img src="../resources/images/package_delete.png" /> Deletes an import folder from the upload folder on the server.
		<hr />
		<img src="../resources/images/package_go.png" /> Opens a popup to allow you to add metadata to a scan collection and import the images into the repository.
		<hr />
		<img src="../resources/images/page_white_magnify.png" /> Opens a popup showing the log file containing process information regarding the import to the repository.
		<hr />
		<img src="../resources/images/photo_delete.png" /> Deletes a scan.
		<hr />
		<img src="../resources/images/photo_edit.png" /> Opens the edit scan panel.
		<hr />
		<img src="../resources/images/photos_delete.png" /> Deletes all selected or associated scans.
		<hr />
		<img src="../resources/images/photos_save.png" /> Saves all pending changes to scans who were edited inline.
		<hr />
		<img src="../resources/images/magnifier.png" /> Applies all scan filters.
		<hr />
		<img src="../resources/images/bin_empty.png" /> Resets all scan filters.
		<hr />
		<img src="../resources/images/picture_add.png" /> Opens a popup to allow uploading of a new scan image.
		<hr />
		<img src="../resources/images/picture_delete.png" /> Deletes a scan image.
		<hr />
		<img src="../resources/images/picture_down.png" /> Downloads the originaly uploaded image.
		<hr />
		<img src="../resources/images/picture_edit.png" /> Opens a popup to allow uploading of a replacement scan image.
		<hr />
		<img src="../resources/images/picture_go.png" /> Marks a scan image used for publication. This image will be used on the website consulting the repository.
		<hr />
		<img src="../resources/images/picture_editor_panel.png" /> Open the image viewer in as an edit panel in the scan management.
		<hr />
		<img src="../resources/images/picture_editor_window.png" /> Open the image viewer in an external browser window.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="g2">Context menus</a></h3>
	<img src="images/context-menu.jpg" />
	<p>
		All overviews within the application have a context menu showing all functions exposed to the record which was clicked on.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="g3">Column settings</a></h3>
	<img src="images/column-settings.jpg" />
	<p>
		The scan and import overview both feature more columns then shown on initial loading. You will be able to enable them by opening the menu by clicking on the small arrow beside the text, the columns sub menu will show all available columns.<br />
		Some overview, like the scans, will feature a grouping function. This will allow you to group the data by the column on which you opened the menu on. This feature can be disabled by unchecking the "Show in groups" checkbox.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="g4">Column sorting</a></h3>
	<img src="images/column-sorting.jpg" />
	<p>
		Most columns will be able to be used for sorting, this can be done by clicking on the column itself or by opening the menu by clicking on the small arrow beside the text and selecting either descending or ascending from it.
	</p>
	<!--- AUTHENTICATION --->
	<hr /><h2><a href="##h" title="Back to top" name="a0"><img src="../resources/images/door_in.png" /> Authentication</a></h2>
	<p>
		The application requires for users to be autheticated. An administartor is able to add new users to use this applciation.
		See <a href="##us0">user management</a> for more information.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="a1">Login</a></h3>
	<img src="images/login.jpg" />
	<p>
		Basic login popup which will allow you to login into the scanstore.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="a2">Logout</a></h3>
	<img src="images/logout.jpg" />
	<p>
		You will be able to logout in the upper right corner of the application. If you close the browser you will loggedout automatically after 30 minutes.
	</p>
	<!--- IMPORT MANAGEMENT --->
	<hr /><h2><a href="##h" title="Back to top" name="im0"><img src="../resources/images/package.png" /> Import management</a></h2>
	<p>
		The scanstore features 3 ways to get scans into the repository, it will allow you to upload a zip archive with images and import it either directly (Upload & import) or in a 2 phase (Upload) process into the repository.<br />
		It even allows you to place the archives directly into the upload folder (in a instution based subfolder, see local upload) of the scanstore to alleviate on bandwith and precious time, all scan collection placed in this folder will automatically be picked up by the scanstore so it can be imported (Import) into the repository in the background.
	</p>
	<p>
		In the import management overview you will be able to check all pending, completed and failed import by checking there log file.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="im1">Upload scan collection</a></h3>
	<img src="images/upload-archive.jpg" />
	<p>
		In this popup you will be able to select a archive which will be placed on the repository upload folder. It will be ready to be imported within the import management overview.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="im2">Upload & import scan collection</a></h3>
	<img src="images/upload-import-archive.jpg" />
	<p>
		In this popup you will be able to select a archive which will be imported into the repository immediately after it's being uploaded. This also means you will be required to input the mandatory scan metadata.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="im3">Import scan collection</a></h3>
	<img src="images/import-archive.jpg" />
	<p>
		In this popup you will be able to select import an uploaded archive which will be imported into the repository. You'll have to fill in all mandatory field to be able to initiate the import.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="im4">Remove import</a></h3>
	<p>
		You will be asked for confirmation of the deletion of the import folder. See <a href="##g1">action icons</a> to see which button will trigger this action.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="im5">View log</a></h3>
	<img src="images/archive-log.jpg" />
	<p>
		Int his popup all log data will be saved regarding the import into the repository, if an error occured, all detailed infromation about it will ben available in this log file.</p>
	<hr /><h3><a href="##h" title="Back to top" name="im6">Local upload</a></h3>
	<img src="images/local-upload.jpg" />
	<p>
		This is an example how you will be able to place archives directly into the scanstore's upload folder. This folder is located in the {scanstore application path}/upload, this location depends on the configuration of the servlet runtime.<br />
		Please contact your technical system engineer for more details.
	</p>
	<!--- SCAN MANAGEMENT --->
	<hr /><h2><a href="##h" title="Back to top" name="sm0"><img src="../resources/images/photos.png" /> Scan management</a></h2>
	<p>
		The most essential part of the scanstore is the scan management, it will allow you to edit concerning meta data and images to be used in publication on the website.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="sm1">Edit scan</a></h3>
	<img src="images/edit-scan.jpg" />
	<p>
		In this panel you will be able to edit all metadata concerning a scan. On the left side you'll see the scan images (see below) and on the right side there will be 4 tabs with grouped data concerning the images included with this scan.
		You'll be able to open as many scans simultaneously as you want. You can navugate between theme in with the tabs next to the overview.<br />
		This panel also features a way to help you concentrate on 1 task at hand.<br /.>
		You'll be able to either fully open the "Scan metadata" editor (like in the screenshot) or the "Scan images" editor with use of the small arrow icons in the headers.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="sm2">Change scan sequence</a></h3>
	<img src="images/move-scan.jpg" />
	<p>
		In the grid panel you will be able to drag and drop scan images to a new position (effectively changing the sequence).<br />
		All changed rows will indicate a change which isn't saved yet on te side of the changed column.
		You'll have to save the canges you made by clicking on the save button in the left upper corner.<br />
		Side note: Besides changing the sequence by draaging a row you can also change it by double clicking on the value in the row itself (This also applies to other values, giving you the ablility changing values of the scan without opening the scan itself).
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="sm3">Remove scan</a></h3>
	<p>
		You will be asked for confirmation of the deletion of the scan. See <a href="##g1">action icons</a> to see which button will trigger this action.
	</p>
	<!--- SCAN IMAGE MANAGEMENT --->
	<hr /><h2><a href="##h" title="Back to top" name="sim0"><img src="../resources/images/pictures.png" /> Scan image management</a></h2>
	<p>
		In this panel you will be able to edit all images attached to the scan. You'll be able to add, replace and remove them. Only 1 image will be used in publication.
		Setting one for publication will automatically disable the previous one.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="sim1">Add scan image</a></h3>
	<img src="images/edit-scan-image.jpg" />
	<p>
		In this popup you will be able to select a new image to be included in this scan.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="sim2">Replace scan image</a></h3>
	<img src="images/edit-scan-image.jpg" />
	<p>
		In this popup you will be able to select a replacement image.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="sim3">Remove scan image</a></h3>
	<p>
		You will be asked for confirmation of the deletion of the scan image. See <a href="##g1">action icons</a> to see which button will trigger this action.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="sim5">Download scan image</a></h3>
	<p>
		Will download of the original image. See <a href="##g1">action icons</a> to see which button will trigger this action.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="sim6">Set publication scan image</a></h3>
	<p>
		Will set the image to be used for publication. See <a href="##g1">action icons</a> to see which button will trigger this action.
	</p>
	<!--- ARCHIVE FILE MANAGEMENT --->
	<hr /><h2><a href="##h" title="Back to top" name="fi0"><img src="../resources/images/folder.png" /> Archive File management</a></h2>
	<p>
		Archive file management will allow for setting the file public or not, adding files will be done by manual input while importing archives or by other systems connected to the repository.
		Making an archive file public will tell the repository to show all associated scans on the website. You will also be able to remove all associated scans in one action.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="fi1">Publish file</a></h3>
	<img src="images/publish-file.jpg" />
	<p>
		Will set the file to be publically available. See <a href="##g1">action icons</a> to see which button will trigger this action.
	</p>
	<!--- USER MANAGEMENT --->
	<hr /><h2><a href="##h" title="Back to top" name="us0"><img src="../resources/images/group.png" /> User management</a></h2>
	<p>
		The application features user management to allow access to this application. Only administrative users are allowed to manage users.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="us1">Add user</a></h3>
	<img src="images/user-edit.jpg" />
	<p>
		Adding a user will create a new record and will open the edit panel as if you were editing an existing user.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="us2">Edit user</a></h3>
	<img src="images/user-edit.jpg" />
	<p>
		In this panel you will be able to edit all metadata concerning an user. The password field has to be filled in the control field to ensure it's was typed correctly.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="us3">Remove user</a></h3>
	<p>
		You will be asked for confirmation of the deletion of the user. See <a href="##g1">action icons</a> to see which button will trigger this action.
	</p>
	<!--- IMAGE VIEWER --->
	<hr /><h2><a href="##h" title="Back to top" name="iv0"><img src="../resources/images/picture_editor.png" /> Image viewer</a></h2>
	<img src="images/image-viewer.jpg" />
	<p>
		The image viewer is an external plugin developed for both the scanstore and the website to be able to view the scan images in high resolution, interact them with intuitive mouse controls like mouse wheel zooming and dragging.
		It also features a basic set of image manipulation options to enhance the scan images for better viewing as the user sees fit.
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="iv1">Controls</a></h3>
	<img src="images/image-viewer-external.jpg" />
	<p>
		The image viewer features a set of action buttons. You be able to click on them to initiate it's action.
		This list will give explanatory information about the action icons on buttons used throughout the viewer.
		<hr />
		<span class="ui-icon ui-icon-arrow-4-diag"></span> Zooms to fit
		<hr />
		<span class="ui-icon ui-icon-search"></span> Zooms to full size
		<hr />
		<span class="ui-icon ui-icon-zoomin"></span> Zooms in
		<hr />
		<span class="ui-icon ui-icon-zoomout"></span> Zooms out
		<hr />
		<span class="ui-icon ui-icon-arrowreturnthick-1-w"></span> Rotates scan to the left
		<hr />
		<span class="ui-icon ui-icon-arrowreturnthick-1-e"></span> Rotates scan to the right
		<hr />
		Changes resolution scan <span class="ui-icon ui-icon-radio-off"></span> &plusmn; 2MP | <span class="ui-icon ui-icon-radio-on"></span> &plusmn; 8MP | <span class="ui-icon ui-icon-bullet"></span> &plusmn; 15MP
		<hr />
		<span class="ui-icon ui-icon-locked"></span> Locks / unlocks automatic filtering
		<hr />
		<span class="ui-icon ui-icon-play"></span> Applies filters
		<hr />
		<span class="ui-icon ui-icon-seek-first"></span> Resets filters and restore scan
		<hr />
		<span class="ui-icon ui-icon-image"></span> Opens / closes filter panel
	</p>
	<hr /><h3><a href="##h" title="Back to top" name="iv2">Filters</a></h3>
	<img src="images/image-viewer-filters.jpg" />
	<p>
		After opening the filter panel all filters will be applied instantly, the user is able to apply multiple filters at once by unlocking the sliders with the lock / unlock button.
		All filters will be able to be changed before they get applied by use of the apply button. This also gives the possibility to apply the same configuration more than once.
	</p>
</body>
</html>
</cfoutput>