����  -* 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc BcfVarScopeChecker2ecfc1846151587$funcGETNONVARSCOPEDLOCALVARIABLES  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this DLcfVarScopeChecker2ecfc1846151587$funcGETNONVARSCOPEDLOCALVARIABLES; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  I  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   LOCAL  coldfusion/runtime/CfJspPage   pageContext #Lcoldfusion/runtime/NeoPageContext; " #	 ! $ getOut ()Ljavax/servlet/jsp/JspWriter; & ' javax/servlet/jsp/PageContext )
 * ( parent Ljavax/servlet/jsp/tagext/Tag; , -	 ! . ARRAYOFVARSCOPE 0 array 2 getVariable  (I)Lcoldfusion/runtime/Variable; 4 5 %coldfusion/runtime/ArgumentCollection 7
 8 6 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; : ;
  < putVariable  (Lcoldfusion/runtime/Variable;)V > ?
  @ ARRAYOFBODYVARS B 

	 D _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V F G
 ! H 	StructNew !()Lcoldfusion/util/FastHashtable; J K coldfusion/runtime/CFPage M
 N L set (Ljava/lang/Object;)V P Q coldfusion/runtime/Variable S
 T R 
	 V 0 X java/lang/String Z 
DANGERVARS \ ArrayNew (I)Ljava/util/List; ^ _
 N ` _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V b c
 ! d 
	
	 f VARSCOPELIST h _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; j k
 ! l _List $(Ljava/lang/Object;)Ljava/util/List; n o coldfusion/runtime/Cast q
 r p ArrayToList $(Ljava/util/List;)Ljava/lang/String; t u
 N v ArrayLen (Ljava/lang/Object;)I x y
 N z 1 | _double (Ljava/lang/String;)D ~ 
 r � _Object (D)Ljava/lang/Object; � �
 r � i � SetVariable 8(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object; � �
 N � 
		 � THISVAR � _resolve � k
 ! � _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; � �
 ! � _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; � �
 ! � THISVARNEEDSFLAGGED � True � 


		
		 � 	PARENTVAR � getParentVariable � _get &(Ljava/lang/String;)Ljava/lang/Object; � �
 ! � java/lang/Object � 
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object; � �
 ! � 
		
		 � ethis,application,arguments,cfcatch,cfhttp,cgi,client,cookie,form,request,server,session,url,variables � _String &(Ljava/lang/Object;)Ljava/lang/String; � �
 r � ListFindNoCase '(Ljava/lang/String;Ljava/lang/String;)I � �
 N � _boolean (D)Z � �
 r � (Z)Ljava/lang/Object; � �
 r � (Ljava/lang/Object;)Z � �
 r � 	ArrayFind � 
			 � ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z � �
 N � CFLOOP � checkRequestTimeout (Ljava/lang/String;)V � �
 ! � _checkCondition (DDD)Z � �
 ! � 
 � getNonVarScopedLocalVariables � metaData Ljava/lang/Object; � �	  � private � false � &coldfusion/runtime/AttributeCollection � name � 
returnType � access � output � hint ��Accepts two arrays: the first is an array of all vars set in the var scope, the second is an array of all 
		  variables set in the body of a function.  This method compares the two and returns an array of all variables
		  set in the function body that are not var scoped and do not belong to the 'variables' or 'this' scopes.  (In other
		  words, it returns an array of all variables that should be var scoped and are not) � 
Parameters � TYPE � REQUIRED � yes � NAME � arrayOfVarScope � HINT � &The array of var-scoped variable names � ([Ljava/lang/Object;)V 
 � arrayOfBodyVars -The array of variables set in a function body 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS I LOCAL ARRAYOFVARSCOPE ARRAYOFBODYVARS t14 D t16 t18 LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                	     !     �                
	     !     3�                	     !     ڰ                    �    �+� :+,� :	+� :
+� :-� %� +:-� /:*13� 9� =:+� A*C3� 9� =:+� A-E� I� O� U-W� I
Y� U-E� I-� [Y]S-� a� e-g� I-� [YiS-� [Y1S� m� s� w� e-W� I9-� [YCS� m� {�9}� �9� �:-�� �W��-�� I-� [Y�S-� [YCS� �-
� �� �� e-�� I-� [Y�S�� e-�� I-� [Y�S-�� ��-� �Y-� [Y�S� mS� �� e-�� I�-� [Y�S� m� �� ��� ��� �Y� ę 4W-� [YiS� m� �-� [Y�S� m� �� ��� ��� �Y� ę @W-ƶ ��-� �Y-� [Y]S� mSY-� [Y�S� mS� �� ��� �� ę 9-ȶ I--� [Y]S� m� s-� [Y�S� m� �W-�� I-W� Ic\9� �:-�� �Wθ �� ֚�s-E� I-� [Y]S� m�-ض I�       �   �      �   � �   �   �   �   � �   � , -   �   � 	  � 
  �   �   �   �    �!    �"  #  ~ _  � C� Z� C� `� j� h� h� p� z� x� x� � �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� ����$���	�	�0�D�D�8�8�I�]�l�]�]�Q�Q����������������������������������������������������,�5�5�G�G�4�4�4�Z���b�x� ������������ $      �     ɻ �Y� �Y�SY�SY�SY3SY�SY�SY�SY�SY�SY	�SY
�SY� �Y� �Y� �Y�SY3SY�SY�SY�SY�SY�SY S�SY� �Y� �Y�SY3SY�SY�SY�SYSY�SYS�SS�� ޱ           �     %	     !     �                &'     -     � [Y1SYCS�                ()     "     � ް                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc  cfVarScopeChecker2ecfc1846151587  coldfusion/runtime/CFComponent  <init> ()V  
  	 this "LcfVarScopeChecker2ecfc1846151587; LocalVariableTable Code com.macromedia.SourceModTime  ���o coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;   javax/servlet/jsp/PageContext 
   parent Ljavax/servlet/jsp/tagext/Tag;  	    



 " _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V $ %
  & 





 ( _factor0 O(Ljavax/servlet/jsp/tagext/Tag;Ljavax/servlet/jsp/JspWriter;)Ljava/lang/Object; * +
  , 

 . getVarScopedVariables Lcoldfusion/runtime/UDFMethod; :cfVarScopeChecker2ecfc1846151587$funcGETVARSCOPEDVARIABLES 2
 3 	 0 1	  5 getVarScopedVariables 7 registerUDF 3(Ljava/lang/String;Lcoldfusion/runtime/UDFMethod;)V 9 :
  ; isRelativeDirectory 8cfVarScopeChecker2ecfc1846151587$funcISRELATIVEDIRECTORY >
 ? 	 = 1	  A isRelativeDirectory C getFunctionName 4cfVarScopeChecker2ecfc1846151587$funcGETFUNCTIONNAME F
 G 	 E 1	  I getFunctionName K getParentVariable 6cfVarScopeChecker2ecfc1846151587$funcGETPARENTVARIABLE N
 O 	 M 1	  Q getParentVariable S getNonVarScopedLocalVariables BcfVarScopeChecker2ecfc1846151587$funcGETNONVARSCOPEDLOCALVARIABLES V
 W 	 U 1	  Y getNonVarScopedLocalVariables [ 	arrayFind .cfVarScopeChecker2ecfc1846151587$funcARRAYFIND ^
 _ 	 ] 1	  a 	arrayFind c getVariablesSetInBody :cfVarScopeChecker2ecfc1846151587$funcGETVARIABLESSETINBODY f
 g 	 e 1	  i getVariablesSetInBody k getFunctionBody 4cfVarScopeChecker2ecfc1846151587$funcGETFUNCTIONBODY n
 o 	 m 1	  q getFunctionBody s recursiveFileList 6cfVarScopeChecker2ecfc1846151587$funcRECURSIVEFILELIST v
 w 	 u 1	  y recursiveFileList { replaceInStringLiterals <cfVarScopeChecker2ecfc1846151587$funcREPLACEINSTRINGLITERALS ~
  	 } 1	  � replaceInStringLiterals � getVarSection 2cfVarScopeChecker2ecfc1846151587$funcGETVARSECTION �
 � 	 � 1	  � getVarSection � getFunctionArray 5cfVarScopeChecker2ecfc1846151587$funcGETFUNCTIONARRAY �
 � 	 � 1	  � getFunctionArray � check *cfVarScopeChecker2ecfc1846151587$funcCHECK �
 � 	 � 1	  � check � init )cfVarScopeChecker2ecfc1846151587$funcINIT �
 � 	 � 1	  � init � arrayAppendArray 5cfVarScopeChecker2ecfc1846151587$funcARRAYAPPENDARRAY �
 � 	 � 1	  � arrayAppendArray � isAbsoluteDirectory 8cfVarScopeChecker2ecfc1846151587$funcISABSOLUTEDIRECTORY �
 � 	 � 1	  � isAbsoluteDirectory � metaData Ljava/lang/Object; � �	  � &coldfusion/runtime/AttributeCollection � java/lang/Object � displayName � VarScopeChecker � output � false � hint � ^Parses a .cfc file, .cfm file or raw block of text looking for non-var-scoped local variables. � Name � 	Functions �	 3 �	 ? �	 G �	 O �	 W �	 _ �	 g �	 o �	 w �	  �	 � �	 � �	 � �	 � �	 � �	 � � ([Ljava/lang/Object;)V  �
 � � 	getOutput ()Ljava/lang/String; __factorParent out Ljavax/servlet/jsp/JspWriter; value LineNumberTable runPage ()Ljava/lang/Object; <clinit> getMetadata registerUDFs 1       0 1    = 1    E 1    M 1    U 1    ] 1    e 1    m 1    u 1    } 1    � 1    � 1    � 1    � 1    � 1    � 1    � �           #     *� 
