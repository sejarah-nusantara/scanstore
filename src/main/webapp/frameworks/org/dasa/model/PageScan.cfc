<cfcomponent name="PageScan" hint=""
	extends="com.silkunion.model.BaseBusinessNoOrmObjectImpl" >
	<cfproperty name="number" type="numeric" />
	<cfproperty name="archive" type="string" />
	<cfproperty name="archive_id" type="string" />
	<cfproperty name="archiveID" type="string" />
	<cfproperty name="institution" type="string" />
	<cfproperty name="institutionID" type="string" />
	<cfproperty name="archiveFile" type="string" />
	<cfproperty name="archiveFileID" type="string" />
	<cfproperty name="sequenceNumber" type="numeric" />
	<cfproperty name="imageUrl" type="string" />
	<cfproperty name="folioNumber" type="string" />
	<cfproperty name="originalFolioNumber" type="string" />
	<cfproperty name="creator" type="string" />
	<cfproperty name="publisher" type="string" />
	<cfproperty name="rights" type="string" />
	<cfproperty name="date" type="date" />
	<cfproperty name="format" type="string" />
	<cfproperty name="title" type="string" />
	<cfproperty name="relation" type="string" />
	<cfproperty name="timeFrameFrom" type="date" />
	<cfproperty name="timeFrameTo" type="date" />
	<cfproperty name="subjectEN" type="string" />
	<cfproperty name="status" type="numeric"  hint="0 Deleted (i.e. only accessible when accessed directly) 1 	Newly added default 2 	Public"/>
	<cfproperty name="statusID" type="numeric"  hint=""/>
	<cfproperty name="transcriptionAuthor" type="string" />
	<cfproperty name="transcriptionDate" type="date" />
	<cfproperty name="transcription" type="string" />
	<cfproperty name="translationEN" type="string" />
	<cfproperty name="translationENAuthor" type="string" />
	<cfproperty name="translationENDate" type="date" />
	<cfproperty name="translationIDAuthor" type="string" />
	<cfproperty name="translationIDDate" type="date" />
	<cfproperty name="translationID" type="string" />
	<cfproperty name="language" type="string" />
	<cfproperty name="languageID" type="string" />
	<cfproperty name="type" type="string" />
	<cfproperty name="source" type="string" />

	<cfproperty name="URI" type="string" />
	<cfproperty name="contributor" type="string" />
	<cfproperty name="images" type="array" />
	<cfset this.static.THUMBNAIL_SIZE = 100 />
	<cfset this.static.LO_RES_SIZE = 500 />
	<cfset variables.DATE_TIME_PROPERTIES = null />
	<cfset variables.DATE_PROPERTIES = 	"transcriptionDate,translationENDate,translationIDDate,timeFrameFrom,timeFrameTo,date" />
	<cfset variables.READ_ONLY_PROPERTIES 	= 	"languageID,archiveID,number,institution,archiveFileID,institutionID,archive,archive_id,country,sequenceNumber,statusID,ImageUrl" />
	<cfset variables.instance.number = null />
	<cfset variables.instance.institution = null />
	<cfset variables.instance.archive = null />
	<cfset variables.instance.archiveFile = null />
	<cfset variables.instance.archive_id = null />
	<cfset variables.instance.institutionID = null />
	<cfset variables.instance.archiveFileID = null />
	<cfset variables.instance.sequenceNumber = null />
	<cfset variables.instance.hiresImage = null />
	<cfset variables.instance.imageUrl = null />
	<cfset variables.instance.folioNumber = null />
	<cfset variables.instance.originalFolioNumber = null />