�                 � �     !     İ                 * +     �     A*,#� '*,)� '*,)� '*,#� '*,#� '*,#� '*,#� '*,#� '*,#� '*�       *    A       A �     A � �    A � �  �   & 	     (  n  �  � # � * � 1 8A  � �     �     S*� � L*� !N*-+� -� �*+#� '*+#� '*+#� '*+#� '*+#� '*+#� '*+#� '*+/� '�       *    S       S � �    S � �    S    �   & 	 �  � '� .� 5$ <8 CN Jj     �     � 	   S� 3Y� 4� 6� ?Y� @� B� GY� H� J� OY� P� R� WY� X� Z� _Y� `� b� gY� h� j� oY� p� r� wY� x� z� Y� �� �� �Y� �� �� �Y� �� �� �Y� �� �� �Y� �� �� �Y� �� �� �Y� �� �� �Y
� �Y�SY�SY�SY�SY�SY�SY�SY�SY�SY	� �Y� �SY� �SY� �SY� �SY� �SY� �SY� �SY� �SY� �SY	� �SY
� �SY� �SY� �SY� �SY� �SY� �SS� ߳ ��          S     �   B  � � �� � � �S ��=H � $ �+ v2 .9 #@)G�  � �     "     � ��                 �      �     �*8� 6� <*D� B� <*L� J� <*T� R� <*\� Z� <*d� b� <*l� j� <*t� r� <*|� z� <*�� �� <*�� �� <*�� �� <*�� �� <*�� �� <*�� �� <*�� �� <�           �               ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc 5cfVarScopeChecker2ecfc1846151587$funcARRAYAPPENDARRAY  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 7LcfVarScopeChecker2ecfc1846151587$funcARRAYAPPENDARRAY; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  NEWARRAY  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   I  coldfusion/runtime/CfJspPage   pageContext #Lcoldfusion/runtime/NeoPageContext; " #	 ! $ getOut ()Ljavax/servlet/jsp/JspWriter; & ' javax/servlet/jsp/PageContext )
 * ( parent Ljavax/servlet/jsp/tagext/Tag; , -	 ! . 	BASEARRAY 0 array 2 getVariable  (I)Lcoldfusion/runtime/Variable; 4 5 %coldfusion/runtime/ArgumentCollection 7
 8 6 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; : ;
  < putVariable  (Lcoldfusion/runtime/Variable;)V > ?
  @ 
ARRAYTOADD B 

	 D _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V F G
 ! H java/lang/String J _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; L M
 ! N 	Duplicate &(Ljava/lang/Object;)Ljava/lang/Object; P Q coldfusion/runtime/CFPage S
 T R set (Ljava/lang/Object;)V V W coldfusion/runtime/Variable Y
 Z X 
	 \ 0 ^ 
	
	 ` ArrayLen (Ljava/lang/Object;)I b c
 T d 1 f _double (Ljava/lang/String;)D h i coldfusion/runtime/Cast k
 l j _Object (D)Ljava/lang/Object; n o
 l p i r SetVariable 8(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object; t u
 T v 
		 x _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; z {
 ! | _List $(Ljava/lang/Object;)Ljava/util/List; ~ 
 l � _resolve � M
 ! � _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; � �
 ! � ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z � �
 T � CFLOOP � checkRequestTimeout (Ljava/lang/String;)V � �
 ! � _checkCondition (DDD)Z � �
 ! � 
 � arrayAppendArray � metaData Ljava/lang/Object; � �	  � private � false � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returnType � access � output � hint � eAccepts two arrays, appends all elements from the second onto the first, and then returns the result. � 
Parameters � TYPE � REQUIRED � yes � NAME � 	baseArray � HINT � The array to append to � ([Ljava/lang/Object;)V  �
 � � 
arrayToAdd � The array to append � 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS NEWARRAY I 	BASEARRAY 
ARRAYTOADD t14 D t16 t18 LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                 � �     !     ��                 � �     !     3�                 � �     !     ��                 � �    �    >+� :+,� :	+� :
+� :-� %� +:-� /:*13� 9� =:+� A*C3� 9� =:+� A-E� I
-� KY1S� O� U� [-]� I_� [-a� I9-� KYCS� O� e�9g� m9� q:-s� wW� T-y� I--
� }� �-� KYCS� �-� }� �� �W-]� Ic\9� q:-s� wW�� �� ����-E� I-
� }�-�� I�       �   >      > � �   > � �   > � �   > � �   > � �   > � �   > , -   > � �   > � � 	  > � � 
  > � �   > � �   > � �   > � �   > � �   > � �  �   � '  ) C+ Z- C+ `. j0 j0 j0 h0 h0 0 �1 �1 �1 �1 �3 �3 �3 �3 �3 �3 �3 �4 �4 �4 �4 �4 �4 �4 �4 �4 �43 �3%5-7-7-547  �      �     ƻ �Y� �Y�SY�SY�SY3SY�SY�SY�SY�SY�SY	�SY
�SY� �Y� �Y� �Y�SY3SY�SY�SY�SY�SY�SY�S� �SY� �Y� �Y�SY3SY�SY�SY�SY�SY�SY�S� �SS� ų ��           �      � �     !     ��                 � �     -     � KY1SYCS�                 � �     "     � ��                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc .cfVarScopeChecker2ecfc1846151587$funcARRAYFIND  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 0LcfVarScopeChecker2ecfc1846151587$funcARRAYFIND; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  FOUNDAT  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   I  coldfusion/runtime/CfJspPage   pageContext #Lcoldfusion/runtime/NeoPageContext; " #	 ! $ getOut ()Ljavax/servlet/jsp/JspWriter; & ' javax/servlet/jsp/PageContext )
 * ( parent Ljavax/servlet/jsp/tagext/Tag; , -	 ! . ARRAY 0 array 2 getVariable  (I)Lcoldfusion/runtime/Variable; 4 5 %coldfusion/runtime/ArgumentCollection 7
 8 6 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; : ;
  < putVariable  (Lcoldfusion/runtime/Variable;)V > ?
  @ VALUE B any D 

	 F _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V H I
 ! J 0 L set (Ljava/lang/Object;)V N O coldfusion/runtime/Variable Q
 R P 
	 T java/lang/String V _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; X Y
 ! Z ArrayLen (Ljava/lang/Object;)I \ ] coldfusion/runtime/CFPage _
 ` ^ 1 b _double (Ljava/lang/String;)D d e coldfusion/runtime/Cast g
 h f _Object (D)Ljava/lang/Object; j k
 h l i n SetVariable 8(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object; p q
 ` r 
		 t _resolve v Y
 ! w _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; y z
 ! { _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; } ~
 !  _compare '(Ljava/lang/Object;Ljava/lang/Object;)D � �
 ! � 
			 � CFLOOP � checkRequestTimeout (Ljava/lang/String;)V � �
 ! � _checkCondition (DDD)Z � �
 ! � 
 � 	arrayFind � metaData Ljava/lang/Object; � �	  � numeric � private � false � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returnType � access � output � hint � �Accepts an array and a value, returns the index of that array in which the value is first found.  Returns 0 if the value is not found. � 
Parameters � TYPE � REQUIRED � yes � NAME � HINT � The array to search � ([Ljava/lang/Object;)V  �
 � � value � The value to search for � 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS FOUNDAT I ARRAY VALUE t14 D t16 t18 LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                 � �     !     ��                 � �     !     ��                 � �     !     ��                 � �    �    a+� :+,� :	+� :
+� :-� %� +:-� /:*13� 9� =:+� A*CE� 9� =:+� A-G� K
M� S-U� KM� S-U� K9-� WY1S� [� a�9c� i9� m:-o� sW� �-u� K-� WY1S� x-� |� �-� WYCS� [� ��~�� )-�� K
-� |� S-�� K� :-u� K-U� Kc\9� m:-o� sW�� �� ���s-G� K-
� |�-�� K�       �   a      a � �   a � �   a � �   a � �   a � �   a � �   a , -   a � �   a � � 	  a � � 
  a � �   a � �   a � �   a � �   a � �   a � �  �   � )  = C? ZA C? `B jD hD hD oD yE wE wE ~E �F �F �F �F �F �F �F �G �G �G �G �G �H �H �H �HHII �GJ/F �FHKPMPMPKWM  �      �     ƻ �Y� �Y�SY�SY�SY�SY�SY�SY�SY�SY�SY	�SY
�SY� �Y� �Y� �Y�SY3SY�SY�SY�SY3SY�SY�S� �SY� �Y� �Y�SYESY�SY�SY�SY�SY�SY�S� �SS� �� ��           �      � �     !     ��                 � �     -     � WY1SYCS�                 � �     "     � ��                     ����  -� 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc *cfVarScopeChecker2ecfc1846151587$funcCHECK  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this ,LcfVarScopeChecker2ecfc1846151587$funcCHECK; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  K  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   I  LOCAL   J " coldfusion/runtime/CfJspPage $ pageContext #Lcoldfusion/runtime/NeoPageContext; & '	 % ( getOut ()Ljavax/servlet/jsp/JspWriter; * + javax/servlet/jsp/PageContext -
 . , parent Ljavax/servlet/jsp/tagext/Tag; 0 1	 % 2 FILEORDIRECTORY 4 string 6 getVariable  (I)Lcoldfusion/runtime/Variable; 8 9 %coldfusion/runtime/ArgumentCollection ;
 < : _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; > ?
  @ putVariable  (Lcoldfusion/runtime/Variable;)V B C
  D 

	 F _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V H I
 % J 	StructNew !()Lcoldfusion/util/FastHashtable; L M coldfusion/runtime/CFPage O
 P N set (Ljava/lang/Object;)V R S coldfusion/runtime/Variable U
 V T 
	 X 0 Z 	
	
	
	 \ java/lang/String ^ FILESTOSCAN ` ArrayNew (I)Ljava/util/List; b c
 P d _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V f g
 % h isAbsoluteDirectory j _get &(Ljava/lang/String;)Ljava/lang/Object; l m
 % n java/lang/Object p _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; r s
 % t 
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object; v w
 % x _boolean (Ljava/lang/Object;)Z z { coldfusion/runtime/Cast }
 ~ | 
		 � recursiveFileList � 	*.cf[c|m] � _List $(Ljava/lang/Object;)Ljava/util/List; � �
 ~ � ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z � �
 P � 

	
	 � ERRORS � ArrayLen (Ljava/lang/Object;)I � �
 P � 1 � _double (Ljava/lang/String;)D � �
 ~ � _Object (D)Ljava/lang/Object; � �
 ~ � i � SetVariable 8(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object; � �
 P � "class$coldfusion$tagext$io$FileTag Ljava/lang/Class; coldfusion.tagext.io.FileTag � forName %(Ljava/lang/String;)Ljava/lang/Class; � � java/lang/Class �
 � � � �	  � _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; � �
 % � coldfusion/tagext/io/FileTag � cffile � action � read � _validateTagAttrValue J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; � �
 % � 	setAction (Ljava/lang/String;)V � �
 � � variable � 
local.code � setVariable � �
 � � file � _resolve � s
 % � _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; � �
 % � _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; � �
 % � _String &(Ljava/lang/Object;)Ljava/lang/String; � �
 ~ � setFile � �
 � � 
doStartTag ()I � �
 � � doAfterBody � � coldfusion/tagext/GenericTag �
 � � doEndTag � � #javax/servlet/jsp/tagext/TagSupport �
 � � 
	
		
		 � 	FUNCTIONS � getFunctionArray � CODE � 


		
		 � j � 
			 � 	THISFUNCT � THISFUNCTNAME � getFunctionName 
			
			
			 BODY getFunctionBody VARSECTIONVARS	 getVarScopedVariables getVarSection 
		
			
			 BODYVARS getVariablesSetInBody 
DANGERVARS getNonVarScopedLocalVariables k 
				 	THISERROR _LhsResolve s
 %  filename" _arraySetAt :(Ljava/lang/Object;[Ljava/lang/Object;Ljava/lang/Object;)V$%
 %& function( CFLOOP* checkRequestTimeout, �
 %- _checkCondition (DDD)Z/0
 %1 
3 check5 metaData Ljava/lang/Object;78	 9 array; public= false? &coldfusion/runtime/AttributeCollectionA nameC 
returnTypeE accessG outputI hintK?Accepts a string that is an absolute path to a file or a directory. If a directory name is given then all .cfm and .cfc files 
		  in that directory are examined. Returns an array of structs describing any local variables that were found but not properly 
		  var-scoped.  Each struct has the following keys: <br />
		  	 .filename = a STRING that is the name of the file with the offending variable<br />
		  	 .function = a STRING that is the name of the function containing the variable<br />
		     .variable = a STRING that is the name of a non-var-scoped local variableM 
ParametersO TYPEQ REQUIREDS yesU NAMEW fileOrDirectoryY HINT[ /An absolute path to either a file or directory.] ([Ljava/lang/Object;)V _
B` 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS K I LOCAL J FILEORDIRECTORY t15 D t17 t19 file0 Lcoldfusion/tagext/io/FileTag; mode0 t23 t25 t27 t29 t31 t33 LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   78   	        #     *� 
�                bc     "     @�                dc     "     <�                ec     "     6�                fg    
)  #  +� :+,� :	+� :
+� :+!� :+#� :-� )� /:-� 3:*57� =� A:+� E-G� K� Q� W-Y� K[� W-Y� K[� W-Y� K
[� W-]� K-� _YaS-� e� i-Y� K-k� ok-� qY-� _Y5S� uS� y� � L-�� K-� _YaS-�� o�-� qY-� _Y5S� uSY�S� y� i-Y� K� 9-�� K--� _YaS� u� �-� _Y5S� u� �W-Y� K-�� K-� _Y�S-� e� i-�� K9-� _YaS� u� ��9�� �9� �:-�� �W�:-�� K-� �� �� �:���� �� ���ɸ �� ���-� _YaS� �-� ո ٸ ݸ �� �� �Y6� � ���� �� �-� K-� _Y�S-�� o�-� qY-� _Y�S� uS� y� i-�� K9-� _Y�S� u� ��9�� �9� �:-�� �W�-�� K-� _Y�S-� _Y�S� �-� ո ٶ i-�� K-� _Y S-� o-� qY-� _Y�S� uS� y� i-� K-� _YS-� o-� qY-� _Y�S� uS� y� i-� K-� _Y
S-� o-� qY-� o-� qY-� _YS� uS� yS� y� i-� K-� _YS-� o-� qY-� _YS� uS� y� i-� K-� _YS-� o-� qY-� _Y
S� uSY-� _YS� uS� y� i-�� K9-� _YS� u� ��9�� �9!!� �:-� �W�)-� K-� _YS� Q� i-� K--� _YS�!� qY#S-� _YaS� �-� ո ٶ'-� K--� _YS�!� qY)S-� _Y S� u�'-� K--� _YS�!� qY�S-� _YS� �-
� ո ٶ'-� K--� _Y�S� u� �-� _YS� u� �W-�� K!c\9!� �:-� �W+�.!�2���-�� Kc\9� �:-�� �W+�.�2���-Y� Kc\9� �:-�� �W+�.�2���-G� K-� _Y�S� u�-4� K�               hi   j8   kl   mn   op   q8    0 1   rs   ts 	  us 
  vs   ws   xs   ys   z{   |{   }{   ~   �v   �{   �{   �{   �{   �{   �{ !�  � �   . S 5 S 5 Y 7 c 9 a 9 a 9 i 9 s : q : q : x : � ; � ; � ; � ; � < � < � < � < � ? � ? � ? � ? � ? � ? � @ � @ � @ � @ � A A A � A � A � A � A  A+ B4 C4 CF CF C3 C3 C3 CY C+ B � @a Dv Gu Gu Gi Gi G} G� J� J� J� J� J� J� J� K� K� K� K� K� K/ KC NR NC NC N7 N7 Nh Ns Qs Qs Qs Q� Q� Q� Q� R� R� R� R� R� R� R� S� S� S� S� S� S S# V4 V# V# V V VJ V` Yq Y� Yq Y` Y` YS YS Y� Y� \� \� \� \� \� \� \� b b b� b� b� b� b, b7 c7 c7 c7 cM c\ ch c~ d~ dq dq d� d� e� e� e� e� e� e� e� e� e� f� f� f� f� f� f� f g g g- g g g g g9 gC hC hU hU hB hB hB hi h c4 c� i� Qp Q� j� J� J� k m m k m �      �     ��� �� ��BY� qYDSY6SYFSY<SYHSY>SYJSY@SYLSY	NSY
PSY� qY�BY� qYRSY7SYTSYVSYXSYZSY\SY^S�aSS�a�:�           �     �c     "     >�                ��     (     
� _Y5S�           
     ��     "     �:�                     ����  - r 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc )cfVarScopeChecker2ecfc1846151587$funcINIT  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this +LcfVarScopeChecker2ecfc1846151587$funcINIT; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 

	 ) _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V + ,
  - _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; / 0
  1 
 3 java/lang/String 5 init 7 metaData Ljava/lang/Object; 9 :	  ; VarScopeChecker = public ? false A &coldfusion/runtime/AttributeCollection C java/lang/Object E name G 
returnType I access K output M hint O Constructor for this component. Q 
Parameters S ([Ljava/lang/Object;)V  U
 D V 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       9 :   	        #     *� 
�                 X Y     !     B�                 Z Y     !     >�                 [ Y     !     8�                 \ ]     �  
   ;+� :+,� :	-� � $:-� (:-*� .-	� 2�-4� .�       f 
   ;       ; ^ _    ; ` :    ; a b    ; c d    ; e f    ; g :    ; % &    ; h i    ; j i 	 k       # " % " % * ' * ' * % 1 '  l      r     T� DY� FYHSY8SYJSY>SYLSY@SYNSYBSYPSY	RSY
TSY� FS� W� <�           T      m Y     !     @�                 n o     #     � 6�                 p q     "     � <�                     ����  - 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc :cfVarScopeChecker2ecfc1846151587$funcGETVARSCOPEDVARIABLES  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this <LcfVarScopeChecker2ecfc1846151587$funcGETVARSCOPEDVARIABLES; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  LOCAL  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;   !	  " getOut ()Ljavax/servlet/jsp/JspWriter; $ % javax/servlet/jsp/PageContext '
 ( & parent Ljavax/servlet/jsp/tagext/Tag; * +	  , FUNCTIONBODY . string 0 getVariable  (I)Lcoldfusion/runtime/Variable; 2 3 %coldfusion/runtime/ArgumentCollection 5
 6 4 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 8 9
  : putVariable  (Lcoldfusion/runtime/Variable;)V < =
  > 

	 @ _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V B C
  D 	StructNew !()Lcoldfusion/util/FastHashtable; F G coldfusion/runtime/CFPage I
 J H set (Ljava/lang/Object;)V L M coldfusion/runtime/Variable O
 P N 
	 R java/lang/String T VARS V ArrayNew (I)Ljava/util/List; X Y
 J Z _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V \ ]
  ^ 	
	
	
	 ` 
VARSECTION b getVarSection d _get &(Ljava/lang/String;)Ljava/lang/Object; f g
  h java/lang/Object j _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; l m
  n 
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object; p q
  r 

	
	 t STARTAT v 1 x *#local.startAt# LT #Len(local.varSection)# z prepareCondition | g
 J } 
		  
VARMATCHES � =[[:space:]]*var[[:space:]]+([a-zA-Z0-9_\.\[\]]+)[[:space:]]*= � _String &(Ljava/lang/Object;)Ljava/lang/String; � � coldfusion/runtime/Cast �
 � � _int (Ljava/lang/Object;)I � �
 � � REFindNoCase :(Ljava/lang/String;Ljava/lang/String;IZ)Ljava/lang/Object; � �
 J � 
		
		 � LEN � ArrayLen � �
 J � _Object (I)Ljava/lang/Object; � �
 � �@        _compare (Ljava/lang/Object;D)D � �
  � 
			 � _List $(Ljava/lang/Object;)Ljava/util/List; � �
 � � POS � _resolve � m
  � 2 � _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; � �
  � Mid ((Ljava/lang/String;II)Ljava/lang/String; � �
 J � ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z � �
 J � _double (Ljava/lang/Object;)D � �
 � � (D)Ljava/lang/Object; � �
 � � CFLOOP � checkRequestTimeout (Ljava/lang/String;)V � �
  � evaluateCondition (Ljava/lang/Object;)Z � �
 J � 
	
	 � 
 � getVarScopedVariables � metaData Ljava/lang/Object; � �	  � array � private � false � &coldfusion/runtime/AttributeCollection � name � 
returnType � access � output � hint � {Accepts a string that contains a CF function body and returns an array of all var-scoped variables defined in the function. � 
Parameters � TYPE � REQUIRED � yes � NAME � functionBody � HINT � The function body to analyze � ([Ljava/lang/Object;)V  �
 � � 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LOCAL FUNCTIONBODY t12 LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                 �      !     ݰ                      !     ٰ                      !     Ӱ                    J    T+� :+,� :	+� :
-� #� ):-� -:*/1� 7� ;:+� ?-A� E
� K� Q-S� E-
� UYWS-� [� _-a� E-
� UYcS-e� ie-� kY-� UY/S� oS� s� _-u� E-
� UYwSy� _-S� E{� ~:�[-�� E-
� UY�S�-
� UYcS� o� �-
� UYwS� o� �� �� _-�� E-
� UY�SY�S� o� �� � �� ��� -�� E� �-�� E� �-�� E--
� UYWS� o� �-
� UYcS� o� �-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �� �� �W-�� E-
� UYwS-
� UY�SY�S� �y� �� �-
� UY�SY�S� �y� �� �c� ö _-�� E-S� EŸ �-� ͚��-϶ E-
� UYWS� o�-Ѷ E�       �   T      T   T �   T	   T
   T   T �   T * +   T   T 	  T 
  T   T �   Z V   � ; � ; � A � K � I � I � Q � f � e � e � Y � Y � m � �  �  �  �  u  u  �  � � � � � � �	 �	 �	 �	 �		 �	 �	 �	 �		4?GJU^^pp��������pp]]]������������U �2:::J       �     �� �Y� kY�SY�SY�SY�SY�SY�SY�SY�SY�SY	�SY
�SY� kY� �Y� kY�SY1SY�SY�SY�SY�SY�SY�S� �SS� �� ױ           �           !     ۰                     (     
� UY/S�           
          "     � װ                     ����  - 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc 5cfVarScopeChecker2ecfc1846151587$funcGETFUNCTIONARRAY  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 7LcfVarScopeChecker2ecfc1846151587$funcGETFUNCTIONARRAY; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  LOCAL  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;   !	  " getOut ()Ljavax/servlet/jsp/JspWriter; $ % javax/servlet/jsp/PageContext '
 ( & parent Ljavax/servlet/jsp/tagext/Tag; * +	  , CODE . string 0 getVariable  (I)Lcoldfusion/runtime/Variable; 2 3 %coldfusion/runtime/ArgumentCollection 5
 6 4 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 8 9
  : putVariable  (Lcoldfusion/runtime/Variable;)V < =
  > 

	 @ _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V B C
  D 	StructNew !()Lcoldfusion/util/FastHashtable; F G coldfusion/runtime/CFPage I
 J H set (Ljava/lang/Object;)V L M coldfusion/runtime/Variable O
 P N 
	 R java/lang/String T FUNCTIONARRAY V ArrayNew (I)Ljava/util/List; X Y
 J Z _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V \ ]
  ^ STARTAT ` 1 b (#local.startAt# LT #Len(arguments.code)# d prepareCondition &(Ljava/lang/String;)Ljava/lang/Object; f g
 J h 
		 j FUNCTIONMATCHES l !<cffunction[^>]*>.*?</cffunction> n _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; p q
  r _String &(Ljava/lang/Object;)Ljava/lang/String; t u coldfusion/runtime/Cast w
 x v _int (Ljava/lang/Object;)I z {
 x | REFindNoCase :(Ljava/lang/String;Ljava/lang/String;IZ)Ljava/lang/Object; ~ 
 J � 
		
		 � LEN � _resolve � q
  � _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; � �
  � _compare (Ljava/lang/Object;D)D � �
  � 
			 � THISFUNCTION � POS � Mid ((Ljava/lang/String;II)Ljava/lang/String; � �
 J � _List $(Ljava/lang/Object;)Ljava/util/List; � �
 x � ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z � �
 J � _double (Ljava/lang/Object;)D � �
 x � _Object (D)Ljava/lang/Object; � �
 x � CFLOOP � checkRequestTimeout (Ljava/lang/String;)V � �
  � evaluateCondition (Ljava/lang/Object;)Z � �
 J � 
	
	 � 	
 � getFunctionArray � metaData Ljava/lang/Object; � �	  � array � private � false � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returnType � access � output � hint � jAccepts a block of code and returns an array of strings containing the function definitions from the code. � 
Parameters � TYPE � REQUIRED � yes � NAME � code � HINT � The block of code to analyze � ([Ljava/lang/Object;)V  �
 � � 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LOCAL CODE t12 LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                 � �     !     İ                 � �     !     ��                 � �     !     ��                 � �    (    >+� :+,� :	+� :
-� #� ):-� -:*/1� 7� ;:+� ?-A� E
� K� Q-S� E-
� UYWS-� [� _-A� E-
� UYaSc� _-S� Ee� i:�~-k� E-
� UYmSo-� UY/S� s� y-
� UYaS� s� }� �� _-�� E-
� UYmSY�S� �c� �� ��� -�� E�-k� E� �-�� E-
� UY�S-� UY/S� s� y-
� UYmSY�S� �c� �� }-
� UYmSY�S� �c� �� }� �� _-�� E--
� UYWS� s� �-
� UY�S� s� �W-�� E-
� UYaS-
� UYmSY�S� �c� �� �-
� UYmSY�S� �c� �� �c� �� _-k� E-S� E�� �-� ���-�� E-
� UYWS� s�-�� E�       �   >      > � �   > � �   > � �   > � �   > � �   > � �   > * +   > � �   > � � 	  > � � 
  > � �   > � �  �  N S   v ; x ; x A z K | I | I | Q | f } e } e } Y } Y } m } �  �  u  u  �  � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �- �- �? �S �? �? �[ �o �[ �[ �- �- �! �! �} �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� � � � � � � � �$ �$ �$ �4 �  �      �     �� �Y� �Y�SY�SY�SY�SY�SY�SY�SY�SY�SY	�SY
�SY� �Y� �Y� �Y�SY1SY�SY�SY�SY�SY�SY�S� �SS� � ��           �       �     !     °                     (     
� UY/S�           
          "     � ��                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc 8cfVarScopeChecker2ecfc1846151587$funcISRELATIVEDIRECTORY  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this :LcfVarScopeChecker2ecfc1846151587$funcISRELATIVEDIRECTORY; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' PATH ) string + getVariable  (I)Lcoldfusion/runtime/Variable; - . %coldfusion/runtime/ArgumentCollection 0
 1 / _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 3 4
  5 putVariable  (Lcoldfusion/runtime/Variable;)V 7 8
  9 

	 ; _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V = >
  ? false A 
 C java/lang/String E isRelativeDirectory G metaData Ljava/lang/Object; I J	  K array M private O &coldfusion/runtime/AttributeCollection Q java/lang/Object S name U 
returnType W access Y output [ hint ] lAccepts a string and returns TRUE if it represents a valid, relative path to a directory or FALSE otherwise. _ 
Parameters a TYPE c REQUIRED e yes g NAME i path k HINT m The string to test o ([Ljava/lang/Object;)V  q
 R r 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS PATH LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       I J   	        #     *� 
�                 t u     !     B�                 v u     !     N�                 w u     !     H�                 x y     �     N+� :+,� :	-� � $:-� (:**,� 2� 6:
+
� :-<� @B�-D� @�       p    N       N z {    N | J    N } ~    N  �    N � �    N � J    N % &    N � �    N � � 	   N � � 
 �   "   � 3� 3� 9� A� A� A� D�  �      �     �� RY� TYVSYHSYXSYNSYZSYPSY\SYBSY^SY	`SY
bSY� TY� RY� TYdSY,SYfSYhSYjSYlSYnSYpS� sSS� s� L�           �      � u     !     P�                 � �     (     
� FY*S�           
      � �     "     � L�                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc 6cfVarScopeChecker2ecfc1846151587$funcGETPARENTVARIABLE  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 8LcfVarScopeChecker2ecfc1846151587$funcGETPARENTVARIABLE; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  	DELIMCHAR  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   PARENT  DELIMPOS   coldfusion/runtime/CfJspPage " pageContext #Lcoldfusion/runtime/NeoPageContext; $ %	 # & getOut ()Ljavax/servlet/jsp/JspWriter; ( ) javax/servlet/jsp/PageContext +
 , * parent Ljavax/servlet/jsp/tagext/Tag; . /	 # 0 VARIABLENAME 2 string 4 getVariable  (I)Lcoldfusion/runtime/Variable; 6 7 %coldfusion/runtime/ArgumentCollection 9
 : 8 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; < =
  > putVariable  (Lcoldfusion/runtime/Variable;)V @ A
  B 

	 D _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V F G
 # H java/lang/String J _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; L M
 # N set (Ljava/lang/Object;)V P Q coldfusion/runtime/Variable S
 T R 
	 V 0 X   Z 

	
	 \ [\.\[] ^ _String &(Ljava/lang/Object;)Ljava/lang/String; ` a coldfusion/runtime/Cast c
 d b REFind 9(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Integer; f g coldfusion/runtime/CFPage i
 j h _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; l m
 # n _compare (Ljava/lang/Object;D)D p q
 # r 
		 t _int (Ljava/lang/Object;)I v w
 d x Mid ((Ljava/lang/String;II)Ljava/lang/String; z {
 j | 	ListFirst 8(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; ~ 
 j � 
 � getParentVariable � metaData Ljava/lang/Object; � �	  � private � false � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returnType � access � output � hint �-Accepts a variable name and returns the 'parent' of that variable. For structs and complex objects this
		  means the name of the top-level struct or object is returned. For simple values, the variable name itself
		  is returned. Supports both dot notation and array notation for queries and structs. � 
Parameters � TYPE � REQUIRED � yes � NAME � variableName � HINT � The name to analyze � ([Ljava/lang/Object;)V  �
 � � 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS 	DELIMCHAR PARENT DELIMPOS VARIABLENAME LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                 � �     !     ��                 � �     !     5�                 � �     !     ��                 � �    �    >+� :+,� :	+� :
+� :+!� :-� '� -:-� 1:*35� ;� ?:+� C-E� I-� KY3S� O� U-W� IY� U-W� I
[� U-]� I_-� KY3S� O� e� k� U-W� I-� o� s�� b-u� I
-� KY3S� O� e-� o� y� }� U-u� I-� KY3S� O� e-
� o� e� �� U-W� I-E� I-� o�-�� I�       �   >      > � �   > � �   > � �   > � �   > � �   > � �   > . /   > � �   > � � 	  > � � 
  > � �   > � �   > � �  �   � 4  S KW KW QY [[ Y[ Y[ m[ w\ u\ u\ |\ �] �] �] �] �c �c �c �c �c �c �c �c �d �d �d �e �e �e �e �e �e �e �e �e �e �f �fff �f �f �f �ff �d%g-i-i-g4i  �      �     �� �Y� �Y�SY�SY�SY5SY�SY�SY�SY�SY�SY	�SY
�SY� �Y� �Y� �Y�SY5SY�SY�SY�SY�SY�SY�S� �SS� �� ��           �      � �     !     ��                 � �     (     
� KY3S�           
      � �     "     � ��                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc 4cfVarScopeChecker2ecfc1846151587$funcGETFUNCTIONNAME  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 6LcfVarScopeChecker2ecfc1846151587$funcGETFUNCTIONNAME; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  LOCAL  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;   !	  " getOut ()Ljavax/servlet/jsp/JspWriter; $ % javax/servlet/jsp/PageContext '
 ( & parent Ljavax/servlet/jsp/tagext/Tag; * +	  , WHOLEFUNCTION . string 0 getVariable  (I)Lcoldfusion/runtime/Variable; 2 3 %coldfusion/runtime/ArgumentCollection 5
 6 4 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 8 9
  : putVariable  (Lcoldfusion/runtime/Variable;)V < =
  > 

	 @ _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V B C
  D 	StructNew !()Lcoldfusion/util/FastHashtable; F G coldfusion/runtime/CFPage I
 J H set (Ljava/lang/Object;)V L M coldfusion/runtime/Variable O
 P N 
	 R java/lang/String T FUNCTIONNAME V   X _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V Z [
  \ MATCHES ^ F.*<cffunction[^>]*name[[:space:]]*=[[:space:]]*"([a-zA-Z0-9_]+)"[^>]*> ` _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; b c
  d _String &(Ljava/lang/Object;)Ljava/lang/String; f g coldfusion/runtime/Cast i
 j h REFindNoCase :(Ljava/lang/String;Ljava/lang/String;IZ)Ljava/lang/Object; l m
 J n LEN p ArrayLen (Ljava/lang/Object;)I r s
 J t _Object (I)Ljava/lang/Object; v w
 j x@        _compare (Ljava/lang/Object;D)D | }
  ~ 
		 � POS � _resolve � c
  � 2 � _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; � �
  � _int � s
 j � Mid ((Ljava/lang/String;II)Ljava/lang/String; � �
 J � 
	
	 � 
 � getFunctionName � metaData Ljava/lang/Object; � �	  � private � false � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returnType � access � output � hint � hAccepts a string that contains a CF function declaration and returns a string that is the function name. � 
Parameters � TYPE � REQUIRED � yes � NAME � wholeFunction � HINT � #The function declaration to analyze � ([Ljava/lang/Object;)V  �
 � � 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LOCAL WHOLEFUNCTION LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                 � �     !     ��                 � �     !     1�                 � �     !     ��                 � �    �    U+� :+,� :	+� :
-� #� ):-� -:*/1� 7� ;:+� ?-A� E
� K� Q-S� E-
� UYWSY� ]-A� E-
� UY_Sa-� UY/S� e� k� o� ]-A� E-
� UY_SYqS� e� u� y z� �� o-�� E-
� UYWS-� UY/S� e� k-
� UY_SY�S� ��� �� �-
� UY_SYqS� ��� �� �� �� ]-S� E-�� E-
� UYWS� e�-�� E�       z   U      U � �   U � �   U � �   U � �   U � �   U � �   U * +   U � �   U � � 	  U � � 
  U � �  �   � 1   � ; � ; � A � K � I � I � Q � e � e � Y � Y � j � ~ � � � � � � � � � ~ � ~ � r � r � � � � � � � � � � � � � � � � � � � � � � � �	 � �	 �	 � � � � � � � � �+ � � �3 �; �; �; �K �  �      �     �� �Y� �Y�SY�SY�SY1SY�SY�SY�SY�SY�SY	�SY
�SY� �Y� �Y� �Y�SY1SY�SY�SY�SY�SY�SY�S� �SS� ĳ ��           �      � �     !     ��                 � �     (     
� UY/S�           
      � �     "     � ��                     ����  -� 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc 6cfVarScopeChecker2ecfc1846151587$funcRECURSIVEFILELIST  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 8LcfVarScopeChecker2ecfc1846151587$funcRECURSIVEFILELIST; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  	HASFILTER  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   DIRLIST  FILESTORETURN   coldfusion/runtime/CfJspPage " pageContext #Lcoldfusion/runtime/NeoPageContext; $ %	 # & getOut ()Ljavax/servlet/jsp/JspWriter; ( ) javax/servlet/jsp/PageContext +
 , * parent Ljavax/servlet/jsp/tagext/Tag; . /	 # 0 	DIRECTORY 2 string 4 getVariable  (I)Lcoldfusion/runtime/Variable; 6 7 %coldfusion/runtime/ArgumentCollection 9
 : 8 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; < =
  > putVariable  (Lcoldfusion/runtime/Variable;)V @ A
  B get (I)Ljava/lang/Object; D E
 : F FILTER H   J put 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; L M
 : N 

	 P _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V R S
 # T ArrayNew (I)Ljava/util/List; V W coldfusion/runtime/CFPage Y
 Z X set (Ljava/lang/Object;)V \ ] coldfusion/runtime/Variable _
 ` ^ 
	 b 0 d java/lang/String f _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; h i
 # j _String &(Ljava/lang/Object;)Ljava/lang/String; l m coldfusion/runtime/Cast o
 p n Trim &(Ljava/lang/String;)Ljava/lang/String; r s
 Z t Len (Ljava/lang/Object;)I v w
 Z x _Object z E
 p { _compare (Ljava/lang/Object;D)D } ~
 #  (Z)Ljava/lang/Object; z �
 p � 	
	
	
	 � \ � Find '(Ljava/lang/String;Ljava/lang/String;)I � �
 Z � _boolean (Ljava/lang/Object;)Z � �
 p � .*\$ � REFind 9(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Integer; � �
 Z � 
		 � concat � s
 g � _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V � �
 # � / � .*/$ � 

	
	 � 'class$coldfusion$tagext$io$DirectoryTag Ljava/lang/Class; !coldfusion.tagext.io.DirectoryTag � forName %(Ljava/lang/String;)Ljava/lang/Class; � � java/lang/Class �
 � � � �	  � _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; � �
 # � !coldfusion/tagext/io/DirectoryTag � cfdirectory � action � list � _validateTagAttrValue J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; � �
 # � 	setAction (Ljava/lang/String;)V � �
 � � name � dirList � setName � �
 � � 	directory � setDirectory � �
 � � 
doStartTag ()I � �
 � � doAfterBody � � coldfusion/tagext/GenericTag �
 � � doEndTag � � #javax/servlet/jsp/tagext/TagSupport �
 � � $class$coldfusion$tagext$lang$LoopTag coldfusion.tagext.lang.LoopTag � � �	  � coldfusion/tagext/lang/LoopTag � cfloop � query � setQuery � � coldfusion/tagext/QueryLoop �
 � �
 � � TYPE � dir � '(Ljava/lang/Object;Ljava/lang/String;)D } �
 # � 
			 � ArrayAppendArray � _get &(Ljava/lang/String;)Ljava/lang/Object; � �
 # � java/lang/Object � _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object;
 # recursiveFileList NAME 
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object;	

 # .*\. . ListLast 8(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
 Z $ REFindNoCase �
 Z _List $(Ljava/lang/Object;)Ljava/util/List;
 p ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z
 Z 
 � �
 � � doCatch (Ljava/lang/Throwable;)V$%
 �& 	doFinally( 
 �) 
+ metaData Ljava/lang/Object;-.	 / array1 private3 false5 &coldfusion/runtime/AttributeCollection7 
returnType9 access; output= hint? �Accepts an absolute directory path and an optional filter and returns an array of all files matching that filter
		  in the specified directory and its sub-directories.A 
ParametersC REQUIREDE yesG HINTI )An absolute path to the directory to listK ([Ljava/lang/Object;)V M
8N DEFAULTP filterR 4An optional filename extension filter (i.e. '*.cfm')T 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS 	HASFILTER DIRLIST FILESTORETURN 	DIRECTORY FILTER 
directory1 #Lcoldfusion/tagext/io/DirectoryTag; mode1 I loop2  Lcoldfusion/tagext/lang/LoopTag; mode2 t19 t20 Ljava/lang/Throwable; t21 t22 LineNumberTable java/lang/Throwable{ <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �    � �   -.   	        #     *� 
�                VW     "     6�                XW     "     2�                YW     "     �                Z[    Z    +� :+,� :	+� :
+� :+!� :-� '� -:-� 1:*35� ;� ?:+� C� G� IK� OW*I5� ;� ?:+� C-Q� U-� [� a-c� Ue� a-c� U
-� gYIS� k� q� u� y� |� ��t|� �� a-�� U�-� gY3S� k� q� �� |Y� �� #W�-� gY3S� k� q� �� ��� �� �� <-�� U-� gY3S-� gY3S� k� q�� �� �-c� U� ��-� gY3S� k� q� �� |Y� �� #W�-� gY3S� k� q� �� ��� �� �� 9-�� U-� gY3S-� gY3S� k� q�� �� �-c� U-�� U-� �� �� �:���� �� ���ȸ �� ���-� gY3S� k� q� �� �� �Y6� � ٚ��� �� �-c� U-� �� �� �:��ȸ �� �� �Y6�S-�� U-� gY�S� k� ��� �-�� U-�� ��-� Y-�SY-� �-� Y-� gY3S� k� q-� gYS� k� q� �SY-� gYIS� kS�S�� a-�� U� �-
�� ��� �Y� �� >W-� gYIS� k� q�� �� �-� gYS� k� q�� �� I-�� U--��-� gY3S� k� q-� gYS� k� q� ��!W-�� U-c� U�"����#� :� #�� � #:�'� � :� �:�*�-c� U-��-,� U� k��|k��       �         \]   ^.   _`   ab   cd   e.    . /   fg   hg 	  ig 
  jg   kg   lg   mg   no   pq   rs   tq   u.   vw   xw   y. z  2 �    K _ Q K | � � � � � �	 �	 �	 �	 �
 �
 �
 �
 �
 �
 �
 �
 �
 �
 � � � � � � � � � � � � �!55G55))OZ\\ZZ|~~||||Z���������Z ����Fcv~����������������033E3300N00TT00py y � � � � � � x x x � ~�!N�"##"# }          ��� �� �� �� �8Y� Y�SYSY:SY2SY<SY4SY>SY6SY@SY	BSY
DSY� Y�8Y� Y�SY5SYFSYHSYSY�SYJSYLS�OSY�8Y� Y�SY5SYQSYKSYSYSSYJSYUS�OSS�O�0�           �     ~W     "     4�                �     -     � gY3SYIS�                ��     "     �0�                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc 4cfVarScopeChecker2ecfc1846151587$funcGETFUNCTIONBODY  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 6LcfVarScopeChecker2ecfc1846151587$funcGETFUNCTIONBODY; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  LOCAL  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;   !	  " getOut ()Ljavax/servlet/jsp/JspWriter; $ % javax/servlet/jsp/PageContext '
 ( & parent Ljavax/servlet/jsp/tagext/Tag; * +	  , WHOLEFUNCTION . string 0 getVariable  (I)Lcoldfusion/runtime/Variable; 2 3 %coldfusion/runtime/ArgumentCollection 5
 6 4 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 8 9
  : putVariable  (Lcoldfusion/runtime/Variable;)V < =
  > 

	 @ _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V B C
  D 	StructNew !()Lcoldfusion/util/FastHashtable; F G coldfusion/runtime/CFPage I
 J H set (Ljava/lang/Object;)V L M coldfusion/runtime/Variable O
 P N 
	 R java/lang/String T FUNCTIONBODY V _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; X Y
  Z _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V \ ]
  ^ ReplaceInStringLiterals ` _get &(Ljava/lang/String;)Ljava/lang/Object; b c
  d java/lang/Object f > h %GT_PLACEHOLDER% j 
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object; l m
  n 	BODYMATCH p(?x)
			<cffunction[^>]*>								# match the opening function tag		
			([[:space:]]*<cfargument[^>]*>[[:space:]]*)*	# match any number of optional arguments
			(.*?)											# this is the function body (the 2nd subexpression match)
			</cffunction>									# close the function tag
			 r _String &(Ljava/lang/Object;)Ljava/lang/String; t u coldfusion/runtime/Cast w
 x v REFindNoCase :(Ljava/lang/String;Ljava/lang/String;IZ)Ljava/lang/Object; z {
 J | LEN ~ ArrayLen (Ljava/lang/Object;)I � �
 J � _Object (I)Ljava/lang/Object; � �
 x �@       _compare (Ljava/lang/Object;D)D � �
  � 
		 � POS � _resolve � Y
  � 3 � _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; � �
  � _int � �
 x � Mid ((Ljava/lang/String;II)Ljava/lang/String; � �
 J � 
	
	 � 
 � getFunctionBody � metaData Ljava/lang/Object; � �	  � private � false � &coldfusion/runtime/AttributeCollection � name � 
returnType � access � output � hint �Accepts a string that contains a CF function declaration and returns a string of just the function body, which is everything
		  after the last argument declaration and before the closing cffunction tag.  Returns the input string if the function tags aren't found. � 
Parameters � TYPE � REQUIRED � yes � NAME � wholeFunction � HINT � #The function declaration to analyze � ([Ljava/lang/Object;)V  �
 � � 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LOCAL WHOLEFUNCTION LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                 � �     !     ��                 � �     !     1�                 � �     !     ��                 � �    �    �+� :+,� :	+� :
-� #� ):-� -:*/1� 7� ;:+� ?-A� E
� K� Q-S� E-
� UYWS-� UY/S� [� _-S� E-
� UY/S-a� ea-� gY-� UY/S� [SYiSYkS� o� _-A� E-
� UYqSs-
� UY/S� [� y� }� _-A� E-
� UYqSYS� [� �� � �� ��� �-�� E-
� UYWS-
� UY/S� [� y-
� UYqSY�S� ��� �� �-
� UYqSYS� ��� �� �� �� _-�� E-
� UYWS-a� ea-� gY-
� UYWS� [SYkSYiS� o� _-S� E-�� E-
� UYWS� [�-�� E�       z   �      � � �   � � �   � � �   � � �   � � �   � � �   � * +   � � �   � � � 	  � � � 
  � � �  �   C   � ; � ; � A � K � I � I � Q � e � e � Y � Y � w � � � � � � � � � � � � �  �  � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �+ �+ �= �Q �= �= �Y �m �Y �Y �+ �+ � � �{ �� �� �� �� �� �� �� �� �� � � �� �� �� �� �� �  �      �     �� �Y� gY�SY�SY�SY1SY�SY�SY�SY�SY�SY	�SY
�SY� gY� �Y� gY�SY1SY�SY�SY�SY�SY�SY�S� �SS� г ��           �      � �     !     ��                 � �     (     
� UY/S�           
      � �     "     � ��                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc 8cfVarScopeChecker2ecfc1846151587$funcISABSOLUTEDIRECTORY  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this :LcfVarScopeChecker2ecfc1846151587$funcISABSOLUTEDIRECTORY; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' PATH ) string + getVariable  (I)Lcoldfusion/runtime/Variable; - . %coldfusion/runtime/ArgumentCollection 0
 1 / _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 3 4
  5 putVariable  (Lcoldfusion/runtime/Variable;)V 7 8
  9 

	 ; _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V = >
  ? java/lang/String A _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; C D
  E _String &(Ljava/lang/Object;)Ljava/lang/String; G H coldfusion/runtime/Cast J
 K I DirectoryExists (Ljava/lang/String;)Z M N coldfusion/runtime/CFPage P
 Q O _Object (Z)Ljava/lang/Object; S T
 K U 
 W isAbsoluteDirectory Y metaData Ljava/lang/Object; [ \	  ] boolean _ private a false c &coldfusion/runtime/AttributeCollection e java/lang/Object g name i 
returnType k access m output o hint q lAccepts a string and returns TRUE if it represents a valid, absolute path to a directory or FALSE otherwise. s 
Parameters u TYPE w REQUIRED y yes { NAME } path  HINT � The string to test � ([Ljava/lang/Object;)V  �
 f � 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS PATH LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       [ \   	        #     *� 
�                 � �     !     d�                 � �     !     `�                 � �     !     Z�                 � �         e+� :+,� :	-� � $:-� (:**,� 2� 6:
+
� :-<� @--� BY*S� F� L� R� V�-X� @�       p    e       e � �    e � \    e � �    e � �    e � �    e � \    e % &    e � �    e � � 	   e � � 
 �   * 
  � 3� 3� 9� B� B� A� A� A� [�  �      �     �� fY� hYjSYZSYlSY`SYnSYbSYpSYdSYrSY	tSY
vSY� hY� fY� hYxSY,SYzSY|SY~SY�SY�SY�S� �SS� �� ^�           �      � �     !     b�                 � �     (     
� BY*S�           
      � �     "     � ^�                     ����  -@ 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc :cfVarScopeChecker2ecfc1846151587$funcGETVARIABLESSETINBODY  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this <LcfVarScopeChecker2ecfc1846151587$funcGETVARIABLESSETINBODY; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  LOCAL  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;   !	  " getOut ()Ljavax/servlet/jsp/JspWriter; $ % javax/servlet/jsp/PageContext '
 ( & parent Ljavax/servlet/jsp/tagext/Tag; * +	  , WHOLEFUNCTION . string 0 getVariable  (I)Lcoldfusion/runtime/Variable; 2 3 %coldfusion/runtime/ArgumentCollection 5
 6 4 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 8 9
  : putVariable  (Lcoldfusion/runtime/Variable;)V < =
  > 

	 @ _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V B C
  D 	StructNew !()Lcoldfusion/util/FastHashtable; F G coldfusion/runtime/CFPage I
 J H set (Ljava/lang/Object;)V L M coldfusion/runtime/Variable O
 P N 
	 R java/lang/String T VARS V ArrayNew (I)Ljava/util/List; X Y
 J Z _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V \ ]
  ^ 	
	
	
	 ` BODY b getFunctionBody d _get &(Ljava/lang/String;)Ljava/lang/Object; f g
  h java/lang/Object j _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; l m
  n 
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object; p q
  r 
VARSECTION t getVarSection v _String &(Ljava/lang/Object;)Ljava/lang/String; x y coldfusion/runtime/Cast {
 | z Trim &(Ljava/lang/String;)Ljava/lang/String; ~ 
 J � Len (Ljava/lang/Object;)I � �
 J � _Object (I)Ljava/lang/Object; � �
 | � _compare (Ljava/lang/Object;D)D � �
  � 
		 �   � Replace J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; � �
 J � STARTAT � 1 � $#local.startAt# LT #Len(local.body)# � prepareCondition � g
 J � 
VARMATCHES � 5<cfdirectory[^>]*name="([a-zA-Z0-9_\.\[\]"']+)"[^>]*> � _int � �
 | � REFindNoCase :(Ljava/lang/String;Ljava/lang/String;IZ)Ljava/lang/Object; � �
 J � LEN � ArrayLen � �
 J �@        
			 � _List $(Ljava/lang/Object;)Ljava/util/List; � �
 | � POS � _resolve � m
  � 2 � _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; � �
  � Mid ((Ljava/lang/String;II)Ljava/lang/String; � �
 J � ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z � �
 J � _double (Ljava/lang/Object;)D � �
 | � (D)Ljava/lang/Object; � �
 | � CFLOOP � checkRequestTimeout (Ljava/lang/String;)V � �
  � evaluateCondition (Ljava/lang/Object;)Z � �
 J � 

	
	 � 4<cffile[^>]*variable="([a-zA-Z0-9_\.\[\]"']+)"[^>]*> � 1<cfloop[^>]*index="([a-zA-Z0-9_\.\[\]"']+)"[^>]*> � 1<cfparam[^>]*name="([a-zA-Z0-9_\.\[\]"']+)"[^>]*> � /<cfpop[^>]*name="([a-zA-Z0-9_\.\[\]"']+)"[^>]*> � 1<cfquery[^>]*name="([a-zA-Z0-9_\.\[\]"']+)"[^>]*> � ;<cfsavecontent[^>]*variable="([a-zA-Z0-9_\.\[\]"']+)"[^>]*> � 6<cfset[[:space:]]+([a-zA-Z0-9_\.\[\]"']+)[[:space:]]*= � 
	
	 � 
 � getVariablesSetInBody � metaData Ljava/lang/Object; � �	  � array � private � false � &coldfusion/runtime/AttributeCollection � name � 
returnType � access output hint �Accepts a string that contains a CF function declaration and returns an array of all variables declared using 
		 cfdirectory, cffile, cfloop, cfparam, cfpop, cfquery, cfsavecontent and cfset. 
Parameters	 TYPE REQUIRED yes NAME wholeFunction HINT The function to analyze ([Ljava/lang/Object;)V 
 � 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LOCAL WHOLEFUNCTION t12 t13 t14 t15 t16 t17 t18 t19 LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                     !     ��                     !     ��                     !     �                 !    @    �+� :+,� :	+� :
-� #� ):-� -:*/1� 7� ;:+� ?-A� E
� K� Q-S� E-
� UYWS-� [� _-a� E-
� UYcS-e� ie-� kY-� UY/S� oS� s� _-S� E-
� UYuS-w� iw-� kY-
� UYcS� oS� s� _-S� E-
� UYuS� o� }� �� �� �� ��� ^-�� E-
� UYcS-
� UYcS� o� }-w� iw-� kY-
� UYcS� oS� s� }�� �� _-S� E-a� E-
� UY�S�� _-S� E�� �:�[-�� E-
� UY�S�-
� UYcS� o� }-
� UY�S� o� �� �� _-�� E-
� UY�SY�S� o� �� � �� ��� -�� E� �-�� E� �-�� E--
� UYWS� o� �-
� UYcS� o� }-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �� Ŷ �W-�� E-
� UY�S-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �c� ж _-�� E-S� EҸ �-� ښ��-ܶ E-
� UY�S�� _-S� E�� �:�[-�� E-
� UY�S�-
� UYcS� o� }-
� UY�S� o� �� �� _-�� E-
� UY�SY�S� o� �� � �� ��� -�� E� �-�� E� �-�� E--
� UYWS� o� �-
� UYcS� o� }-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �� Ŷ �W-�� E-
� UY�S-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �c� ж _-�� E-S� EҸ �-� ښ��-ܶ E-
� UY�S�� _-S� E�� �:�[-�� E-
� UY�S�-
� UYcS� o� }-
� UY�S� o� �� �� _-�� E-
� UY�SY�S� o� �� � �� ��� -�� E� �-�� E� �-�� E--
� UYWS� o� �-
� UYcS� o� }-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �� Ŷ �W-�� E-
� UY�S-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �c� ж _-�� E-S� EҸ �-� ښ��-ܶ E-
� UY�S�� _-S� E�� �:�[-�� E-
� UY�S�-
� UYcS� o� }-
� UY�S� o� �� �� _-�� E-
� UY�SY�S� o� �� � �� ��� -�� E� �-�� E� �-�� E--
� UYWS� o� �-
� UYcS� o� }-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �� Ŷ �W-�� E-
� UY�S-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �c� ж _-�� E-S� EҸ �-� ښ��-ܶ E-
� UY�S�� _-S� E�� �:�[-�� E-
� UY�S�-
� UYcS� o� }-
� UY�S� o� �� �� _-�� E-
� UY�SY�S� o� �� � �� ��� -�� E� �-�� E� �-�� E--
� UYWS� o� �-
� UYcS� o� }-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �� Ŷ �W-�� E-
� UY�S-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �c� ж _-�� E-S� EҸ �-� ښ��-ܶ E-
� UY�S�� _-S� E�� �:�[-�� E-
� UY�S�-
� UYcS� o� }-
� UY�S� o� �� �� _-�� E-
� UY�SY�S� o� �� � �� ��� -�� E� �-�� E� �-�� E--
� UYWS� o� �-
� UYcS� o� }-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �� Ŷ �W-�� E-
� UY�S-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �c� ж _-�� E-S� EҸ �-� ښ��-ܶ E-
� UY�S�� _-S� E�� �:�[-�� E-
� UY�S�-
� UYcS� o� }-
� UY�S� o� �� �� _-�� E-
� UY�SY�S� o� �� � �� ��� -�� E� �-�� E� �-�� E--
� UYWS� o� �-
� UYcS� o� }-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �� Ŷ �W-�� E-
� UY�S-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �c� ж _-�� E-S� EҸ �-� ښ��-ܶ E-
� UY�S�� _-S� E�� �:�[-�� E-
� UY�S�-
� UYcS� o� }-
� UY�S� o� �� �� _-�� E-
� UY�SY�S� o� �� � �� ��� -�� E� �-�� E� �-�� E--
� UYWS� o� �-
� UYcS� o� }-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �� Ŷ �W-�� E-
� UY�S-
� UY�SY�S� ��� �� �-
� UY�SY�S� ��� �� �c� ж _-�� E-S� EҸ �-� ښ��-� E-
� UYWS� o�-� E�       �   �      �"#   �$ �   �%&   �'(   �)*   �+ �   � * +   �,-   �.- 	  �/- 
  �0-   �1 �   �2 �   �3 �   �4 �   �5 �   �6 �   �7 �   �8 � 9  v  H ;K ;K AM KO IO IO QO fP eP eP YP YP mP �S �S �S �S uS uS �S �T �T �T �T �T �T �T �U �U �U �U �UUUVV1V@V1V1VVVVVVV^V �UfWzZzZnZnZZ�[�\�\�\�\�\�\�\�\�\�\�\�]�]�]�]�]^