F	<cfset variables.instance.creator = null />
	<cfset variables.instance.contributor = null />
	<cfset variables.instance.publisher = null />
	<cfset variables.instance.rights = null />
	<cfset variables.instance.uri = null />
	<cfset variables.instance.date = null />
	<cfset variables.instance.format = null />
	<cfset variables.instance.language = null />
	<cfset variables.instance.languageID = null />
	<cfset variables.instance.type = null />
	<cfset variables.instance.source = null />
	<cfset variables.instance.title = null />
	<cfset variables.instance.timeFrameFrom = null />
	<cfset variables.instance.timeFrameTo = null />
	<cfset variables.instance.subjectEN = null />
	<cfset variables.instance.transcription = null />
	<cfset variables.instance.translationEN = null />
	<cfset variables.instance.transcriptionAuthor = null />
	<cfset variables.instance.translationENAuthor = null />
	<cfset variables.instance.translationENDate = null />
	<cfset variables.instance.transcriptionDate = null />

	<cfset variables.instance.status = null />
	<cfset variables.instance.relation = null />

	<cfset variables.instance.translationIDAuthor = null />
	<cfset variables.instance.translationIDDate = null />
	<cfset variables.instance.translationID = null />
	<cfset variables.instance.images = [] />
	<!--- todo:tmp placeholder remove --->
	<cfset variables.instance.fileName = null />

	<cffunction name="getConvertedPropertyStruct"  returntype="struct" hint="get a date converted propety value struct">
		<cfscript>
			var local={};
			local.propertyData={};
			local.properties=getMetaData(this).properties;
			for( local.i=1 ; local.i <= arraylen(local.properties); local.i++ ){
				local.property = local.properties[local.i];
				local.getterFunction = this["get" & local.property.name];
				local.propertyValue = local.getterFunction();
				if(metadataIsEditable(local.property.name) && NOT isNull(local.propertyValue)){
					if(isDate(local.propertyValue) && listFindNocase(DATE_TIME_PROPERTIES,local.property.name)){
						local.propertyData[local.property.name] = convertDateTimeToIsoString(local.propertyValue);
					} else if(isSimpleValue(local.propertyValue)){
						local.propertyData[local.property.name] = local.propertyValue;
					}
				}
			}
			return local.propertyData;
		</cfscript>
	</cffunction>

	<cffunction name="getInstitutionID" returnType="string" access="public" output="false" hint="the IDifier of the institution that is responsible for the
original archive; valid value for example for ANRI: ID_JaAN;
input by user data entry; mandatory ">
		<cfreturn  getInstitution()/>
	</cffunction>

	<cffunction name="getInstitution" returnType="string" access="public" output="false" hint="the IDifier of the institution that is responsible for the
original archive; valid value for example for ANRI: ID_JaAN;
input by user data entry; mandatory ">
		<cfset var archive_id = getArchive_Id() />
		<cfif len(archive_id)>
			<cfreturn getArchivesGateway().getInstitutionByArchiveId(archive_id) />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

	<cffunction name="getArchive_ID" returnType="any" access="public" output="false" hint="the unique IDifier of the original archive; valid value for .">
		<cfreturn variables.instance.archive_id />
	</cffunction>

	<cffunction name="setArchive_ID" returnType="void" access="public" output="false" hint="the unique IDifier of the original archive; valid value for .">
		<cfargument name="_archive_id" type="string" required="true" hint="" />

		<cfset variables.instance.archive_id =arguments._archive_id/>
	</cffunction>

	<cffunction name="getArchiveID" returnType="any" access="public" output="false" hint="the unique IDifier of the original archive; valid value for .">
		<cfreturn variables.instance.archive_id />
	</cffunction>

	<cffunction name="setArchiveID" returnType="void" access="public" output="false" hint="the unique IDifier of the original archive; valid value for .">
		<cfargument name="_archive_id" type="string" required="true" hint="" />
		<cfset variables.instance.archive_id =arguments._archive_id/>
	</cffunction>

	<cffunction name="getArchive" returnType="string" access="public" output="false" hint="the unique IDifier of the original archive; valid value for .">
		<cfset var archive_id = getArchive_Id() />
		<cfif len(archive_id)>
			<cfreturn getArchivesGateway().getArchiveByArchiveId(archive_id) />
		<cfelse>
			<cfreturn "" />
		</cfif>
	</cffunction>

	<cffunction name="getArchiveFileID" returnType="string" access="public" output="false" hint="the unique IDifier of the file volume in the original archive