^_``0`0`B`V`B`B`^`r`^`^`0`0````�`�a�a�a�a�a�a�a�a�a�a�a�a�a_�]�b�[�cff�f�ffg1h3h3hEhEhWh1h1h%h%h^hfififi�i�i�j�j�k�l�l�l�l�l�l�l�l�l�l�l�l�l�l�l�l�ll!m5m!m!m=mQm=m=m!m!mmm`m�kfihng~o�r�r�r�r�r�s�t�t�t�t�t�t�t�t�t�t�t�u�u�uuuv"v-w6x6xHxHxZxnxZxZxvx�xvxvxHxHx5x5x5x�x�y�y�y�y�y�y�y�y�y�y�y�y�y-w�u�z�s
{~~~~#~5I�K�K�]�]�o�I�I�=�=�v�~�~�~�����������������������������������������%�9�M�9�9�U�i�U�U�9�9�-�-�x���~���+�����������������������������������
�
�
�$�/�7�:�E�N�N�`�`�r���r�r���������`�`�M�M�M���������������������������	�E�
�	���	"�	6�	6�	*�	*�	;�	M�	a�	c�	c�	u�	u�	��	a�	a�	U�	U�	��	��	��	��	��	��	��	��	��	��	��	��	��	��
�	��	��
�
.�
�
�	��	��	��	��	��
=�
Q�
e�
Q�
Q�
m�
��
m�
m�
Q�
Q�
E�
E�
��	��	��
��	C�
��
��
��
��
��
��
��
��
��
�����
��
��
��
���"�"�"�<�G�O�R�]�f�f�x�x�����������������x�x�e�e�e���������������������������]�"�$�
��:�N�N�B�B�S�e�y�{�{�������y�y�m�m��������������������������*���2�F�2�2���������U�i�}�i�i���������i�i�]�]���������[����������� :      �     �� �Y� kY�SY�SY SY�SYSY�SYSY�SYSY	SY

SY� kY� �Y� kYSY1SYSYSYSYSYSYS�SS�� ��           �     ;     !     ��                <=     (     
� UY/S�           
     >?     "     � ��                     ����  -( 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc <cfVarScopeChecker2ecfc1846151587$funcREPLACEINSTRINGLITERALS  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this >LcfVarScopeChecker2ecfc1846151587$funcREPLACEINSTRINGLITERALS; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  LOCAL  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;   !	  " getOut ()Ljavax/servlet/jsp/JspWriter; $ % javax/servlet/jsp/PageContext '
 ( & parent Ljavax/servlet/jsp/tagext/Tag; * +	  , STRING . string 0 getVariable  (I)Lcoldfusion/runtime/Variable; 2 3 %coldfusion/runtime/ArgumentCollection 5
 6 4 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 8 9
  : putVariable  (Lcoldfusion/runtime/Variable;)V < =
  > REPLACESTRING @ 
WITHSTRING B 

	 D _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V F G
  H 	StructNew !()Lcoldfusion/util/FastHashtable; J K coldfusion/runtime/CFPage M
 N L set (Ljava/lang/Object;)V P Q coldfusion/runtime/Variable S
 T R 
	 V java/lang/String X 	NEWSTRING Z   \ _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V ^ _
  ` 	
	
	
	 b REMAININGTEXT d _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; f g
  h #Len(local.remainingText)# GT 0 j prepareCondition &(Ljava/lang/String;)Ljava/lang/Object; l m
 N n 
		 p MATCHES r ^[^"]*"[^"]*" t _String &(Ljava/lang/Object;)Ljava/lang/String; v w coldfusion/runtime/Cast y
 z x REFindNoCase :(Ljava/lang/String;Ljava/lang/String;IZ)Ljava/lang/Object; | }
 N ~ 
		
		 � LEN � _resolve � g
  � 1 � _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; � �
  � _compare (Ljava/lang/Object;D)D � �
  � 

			
			 � concat &(Ljava/lang/String;)Ljava/lang/String; � �
 Y � 
			 � 	THISMATCH � _int (Ljava/lang/Object;)I � �
 z � Left '(Ljava/lang/String;I)Ljava/lang/String; � �
 N � LEADINGCHARS � 
^(.*)".*"$ � \1 � REReplaceNoCase J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; � �
 N � STRINGLITERALONLY � 
^.*"(.*)"$ � POSTREPLACE � " � ALL � Replace \(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; � �
 N � Len � �
 N � _double (Ljava/lang/Object;)D � �
 z � (D)I � �
 z � Right � �
 N � CFLOOP � checkRequestTimeout (Ljava/lang/String;)V � �
  � evaluateCondition (Ljava/lang/Object;)Z � �
 N � 
	
	 � 
 � replaceInStringLiterals � metaData Ljava/lang/Object; � �	  � private � false � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returnType � access � output � hint � �Replaces all occurances of a given string with another, but only if that string is found within a string literal (i.e. between double or single quotes) � 
Parameters � TYPE � REQUIRED � yes � NAME � HINT � The string to search � ([Ljava/lang/Object;)V  �
 � � replaceString <The string to replace (if it occurs within a string literal) 
withString The string to replace with 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LOCAL STRING REPLACESTRING 
WITHSTRING t14 LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                	
     !     ߰                
     !     1�                
     !     װ                    :    t+� :+,� :	+� :
-� #� ):-� -:*/1� 7� ;:+� ?*A1� 7� ;:+� ?*C1� 7� ;:+� ?-E� I
� O� U-W� I-
� YY[S]� a-c� I-
� YYeS-� YY/S� i� a-W� Ik� o:�|-q� I-
� YYsSu-
� YYeS� i� {� � a-�� I-
� YYsSY�S� ��� �� ��� W-�� I-
� YY[S-
� YY[S� i� {-
� YYeS� i� {� �� a-�� I��-q� I��-�� I-
� YY�S-
� YYeS� i� {-
� YYsSY�S� ��� �� �� �� a-�� I-
� YY�S-
� YY�S� i� {��� �� a-�� I-
� YY�S-
� YY�S� i� {��� �� a-�� I-
� YY�S-
� YY�S� i� {�� �-
� YY�S� i� {-� YYAS� i� {-� YYCS� i� {�� �� ��� �� a-�� I-
� YY[S-
� YY[S� i� {-
� YY�S� i� {� �� a-�� I-
� YYeS-
� YYeS� i� {-
� YYeS� i� ��-
� YYsSY�S� ��� �� �g� ĸ Ƕ a-q� I-W� Iɸ �-� њ��-Ӷ I-
� YY[S� i�-ն I�       �   t      t   t �   t   t   t   t �   t * +   t   t 	  t 
  t   t   t   t  � !   �   ; R i ; o y! w! w! ! �" �" �" �" �" �* �* �* �* �* �+ �, �, �, �, �, �, �, �, �, ,..!.*.>0>0P0P0>0>02020h0p1s1~2�7�7�7�7�7�7�7�7�7�7�7�8�8�8�8�8�8�8�8�8
9
999
9
9�9�9&9::::L:::::Q:Q:c:c:u:u:�:Q:Q:::::�:::::.:.:�:�;�;�;�;�;�;�;�;�;�<�<�<�<�<�<<"<<<�<�<�<�<�<�<4<~2.<= �+R>Z@Z@Z>j@ "     !    � �Y� �Y�SY�SY�SY1SY�SY�SY�SY�SY�SY	�SY
�SY� �Y� �Y� �Y�SY1SY�SY�SY�SY1SY�SY�S� SY� �Y� �Y�SY1SY�SY�SY�SYSY�SYS� SY� �Y� �Y�SY1SY�SY�SY�SYSY�SYS� SS� � ۱               #
     !     ݰ                $%     2     � YY/SYASYCS�                &'     "     � ۰                     ����  -6 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\VarScopeChecker.cfc 2cfVarScopeChecker2ecfc1846151587$funcGETVARSECTION  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 4LcfVarScopeChecker2ecfc1846151587$funcGETVARSECTION; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  	RECOMMENT  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   LOCAL  coldfusion/runtime/CfJspPage   pageContext #Lcoldfusion/runtime/NeoPageContext; " #	 ! $ getOut ()Ljavax/servlet/jsp/JspWriter; & ' javax/servlet/jsp/PageContext )
 * ( parent Ljavax/servlet/jsp/tagext/Tag; , -	 ! . WHOLEFUNCTION 0 string 2 getVariable  (I)Lcoldfusion/runtime/Variable; 4 5 %coldfusion/runtime/ArgumentCollection 7
 8 6 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; : ;
  < putVariable  (Lcoldfusion/runtime/Variable;)V > ?
  @ 

	 B _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V D E
 ! F 	StructNew !()Lcoldfusion/util/FastHashtable; H I coldfusion/runtime/CFPage K
 L J set (Ljava/lang/Object;)V N O coldfusion/runtime/Variable Q
 R P 
	 T (<!---.*?--->) V java/lang/String X 
VARSECTION Z   \ _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V ^ _
 ! ` 	
	
	
	 b BODY d getFunctionBody f _get &(Ljava/lang/String;)Ljava/lang/Object; h i
 ! j java/lang/Object l _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; n o
 ! p 
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object; r s
 ! t 
	
	 v REMAININGTEXT x ReplaceInStringLiterals z > | %GT_PLACEHOLDER% ~ #Len(local.remainingText)# GT 0 � prepareCondition � i
 L � 
		
		 � MATCHES � java/lang/StringBuffer � ^[[:space:]]* � (Ljava/lang/String;)V  �
 � � _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; � �
 ! � _String &(Ljava/lang/Object;)Ljava/lang/String; � � coldfusion/runtime/Cast �
 � � append ,(Ljava/lang/String;)Ljava/lang/StringBuffer; � �
 � � )*[[:space:]]*<cfset var [a-zA-Z0-9_\.\[\] � " � ']+[[:space:]]*=[^>]+> � toString ()Ljava/lang/String; � �
 m � REFindNoCase :(Ljava/lang/String;Ljava/lang/String;IZ)Ljava/lang/Object; � �
 L � LEN � _resolve � o
 ! � 1 � _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; � �
 ! � _compare (Ljava/lang/Object;D)D � �
 ! � 
			 � 
		 � _int (Ljava/lang/Object;)I � �
 � � Left '(Ljava/lang/String;I)Ljava/lang/String; � �
 L � concat &(Ljava/lang/String;)Ljava/lang/String; � �
 Y � Len � �
 L � _Object (I)Ljava/lang/Object; � �
 � � '(Ljava/lang/Object;Ljava/lang/Object;)D � �
 ! � 
				
				 � 
				 � _double (Ljava/lang/Object;)D � �
 � � (D)I � �
 � � Right � �
 L � CFLOOP � checkRequestTimeout � �
 ! � evaluateCondition (Ljava/lang/Object;)Z � �
 L � 
 � getVarSection � metaData Ljava/lang/Object; � �	  � private � false � &coldfusion/runtime/AttributeCollection � name � 
returnType � access � output  hint vAccepts a string that contains a CF function declaration and returns a string of just the local variable declarations. 
Parameters TYPE REQUIRED
 yes NAME wholeFunction HINT #The function declaration to analyze ([Ljava/lang/Object;)V 
 � 	getOutput getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS 	RECOMMENT LOCAL WHOLEFUNCTION t13 LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �   	        #     *� 
�                 �     !     ��                 �     !     3�                 �     !     �                    �    C+� :+,� :	+� :
+� :-� %� +:-� /:*13� 9� =:+� A-C� G� M� S-U� G
W� S-U� G-� YY[S]� a-c� G-� YYeS-g� kg-� mY-� YY1S� qS� u� a-w� G-� YYyS-{� k{-� mY-� YYeS� qSY}SYS� u� a-U� G�� �:��-�� G-� YY�S� �Y�� �-
� �� �� ��� ��� ��� �� �-� YYyS� q� �� �� a-�� G-� YY�SY�S� ��� �� ��� -�� G�H-�� G�'-�� G-� YY[S-� YY[S� q� �-� YYyS� q� �-� YY�SY�S� ��� �� ¸ ƶ ʶ a-�� G-� YYyS� q� ͸ �-� YY�SY�S� ��� �� ��~�� -ֶ G� �-�� G� j-ض G-� YYyS-� YYyS� q� �-� YYyS� q� ͇-� YY�SY�S� ��� �� �g� ߸ � a-�� G-�� G-U� G� �-� ��4-U� G-� YY[S-{� k{-� mY-� YY[S� qSYSY}S� u� a-w� G-� YY[S� q�-�� G�       �   C      C   C  �   C!"   C#$   C%&   C' �   C , -   C()   C*) 	  C+) 
  C,)   C-)   C. � /  � y   � C � C � I � S � Q � Q � Y � c � a � a � h � | � | � p � p � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �' �, �, �8 �= �B �# �# �J �J �\ �] �# �# � � �d �l �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� � �	 �	 �	 � �2 �	 �C �K �N �Y �m �m � � � � �� �� �� �� � � �m �m �a �a �� �Y �	 �� �� �l �� � �� �� � � � �� �� �� �� �! �) �) �) �9 � 0      �     �� �Y� mY�SY�SY�SY3SY�SY�SYSY�SYSY	SY
SY� mY� �Y� mY	SY3SYSYSYSYSYSYS�SS�� �           �     1 �     !     ��                23     (     
� YY1S�           
     45     "     � �                     