(also known as: inventory&nbsp; number); input by user data
entry; mandatory&nbsp;&nbsp; string
">
		<cfreturn getArchiveFile() />
	</cffunction>

	<cffunction name="setArchiveFileID" returnType="string" access="public" output="false" hint="the unique IDifier of the file volume in the original archive
(also known as: inventory&nbsp; number); input by user data
entry; mandatory&nbsp;&nbsp; string
">
		<cfargument name="archiveFileID" type="string" required="true" hint="" />
		<cfset variables.instance.archiveFile =arguments.archiveFileID/>
	</cffunction>

	<cffunction name="setStatusID" returnType="void" access="public" output="false" hint="">
			<cfargument name="statusId" type="string" required="true" hint="" />
		<cfset variables.instance.status = arguments.statusId/>
	</cffunction>

	<cffunction name="getStatusID" returnType="any" access="public" output="false" hint="">
		<cfreturn getStatus() />
	</cffunction>

	<cffunction name="getArchiveFile" returnType="string" access="public" output="false" hint="the unique IDifier of the file volume in the original archive
(also known as: inventory&nbsp; number); input by user data
entry; mandatory&nbsp;&nbsp; string
">
		<cfreturn variables.instance.archiveFile />
	</cffunction>

	<cffunction name="setArchiveFile" returnType="void" access="public" output="false" hint="the unique IDifier of the file volume in the original archive
(also known as: inventory&nbsp; number); input by user data
entry; mandatory&nbsp;&nbsp; string
">
		<cfargument name="_archiveFile" type="string" required="true" hint="" />
		<cfset variables.instance.archiveFile = arguments._archiveFile />
	</cffunction>

	<cffunction name="metadataIsEditable" returnType="boolean" access="public" output="false" hint="">
		<cfargument name="metadataName" type="string" required="true" hint="" />
		<cfreturn NOT listFindNocase(variables.READ_ONLY_PROPERTIES,arguments.metadataName)/>
	</cffunction>

	<cffunction name="getHiresImage" returnType="string" access="public" output="false" hint="Represents ...">
		<cfreturn variables.instance.hiresImage />
	</cffunction>

	<cffunction name="setHiresImage" returnType="void" access="public" output="false" hint="Represents ...">
		<cfargument name="_hiresImage" type="string" required="true" hint="" />
		<cfset variables.instance.hiresImage = arguments._hiresImage />
	</cffunction>

	<cffunction name="getImageUrl" returnType="string" access="public" output="false" hint="Represents ...">
		<cfreturn variables.instance.imageUrl />
	</cffunction>

	<cffunction name="setImageUrl" returnType="void" access="public" output="false" hint="Represents ...">
		<cfargument name="imageUrl" type="string" required="true" hint="" />
		<cfset variables.instance.imageUrl = arguments.imageUrl />
	</cffunction>


	<cffunction name="getRelation" returnType="string" access="public" output="false" hint="Represents ...">
		<cfreturn variables.instance.Relation />
	</cffunction>

	<cffunction name="setRelation" returnType="void" access="public" output="false" hint="Represents ...">
		<cfargument name="_Relation" type="string" required="true" hint="" />
		<cfset variables.instance.Relation = arguments._Relation />
	</cffunction>

	<cffunction name="getStatus" returnType="string" access="public" output="false" hint="enum:'unpublished', 'published', 'deleted'">
		<cfreturn variables.instance.status />
	</cffunction>

	<cffunction name="setStatus" returnType="void" access="public" output="false" hint="enum:'unpublished', 'published', 'deleted'">
		<cfargument name="_status" type="string" required="true" hint="" />
		<cfset variables.instance.status = arguments._status />
	</cffunction>

	<cffunction name="getSource" returnType="string" access="public" output="false" hint="Represents ...">
		<cfreturn variables.instance.source />
	</cffunction>

	<cffunction name="setSource" returnType="void" access="public" output="false" hint="Represents ...">
		<cfargument name="_source" type="string" required="true" hint="" />
		<cfset variables.instance.source = arguments._source />
	</cffunction>

	<cffunction name="getTranslationEN" returnType="string" access="public" output="false" hint="Represents ...">
		<cfreturn variables.instance.TranslationEN />
	</cffunction>

	<cffunction name="setTranslationEN" returnType="void" access="public" output="false" hint="Represents ...">
		<cfargument name="_TranslationEN" type="string" required="true" hint="" />
		<cfset variables.instance.TranslationEN = arguments._TranslationEN />
	</cffunction>

	<cffunction name="getTranscriptionDate" returnType="any" access="public" output="false" hint="The date of transcription; input by user data entr">
		<cfreturn variables.instance.transcriptionDate />
	</cffunction>

	<cffunction name="setTranscriptionDate" returnType="void" access="public" output="false" hint="The date of transcription; input by user data entr">
		<cfargument name="_transcriptionDate" type="any" required="true" hint="" />
		<cfset variables.instance.transcriptionDate = arguments._transcriptionDate />
	</cffunction>

	<cffunction name="getTranslationIDAuthor" returnType="string" access="public" output="false" hint="DC] An account of the resource. Can contain a translation
of the hardwritten text in Indonesian; input by user data entry

.">
		<cfreturn variables.instance.translationIDAuthor />
	</cffunction>

	<cffunction name="setTranslationIDAuthor" returnType="void" access="public" output="false" hint="DC] An account of the resource. Can contain a translation
of the hardwritten text in Indonesian; input by user data entry

.">
		<cfargument name="_translationIDAuthor" type="string" required="true" hint="" />
		<cfset variables.instance.translationIDAuthor = arguments._translationIDAuthor />
	</cffunction>

	<cffunction name="getTranslationIDDate" returnType="any" access="public" output="false" hint="The date of Indonesian translation; input by user data entry">
		<cfreturn variables.instance.translationIDDate />
	</cffunction>

	<cffunction name="setTranslationIDDate" returnType="void" access="public" output="false" hint="The date of Indonesian translation; input by user data entry">
		<cfargument name="_translationIDDate" type="any" required="true" hint="" />
		<cfset variables.instance.translationIDDate = arguments._translationIDDate />
	</cffunction>

	<cffunction name="getTranslationID" returnType="any" access="public" output="false" hint="DC] An account of the resource. Can contain a translation
of the hardwritten text in Indonesian; input by user data entry
">
		<cfreturn variables.instance.TranslationID />
	</cffunction>

	<cffunction name="setTranslationID" returnType="void" access="public" output="false" hint="DC] An account of the resource. Can contain a translation
of the hardwritten text in Indonesian; input by user data entry
">
		<cfargument name="_TranslationID" type="any" required="true" hint="" />
		<cfset variables.instance.TranslationID = arguments._TranslationID />
	</cffunction>

	<cffunction name="getNumber" returnType="any" access="public" output="false" hint="a unique idifier of the record; system generated;
mandatory
">
		<cfreturn variables.instance.number />
	</cffunction>

	<cffunction name="setNumber" returnType="void" access="public" output="false" hint="a unique idifier of the record; system generated;
mandatory
">
		<cfargument name="_number" type="numeric" required="true" hint="" />
		<cfset variables.instance.number = arguments._number />
	</cffunction>

	<cffunction name="getSequenceNumber" returnType="any" access="public" output="false" hint="This is a digitally constructed number that represents the
physical sequential order of the ned folio within the file;
system generated at first the same as Number; can be
modified by user input; mandatory number
">
		<cfreturn variables.instance.sequenceNumber />
	</cffunction>

	<cffunction name="setSequenceNumber" returnType="void" access="public" output="false" hint="This is a digitally constructed number that represents the
physical sequential order of the ned folio within the file;
system generated at first the same as Number; can be
modified by user input; mandatory number
">
		<cfargument name="_sequenceNumber" type="numeric" required="true" hint="" />
		<cfset variables.instance.sequenceNumber = arguments._sequenceNumber />
	</cffunction>



	<cffunction name="getUri" returnType="string" access="public" output="false" hint="DC] An unambiguous reference to the , being a
Document Object idifier (DOI) that can be found using a
webbrowser; input by user data entry
Needs further elaboration on the feasibility
string
.">
		<cfreturn variables.instance.Uri />
	</cffunction>

	<cffunction name="setUri" returnType="void" access="public" output="false" hint="DC] An unambiguous reference to the , being a
Document Object idifier (DOI) that can be found using a
webbrowser; input by user data entry
Needs further elaboration on the feasibility
string
.">
		<cfargument name="_Uri" type="string" required="true" hint="" />
		<cfset variables.instance.Uri = arguments._Uri />
	</cffunction>

	<cffunction name="getOriginalFolioNumber" returnType="any" access="public" output="false" hint="The original contemporary folio number or page number,
actually written on the physical page within the file; input by
data entry
number
">
		<cfreturn variables.instance.originalFolioNumber />
	</cffunction>

	<cffunction name="setOriginalFolioNumber" returnType="void" access="public" output="false" hint="The original contemporary folio number or page number,
actually written on the physical page within the file; input by
data entry
number
">
		<cfargument name="_originalFolioNumber" type="any" required="true" hint="" />
		<cfset variables.instance.originalFolioNumber = arguments._originalFolioNumber />
	</cffunction>

	<cffunction name="getFolioNumber" returnType="any" access="public" output="false" hint="The original contemporary folio number or page number,
actually written on the physical page within the file; input by
data entry
number
">
		<cfreturn variables.instance.folioNumber />
	</cffunction>

	<cffunction name="setFolioNumber" returnType="void" access="public" output="false" hint="The original contemporary folio number or page number,
actually written on the physical page within the file; input by
data entry
number
">
		<cfargument name="_folioNumber" type="any" required="true" hint="" />
		<cfset variables.instance.folioNumber = arguments._folioNumber />
	</cffunction>

	<cffunction name="getTitle" returnType="string" access="public" output="false" hint="[DC] A name given to the resource, in English. For example:
&lsquo;Folio of a daily journal&rsquo;; Input by user data entry; string
">
		<cfreturn variables.instance.title />
	</cffunction>

	<cffunction name="setTitle" returnType="void" access="public" output="false" hint="[DC] A name given to the resource, in English. For example:
&lsquo;Folio of a daily journal&rsquo;; Input by user data entry; string
">
		<cfargument name="_title" type="string" required="true" hint="" />
		<cfset variables.instance.title = arguments._title />
	</cffunction>

	<cffunction name="getType" returnType="string" access="public" output="false" hint="[DC] The nature or genre of the original resource, in English;
Input by user data entry; valid values are: &lsquo;handwritten folio&rsquo;,
&lsquo;page of a book publication&rsquo;; mandatory&nbsp; string
">
		<cfreturn variables.instance.type />
	</cffunction>

	<cffunction name="setType" returnType="void" access="public" output="false" hint="[DC] The nature or genre of the original resource, in English;
Input by user data entry; valid values are: &lsquo;handwritten folio&rsquo;,
&lsquo;page of a book publication&rsquo;; mandatory&nbsp; string
">
		<cfargument name="_type" type="string" required="true" hint="" />
		<cfset variables.instance.type = arguments._type />
	</cffunction>

	<cffunction name="getLanguage" returnType="string" access="public" output="false" hint="DC] An indication of the main language of the original
resource, in English; system generated as &lsquo;Dutch&rsquo; by
default; mandatory
string
">
		<cfreturn variables.instance.language />
	</cffunction>

	<cffunction name="setLanguage" returnType="void" access="public" output="false" hint="DC] An indication of the main language of the original
resource, in English; system generated as &lsquo;Dutch&rsquo; by
default; mandatory
string
">
		<cfargument name="_language" type="string" required="true" hint="" />
		<cfset variables.instance.language = arguments._language />
	</cffunction>

	<cffunction name="getLanguageID" returnType="string" access="public" output="false" hint="DC] An indication of the main language of the original
resource, in English; system generated as &lsquo;Dutch&rsquo; by
default; mandatory
string
">
		<cfreturn variables.instance.language />
	</cffunction>

	<cffunction name="setLanguageID" returnType="void" access="public" output="false" hint="DC] An indication of the main language of the original
resource, in English; system generated as &lsquo;Dutch&rsquo; by
default; mandatory
string
">
		<cfargument name="_languageID" type="string" required="true" hint="" />
		<cfset variables.instance.language = arguments._languageID />
	</cffunction>

	<cffunction name="getTimeFrameFrom" returnType="string" access="public" output="false" hint="[DC] The earliest date that applies to the content of the folio
thus setting a relevant time frame for the folio content; inputstring
">
		<cfreturn variables.instance.timeFrameFrom />
	</cffunction>

	<cffunction name="setTimeFrameFrom" returnType="void" access="public" output="false" hint="[DC] The earliest date that applies to the content of the folio
thus setting a relevant time frame for the folio content; inputstring
">
		<cfargument name="_timeFrameFrom" type="string" required="true" hint="" />
		<cfset variables.instance.timeFrameFrom = arguments._timeFrameFrom />
	</cffunction>

	<cffunction name="getTimeFrameTo" returnType="string" access="public" output="false" hint="[DC] The latest date that applies to the content of the folio
thus setting a relevant time frame for the folio content; input
by user data entry
string
">
		<cfreturn variables.instance.timeFrameTo />
	</cffunction>

	<cffunction name="setTimeFrameTo" returnType="void" access="public" output="false" hint="[DC] The latest date that applies to the content of the folio
thus setting a relevant time frame for the folio content; input
by user data entry
string
">
		<cfargument name="_timeFrameTo" type="string" required="true" hint="" />
		<cfset variables.instance.timeFrameTo = arguments._TimeFrameTo />
	</cffunction>

	<cffunction name="getSubjectEN" returnType="string" access="public" output="false" hint="[DC] The nature of the content of the resource. Typically, the
subject will be represented using keywords; input by user
data entry
string
">
		<cfreturn variables.instance.subjectEN />
	</cffunction>

	<cffunction name="setSubjectEN" returnType="void" access="public" output="false" hint="[DC] The nature of the content of the resource. Typically, the
subject will be represented using keywords; input by user
data entry
string
">
		<cfargument name="_subjectEN" type="string" required="true" hint="" />
		<cfset variables.instance.subjectEN = arguments._subjectEN />
	</cffunction>

	<cffunction name="getTranscriptionAuthor" returnType="string" access="public" output="false" hint="The author of the transcription; input by user data entry">
		<cfreturn variables.instance.transcriptionAuthor />
	</cffunction>

	<cffunction name="setTranscriptionAuthor" returnType="void" access="public" output="false" hint="The author of the transcription; input by user data entry">
		<cfargument name="_transcriptionAuthor" type="string" required="true" hint="" />
		<cfset variables.instance.transcriptionAuthor = arguments._transcriptionAuthor />
	</cffunction>

	<cffunction name="getTranscription" returnType="string" access="public" output="false" hint="[DC] An account of the resource. Can contain a transcription
of the hardwritten text, manually created or by OCR.memo
">
		<cfreturn variables.instance.Transcription />
	</cffunction>

	<cffunction name="setTranscription" returnType="void" access="public" output="false" hint="[DC] An account of the resource. Can contain a transcription
of the hardwritten text, manually created or by OCR.memo
">
		<cfargument name="_Transcription" type="string" required="true" hint="" />
		<cfset variables.instance.Transcription = arguments._Transcription />
	</cffunction>

	<cffunction name="getTranslationENAuthor" returnType="string" access="public" output="false" hint="The author of the English translation; input by user data
entrystring
">
		<cfreturn variables.instance.translationENAuthor />
	</cffunction>

	<cffunction name="setTranslationENAuthor" returnType="void" access="public" output="false" hint="The author of the English translation; input by user data
entrystring
">
		<cfargument name="_translationENAuthor" type="string" required="true" hint="" />
		<cfset variables.instance.translationENAuthor = arguments._translationENAuthor />
	</cffunction>

	<cffunction name="getCreator" returnType="string" access="public" output="false" hint="[DC] A reference to the entity responsible for creating the
; system generated, for ANRI this will be &lsquo;ID_JaAN&rsquo; by
default; mandatory
string
">
		<cfreturn variables.instance.Creator />
	</cffunction>

	<cffunction name="setCreator" returnType="void" access="public" output="false" hint="[DC] A reference to the entity responsible for creating the
; system generated, for ANRI this will be &lsquo;ID_JaAN&rsquo; by
default; mandatory
string
">
		<cfargument name="_creator" type="string" required="true" hint="" />
		<cfset variables.instance.Creator = arguments._Creator />
	</cffunction>

	<cffunction name="getDate" returnType="any" access="public" output="false" hint="DC] date stamp, indicating the moment the  was
created; system generated, derived from the  meta data
image file; mandatory
string
">
		<cfreturn variables.instance.date />
	</cffunction>

	<cffunction name="setDate" returnType="void" access="public" output="false" hint="DC] date stamp, indicating the moment the  was
created; system generated, derived from the  meta data
image file; mandatory
string
">
		<cfargument name="_date" type="any" required="true" hint="" />
		<cfset variables.instance.date = arguments._date />
	</cffunction>

	<cffunction name="getFormat" returnType="string" access="public" output="false" hint="[DC] Contains separate technical meta data of the
Content (like format, resolution, color map, camera
specs, dimensions etcetera.) in case this meta data is not
included in the image file itsmemo
">
		<cfreturn variables.instance.format />
	</cffunction>

	<cffunction name="setFormat" returnType="void" access="public" output="false" hint="[DC] Contains separate technical meta data of the
Content (like format, resolution, color map, camera
specs, dimensions etcetera.) in case this meta data is not
included in the image file itsmemo
">
		<cfargument name="_format" type="string" required="true" hint="" />
		<cfset variables.instance.format = arguments._format />
	</cffunction>

	<cffunction name="getContributor" returnType="string" access="public" output="false" hint="[DC] A reference to the entity responsible for contribution to
the , for example adding meta data to it; system
generated, for ANRI this will be &lsquo;ID_JaAN&rsquo; by default;
mandatory
string
">
		<cfreturn variables.instance.contributor />
	</cffunction>

	<cffunction name="setContributor" returnType="void" access="public" output="false" hint="[DC] A reference to the entity responsible for contribution to
the , for example adding meta data to it; system
generated, for ANRI this will be &lsquo;ID_JaAN&rsquo; by default;
mandatory
string
">
		<cfargument name="_contributor" type="string" required="true" hint="" />
		<cfset variables.instance.contributor = arguments._contributor />
	</cffunction>

	<cffunction name="getPublisher" returnType="string" access="public" output="false" hint="[DC] A reference to the entity responsible for making the
 available and accessible; system generated, for ANRI
this will be &lsquo;ID_JaAN&rsquo; by default; mandatory
string
">
		<cfreturn variables.instance.Publisher />
	</cffunction>

	<cffunction name="setPublisher" returnType="void" access="public" output="false" hint="[DC] A reference to the entity responsible for making the
 available and accessible; system generated, for ANRI
this will be &lsquo;ID_JaAN&rsquo; by default; mandatory
string
">
		<cfargument name="_Publisher" type="string" required="true" hint="" />
		<cfset variables.instance.Publisher = arguments._Publisher />
	</cffunction>

	<cffunction name="getRights" returnType="string" access="public" output="false" hint="[DC] Information about rights held in and over the resource.&nbsp;
Needs further elaboration, based on the Indonesian archival laws and standards within ANRI
string
">
		<cfreturn variables.instance.rights />
	</cffunction>

	<cffunction name="setRights" returnType="void" access="public" output="false" hint="[DC] Information about rights held in and over the resource.&nbsp;
Needs further elaboration, based on the Indonesian archival laws and standards within ANRI
string
">
		<cfargument name="_rights" type="string" required="true" hint="" />
		<cfset variables.instance.rights = arguments._rights />
	</cffunction>

	<cffunction name="getTranslationENDate" returnType="any" access="public" output="false" hint=" ">
		<cfreturn variables.instance.translationENDate />
	</cffunction>

	<cffunction name="setTranslationENDate" returnType="void" access="public" output="false" hint="">
		<cfargument name="_translationENDate" type="any" required="true" hint="" />
		<cfset variables.instance.translationENDate = arguments._translationENDate />
	</cffunction>

	<cffunction name="asString" returnType="any" access="public" output="false" hint="returns a string representation of the scan object">
		<cfreturn listLast(getHiresImage(),"/")/>
	</cffunction>

	<cffunction name="getFileName" returnType="any" access="public" output="false" hint="returns a string representation of the scan object">
		<cfreturn variables.instance.fileName/>
	</cffunction>

	<cffunction name="setFileName" returnType="any" access="public" output="false" hint="returns a filename">
		<cfargument name="fileName">
		<cfset variables.instance.fileName= arguments.filename/>
	</cffunction>

	<cffunction name="addImage">
		<cfargument name="image">
		<cfset variables.instance.images.add(image)>
	</cffunction>

	<cffunction name="removeImage">
		<cfargument name="image">
		<cfscript>
			variables.instance.images.remove(image);
		</cfscript>
	</cffunction>

	<cffunction name="hasImages">
		<cfargument name="image">
		<cfreturn variables.instance.images.contains(image)>
	</cffunction>

	<cffunction name="getImages">
		<cfreturn variables.instance.images >
	</cffunction>

	<!--- DEPENDENCIES
<cffunction name="getDateConverter" access="public">
	<cfscript>
		return variables.instance.dateConverter;
	</cfscript>
</cffunction>
<cffunction name="setDateConverter" access="public">
	<cfargument name="dateConverter" type="any"/>
	<cfscript>
		variables.instance.dateConverter = arguments.dateConverter;
	</cfscript>
</cffunction>
<cffunction name="getDateConverterISO" access="public">
	<cfscript>
		return variables.instance.dateConverterISO;
	</cfscript>
</cffunction>
<cffunction name="setDateConverterISO" access="public">
	<cfargument name="dateConverterISO" type="any"/>
	<cfscript>
		variables.instance.dateConverterISO = arguments.dateConverterISO;
	</cfscript>
</cffunction>

<cffunction name="getDateTimeConverterISO" access="public">
	<cfscript>
		return variables.instance.dateTimeConverterISO;
	</cfscript>
</cffunction>
<cffunction name="setDateTimeConverterISO" access="public">
	<cfargument name="dateTimeConverterISO" type="any"/>
	<cfscript>
		variables.instance.dateTimeConverterISO = arguments.dateTimeConverterISO;
	</cfscript>
</cffunction>
 --->
	<cffunction name="getArchivesGateway" access="public">
		<cfscript>
			return variables.instance.archivesGateway;
		</cfscript>
	</cffunction>

	<cffunction name="setArchivesGateway" access="public">
		<cfargument name="archivesGateway" type="any"/>
		<cfscript>
			variables.instance.archivesGateway = arguments.archivesGateway;
		</cfscript>
	</cffunction>

	<cffunction name="convertDateTimeToIsoString" access="private">
		<cfargument name="date" type="date"/>
		<cfscript>
			var local={};
			local.dateTimeUTC=DateConvert( "Local2UTC", arguments.date );
			local.dateTimeISO=dateFormat(dateTimeUTC,'yyyy-mm-dd') & "T" & TimeFormat(dateTimeUTC,'HH:MM:SS') & "Z" ;
			return local.dateTimeISO;
		</cfscript>
	</cffunction>

	<cffunction name="convertDateToIsoString" access="private">
		<cfargument name="date" type="date"/>
		<cfscript>
			var local={};
			local.dateTimeUTC=DateConvert( "Local2UTC", arguments.date );
			local.dateTimeISO=dateFormat(dateTimeUTC,'yyyy-mm-dd')  ;
			return local.dateTimeISO;
		</cfscript>
	</cffunction>

</cfcomponent>