����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\MockObject.cfc #cfMockObject2ecfc989107402$funcINIT  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this %LcfMockObject2ecfc989107402$funcINIT; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  MOCKOBJECTMETADATA  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   
MOCKOBJECT  coldfusion/runtime/CfJspPage   pageContext #Lcoldfusion/runtime/NeoPageContext; " #	 ! $ getOut ()Ljavax/servlet/jsp/JspWriter; & ' javax/servlet/jsp/PageContext )
 * ( parent Ljavax/servlet/jsp/tagext/Tag; , -	 ! . 	COMPONENT 0 string 2 getVariable  (I)Lcoldfusion/runtime/Variable; 4 5 %coldfusion/runtime/ArgumentCollection 7
 8 6 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; : ;
  < putVariable  (Lcoldfusion/runtime/Variable;)V > ?
  @ 	
		
		
		 B _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V D E
 ! F _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; H I
 ! J set (Ljava/lang/Object;)V L M coldfusion/runtime/Variable O
 P N 
		 R GetMetaData &(Ljava/lang/Object;)Ljava/lang/Object; T U
 ! V 
		
		 X java/lang/String Z MOCKREQUESTS \ 	StructNew !()Lcoldfusion/util/FastHashtable; ^ _ coldfusion/runtime/CFPage a
 b ` _structSetAt E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V d e
 ! f MOCKRETURNS h CFUNITPACKAGE j NAME l _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; n o
 ! p _String &(Ljava/lang/Object;)Ljava/lang/String; r s coldfusion/runtime/Cast u
 v t . x ListLen '(Ljava/lang/String;Ljava/lang/String;)I z {
 b | ListDeleteAt 9(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String; ~ 
 b � 
CFUNITPATH � PATH � \ � 	component � CreateObject 8(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object; � �
 b � _Map #(Ljava/lang/Object;)Ljava/util/Map; � �
 v � StructAppend "(Ljava/util/Map;Ljava/util/Map;Z)Z � �
 b � 
	 � init � metaData Ljava/lang/Object; � �	  � any � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returntype � hint � �The initialization process (constructor) of the mock object. This will NOT in turn initialize the mocked object; if needed that must be done separately by the calling page. � 
Parameters � TYPE � REQUIRED � yes � HINT � 6The name of the component to create a mock object for. � ([Ljava/lang/Object;)V  �
 � � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS MOCKOBJECTMETADATA 
MOCKOBJECT 	COMPONENT LineNumberTable <clinit> getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �           #     *� 
�                 � �     !     ��                 � �     !     ��                 � �    G 
   �+� :+,� :	+� :
+� :-� %� +:-� /:*13� 9� =:+� A-C� G-	� K� Q-S� G
-� K� W� Q-Y� G-	� [Y]S� c� g-S� G-	� [YiS� c� g-Y� G-	� [YkS-
� [YmS� q� w-
� [YmS� q� wy� }y� �� g-S� G-	� [Y�S-
� [Y�S� q� w-
� [Y�S� q� w�� }�� �� g-C� G	-�-� [Y1S� q� w� �� Q-C� G-	� K� �-� K� �� �W-C� G-	� K�-�� G�       �   �      � � �   � � �   � � �   � � �   � � �   � � �   � , -   � � �   � � � 	  � � � 
  � � �   � � �  �   G   	 C 
 C 
 I  S  Q  Q  \  f  f  f  d  d  r  �  �  z  z  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �   #   (  �  �  �  � 0 ; = = : : 8 8 U ] ] f f o ] ] ] t | | | �   �      �     u� �Y� �Y�SY�SY�SY�SY�SY�SY�SY� �Y� �Y� �Y�SY3SY�SY�SYmSY�SY�SY�S� �SS� �� ��           u      � �     (     
� [Y1S�           
      � �     "     � ��                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\MockObject.cfc (cfMockObject2ecfc989107402$funcADDRESULT  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this *LcfMockObject2ecfc989107402$funcADDRESULT; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' NAME ) string + getVariable  (I)Lcoldfusion/runtime/Variable; - . %coldfusion/runtime/ArgumentCollection 0
 1 / _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 3 4
  5 putVariable  (Lcoldfusion/runtime/Variable;)V 7 8
  9 
MOCKRETURN ; any = 
		
		 ? _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V A B
  C _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; E F
  G _Map #(Ljava/lang/Object;)Ljava/util/Map; I J coldfusion/runtime/Cast L
 M K 
mockReturn O StructKeyExists $(Ljava/util/Map;Ljava/lang/String;)Z Q R coldfusion/runtime/CFPage T
 U S 
			 W java/lang/String Y MOCKRETURNS [ _resolve D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; ] ^
  _ _resolveAndAutoscalarize a ^
  b _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; d e
  f _List $(Ljava/lang/Object;)Ljava/util/List; h i
 M j ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z l m
 U n 
		 p 
	 r 	addResult t metaData Ljava/lang/Object; v w	  x void z public | &coldfusion/runtime/AttributeCollection ~ java/lang/Object � name � access � 
returntype � hint �Adds a result to the list of responses for a method. You can add more then one result per method. The result will be cycled through in the order they were added. After the last result is returned the cycle will reset and the next result returned will be the first reposnce again. � 
Parameters � TYPE � REQUIRED � yes � HINT � .The name of the method to add the responce to. � ([Ljava/lang/Object;)V  �
  � false � +The result to add to the list of responces. � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS NAME 
MOCKRETURN LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       v w           #     *� 
�                 � �     !     {�                 � �     !     u�                 � �    �     �+� :+,� :	-� � $:-� (:**,� 2� 6:
+
� :*<>� 2� 6:+� :-@� D--� H� NP� V� K-X� D--	� ZY\S� `-� ZY*S� c� g� k-� ZY<S� c� oW-q� D-s� D�       z    �       � � �    � � w    � � �    � � �    � � �    � � w    � % &    � � �    � � � 	   � � � 
   � � �  �   Z    B 3 D J E 3 D P F Y H Y H b H X H j H s I � I s I s I � I � I r I r I r I � I X H � J  �      �     �� Y
� �Y�SYuSY�SY}SY�SY{SY�SY�SY�SY	� �Y� Y� �Y�SY,SY�SY�SY*SY�SY�SY�S� �SY� Y� �Y�SY>SY�SY�SY*SYPSY�SY�S� �SS� �� y�           �      � �     !     }�                 � �     -     � ZY*SY<S�                 � �     "     � y�                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\MockObject.cfc /cfMockObject2ecfc989107402$funcOVERRIDEFUNCTION  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 1LcfMockObject2ecfc989107402$funcOVERRIDEFUNCTION; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' NAME ) string + getVariable  (I)Lcoldfusion/runtime/Variable; - . %coldfusion/runtime/ArgumentCollection 0
 1 / _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 3 4
  5 putVariable  (Lcoldfusion/runtime/Variable;)V 7 8
  9 
MOCKRETURN ; any = 
				
		 ? _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V A B
  C 	VARIABLES E java/lang/Object G java/lang/String I _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; K L
  M _get 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; O P
  Q createFunctionStub S _invoke K(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object; U V
  W _arraySetAt :(Ljava/lang/String;[Ljava/lang/Object;Ljava/lang/Object;)V Y Z
  [ 
		 ] _arrayGetAt 8(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object; _ `
  a E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V Y c
  d 
		
		 f MOCKRETURNS h _LhsResolve j L
  k ArrayNew (I)Ljava/util/List; m n coldfusion/runtime/CFPage p
 q o :(Ljava/lang/Object;[Ljava/lang/Object;Ljava/lang/Object;)V Y s
  t 	
		 v MOCKREQUESTS x _autoscalarize z P
  { _Map #(Ljava/lang/Object;)Ljava/util/Map; } ~ coldfusion/runtime/Cast �
 �  
mockReturn � StructKeyExists $(Ljava/util/Map;Ljava/lang/String;)Z � �
 q � 
			 � _resolve � L
  � 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; _ �
  � _List $(Ljava/lang/Object;)Ljava/util/List; � �
 � � ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z � �
 q � 
	 � overrideFunction � metaData Ljava/lang/Object; � �	  � void � public � &coldfusion/runtime/AttributeCollection � name � access � 
returntype � hint �.This will override the native function of the mock object with one that will have no effect. Each request to the over ridden method will be recorded (see: getRequest). By default the response of this method will be a blank string, but this can be changed to returns a specific response (see: addResult) � 
Parameters � TYPE � REQUIRED � yes � HINT � #The name of the method to over ride � ([Ljava/lang/Object;)V  �
 � � false � NOptionally, the result the over ridden method should return when it is called. � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS NAME 
MOCKRETURN LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �           #     *� 
�                 � �     !     ��                 � �     !     ��                 � �        �+� :+,� :	-� � $:-� (:**,� 2� 6:
+
� :*<>� 2� 6:+� :-@� D-F� HY-� JY*S� NS--	� RT� HY-� JY*S� NS� X� \-^� D-	� HY-� JY*S� NS-F-� JY*S� N� b� e-g� D--	� JYiS� l� HY-� JY*S� NS-� r� u-w� D--	� JYyS� l� HY-� JY*S� NS-� r� u-g� D--� |� ��� �� K-�� D--	� JYiS� �-� JY*S� N� �� �-� JY<S� N� �W-^� D-�� D�       z   �      � � �   � � �   � � �   � � �   � � �   � � �   � % &   � � �   � � � 	  � � � 
  � � �  �   � 5   3 3 5 J 6 3 5 P 7 a 9 r 9 � 9 q 9 q 9 X 9 X 9 � 9 � : � : � : � : � : � : � : � < � < � < � < � < � < � < < =# =4 =3 =3 = = =; =D ?D ?M ?C ?U ?^ @m @^ @^ @� @� @] @] @] @� @C ?� A  �      �     �� �Y
� HY�SY�SY�SY�SY�SY�SY�SY�SY�SY	� HY� �Y� HY�SY,SY�SY�SY*SY�SY�SY�S� �SY� �Y� HY�SY>SY�SY�SY*SY�SY�SY�S� �SS� �� ��           �      � �     !     ��                 � �     -     � JY*SY<S�                 � �     "     � ��                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\MockObject.cfc )cfMockObject2ecfc989107402$funcGETREQUEST  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this +LcfMockObject2ecfc989107402$funcGETREQUEST; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 
METHODNAME ) string + getVariable  (I)Lcoldfusion/runtime/Variable; - . %coldfusion/runtime/ArgumentCollection 0
 1 / _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 3 4
  5 putVariable  (Lcoldfusion/runtime/Variable;)V 7 8
  9 INDEX ; numeric = 
		 ? _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V A B
  C java/lang/String E MOCKREQUESTS G _resolve D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; I J
  K java/lang/Object M _resolveAndAutoscalarize O J
  P _arrayGetAt 9(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object; R S
  T 
	 V 
getRequest X metaData Ljava/lang/Object; Z [	  \ struct ^ &coldfusion/runtime/AttributeCollection ` name b 
returntype d hint f hGets the information about a request to a function. This returns a structure of the arguments passed in. h 
Parameters j TYPE l REQUIRED n true p NAME r 
methodName t HINT v 6The name of the method to get request information for. x ([Ljava/lang/Object;)V  z
 a { index } �The number of the request to get information for. For example: if you need the information about the fourth request to this method, then you would need to pass in '4' here.  getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS 
METHODNAME INDEX LineNumberTable <clinit> getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       Z [           #     *� 
�                 � �     !     _�                 � �     !     Y�                 � �    a 
    �+� :+,� :	-� � $:-� (:**,� 2� 6:
+
� :*<>� 2� 6:+� :-@� D-	� FYHS� L� NY-� FY*S� QSY-� FY<S� QS� U�-W� D�       z    �       � � �    � � [    � � �    � � �    � � �    � � [    � % &    � � �    � � � 	   � � � 
   � � �  �   2    d 3 f J g 3 f P h X i m i  i X h X h X h � i  �      �     �� aY� NYcSYYSYeSY_SYgSYiSYkSY� NY� aY� NYmSY,SYoSYqSYsSYuSYwSYyS� |SY� aY� NYmSY>SYoSYqSYsSY~SYwSY�S� |SS� |� ]�           �      � �     -     � FY*SY<S�                 � �     "     � ]�                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\MockObject.cfc cfMockObject2ecfc989107402  coldfusion/runtime/CFComponent  <init> ()V  
  	 this LcfMockObject2ecfc989107402; LocalVariableTable Code com.macromedia.SourceModTime  ���� coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;   javax/servlet/jsp/PageContext 
   parent Ljavax/servlet/jsp/tagext/Tag;  	    
	 " _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V $ %
  & 
	
	 ( 
		
 * invokeMockFunction Lcoldfusion/runtime/UDFMethod; 1cfMockObject2ecfc989107402$funcINVOKEMOCKFUNCTION .
 / 	 , -	  1 invokeMockFunction 3 registerUDF 3(Ljava/lang/String;Lcoldfusion/runtime/UDFMethod;)V 5 6
  7 
getRequest )cfMockObject2ecfc989107402$funcGETREQUEST :
 ; 	 9 -	  = 
getRequest ? init #cfMockObject2ecfc989107402$funcINIT B
 C 	 A -	  E init G getRequestCount .cfMockObject2ecfc989107402$funcGETREQUESTCOUNT J
 K 	 I -	  M getRequestCount O overrideFunction /cfMockObject2ecfc989107402$funcOVERRIDEFUNCTION R
 S 	 Q -	  U overrideFunction W createFunctionStub 1cfMockObject2ecfc989107402$funcCREATEFUNCTIONSTUB Z
 [ 	 Y -	  ] createFunctionStub _ 	addResult (cfMockObject2ecfc989107402$funcADDRESULT b
 c 	 a -	  e 	addResult g metaData Ljava/lang/Object; i j	  k &coldfusion/runtime/AttributeCollection m java/lang/Object o output q false s hint u�The mock object is used to mimic a real object. For example it can be used to substitute object like a DAO or Façade object so that the unit test can be performed independently of outside systems. This is both good for more stable test and allows for better performance. For help documentation on how to use mock objects please visit the CFUnit web site: http://cfunit.sourceforge.net w Name y 
MockObject { 	Functions }	 / k	 ; k	 C k	 K k	 S k	 [ k	 c k ([Ljava/lang/Object;)V  �
 n � 	getOutput ()Ljava/lang/String; runPage ()Ljava/lang/Object; out Ljavax/servlet/jsp/JspWriter; value LineNumberTable <clinit> getMetadata registerUDFs 1       , -    9 -    A -    I -    Q -    Y -    a -    i j           #     *� 
�                 � �     !     t�                 � �     �     G*� � L*� !N*+#� '*+)� '*+)� '*+)� '*+)� '*+)� '*+)� '*++� '�       *    G       G � �    G � j    G    �   & 	  	    3 " B ) K 0 _ 7 d > j     �      � 	    �� /Y� 0� 2� ;Y� <� >� CY� D� F� KY� L� N� SY� T� V� [Y� \� ^� cY� d� f� nY� pYrSYtSYvSYxSYzSY|SY~SY� pY� SY� �SY� �SY� �SY� �SY� �SY� �SS� �� l�           �     �     } K � d � 	 � _ � 3 �  � B  � �     "     � l�                 �      ^     @*4� 2� 8*@� >� 8*H� F� 8*P� N� 8*X� V� 8*`� ^� 8*h� f� 8�           @               ����  - 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\MockObject.cfc 1cfMockObject2ecfc989107402$funcCREATEFUNCTIONSTUB  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 3LcfMockObject2ecfc989107402$funcCREATEFUNCTIONSTUB; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  MOCKFUNCTIONCONTENTS  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   MOCKFUNCTION  PATH   COMPONENTNAME " PACKAGE $ coldfusion/runtime/CfJspPage & pageContext #Lcoldfusion/runtime/NeoPageContext; ( )	 ' * getOut ()Ljavax/servlet/jsp/JspWriter; , - javax/servlet/jsp/PageContext /
 0 . parent Ljavax/servlet/jsp/tagext/Tag; 2 3	 ' 4 NAME 6 string 8 getVariable  (I)Lcoldfusion/runtime/Variable; : ; %coldfusion/runtime/ArgumentCollection =
 > < _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; @ A
  B putVariable  (Lcoldfusion/runtime/Variable;)V D E
  F 
		
		 H _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V J K
 ' L java/lang/String N CFUNITPACKAGE P _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; R S
 ' T _String &(Ljava/lang/Object;)Ljava/lang/String; V W coldfusion/runtime/Cast Y
 Z X 
.mockstubs \ concat &(Ljava/lang/String;)Ljava/lang/String; ^ _
 O ` set (Ljava/lang/Object;)V b c coldfusion/runtime/Variable e
 f d 
		 h 
CFUNITPATH j 
\mockstubs l mockFunction_ n   p _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; r s
 ' t / v .cfc x 
FileExists (Ljava/lang/String;)Z z { coldfusion/runtime/CFPage }
 ~ | 
			 � .<cfcomponent output="false"><cffunction name=" � B" returntype="any"><cfreturn this.invokeMockFunction( methodName=" � 1", args=arguments ) /></cffunction></cfcomponent> � "class$coldfusion$tagext$io$FileTag Ljava/lang/Class; coldfusion.tagext.io.FileTag � forName %(Ljava/lang/String;)Ljava/lang/Class; � � java/lang/Class �
 � � � �	  � _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; � �
 ' � coldfusion/tagext/io/FileTag � cffile � action � write � _validateTagAttrValue J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; � �
 ' � 	setAction (Ljava/lang/String;)V � �
 � � output � J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object; � �
 ' � 	setOutput � c
 � � file � java/lang/StringBuffer �  �
 � � append ,(Ljava/lang/String;)Ljava/lang/StringBuffer; � �
 � � toString ()Ljava/lang/String; � � java/lang/Object �
 � � setFile � �
 � � 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z � �
 ' � 	component � . � CreateObject 8(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object; � �
 ~ � _arrayGetAt C(Lcoldfusion/runtime/Variable;Ljava/lang/Object;)Ljava/lang/Object; � �
 ' � 
		
	 � createFunctionStub � metaData Ljava/lang/Object; � �	  � any � &coldfusion/runtime/AttributeCollection � name � 
returntype � hint � �Returns a stub of a function which can be used for overriding it. This is used by the CFC internally, and should not need to be executed outside the CFC. � 
Parameters � TYPE � REQUIRED � yes � HINT � .The name of the method to generate a stub for. � ([Ljava/lang/Object;)V  �
 � � getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS MOCKFUNCTIONCONTENTS MOCKFUNCTION PATH COMPONENTNAME PACKAGE NAME file0 Lcoldfusion/tagext/io/FileTag; LineNumberTable <clinit> getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �    � �           #     *� 
�                 � �     !     ܰ                 � �     !     ְ                 � �    �    1+� :+,� :	+� :
+� :+!� :+#� :+%� :-� +� 1:-� 5:*79� ?� C:+� G-I� M-	� OYQS� U� []� a� g-i� M-	� OYkS� U� [m� a� g-i� Mo-� OY7S� U� [� a� g-i� Mq� g-i� M
q� g-I� M--� u� [w� a-� u� [� ay� a� �� �-�� M
�-� OY7S� U� [� a�� a-� OY7S� U� [� a�� a� g-�� M-� �� �� �:���� �� ���-
� u� �� ���� �Y-� u� [� �w� �-� u� [� �y� �� �� �� �� ƙ �-i� M-I� M-�-� u� [ʶ a-� u� [� a� ζ g-I� M--� OY7S� U� Ұ-Զ M�       �   1      1 � �   1 � �   1 � �   1 �    1   1 �   1 2 3   1   1 	  1 
  1   1	   1
   1   1   1   � e    [ ! [ ! a " k $ k $ } $ k $ i $ i $ � $ � % � % � % � % � % � % � % � & � & � & � & � & � & � & � ' � ' � ' � ' � ( � ( � ( � ( � * � * � * � * � * * * � * � * * � * � * � * � * � * *% +' +' +% +% +< +% +% +A +A +% +% +V +% +% +# +# +^ +{ ,� ,� ,� ,� ,� ,� ,� ,� ,� ,f ,� , � *� -� /� /� /� /� /� /� /� /� /� /� /� /� /� /	 / 1 / / /' 1       �     }�� �� �� �Y� �Y�SY�SY�SY�SY�SY�SY�SY� �Y� �Y� �Y�SY9SY�SY�SY7SY�SY�SY�S� �SS� �� ڱ           }          (     
� OY7S�           
          "     � ڰ                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\MockObject.cfc .cfMockObject2ecfc989107402$funcGETREQUESTCOUNT  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 0LcfMockObject2ecfc989107402$funcGETREQUESTCOUNT; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 
METHODNAME ) string + getVariable  (I)Lcoldfusion/runtime/Variable; - . %coldfusion/runtime/ArgumentCollection 0
 1 / _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 3 4
  5 putVariable  (Lcoldfusion/runtime/Variable;)V 7 8
  9 
		 ; _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V = >
  ? java/lang/String A MOCKREQUESTS C _resolve D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; E F
  G _resolveAndAutoscalarize I F
  J _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; L M
  N ArrayLen (Ljava/lang/Object;)I P Q coldfusion/runtime/CFPage S
 T R _Object (I)Ljava/lang/Object; V W coldfusion/runtime/Cast Y
 Z X 
	 \ getRequestCount ^ metaData Ljava/lang/Object; ` a	  b numeric d &coldfusion/runtime/AttributeCollection f java/lang/Object h name j 
returntype l hint n *Returns how many time a method was called. p 
Parameters r TYPE t REQUIRED v true x NAME z 
methodName | HINT ~ ,The name of the method to get the count for. � ([Ljava/lang/Object;)V  �
 g � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS 
METHODNAME LineNumberTable <clinit> getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       ` a           #     *� 
�                 � �     !     e�                 � �     !     _�                 � �    -     s+� :+,� :	-� � $:-� (:**,� 2� 6:
+
� :-<� @-	� BYDS� H-� BY*S� K� O� U� [�-]� @�       p    s       s � �    s � a    s � �    s � �    s � �    s � a    s % &    s � �    s � � 	   s � � 
 �   2    _ 3 a 3 a 9 b A c P c A c A c A c A c A b i c  �      �     u� gY� iYkSY_SYmSYeSYoSYqSYsSY� iY� gY� iYuSY,SYwSYySY{SY}SYSY�S� �SS� �� c�           u      � �     (     
� BY*S�           
      � �     "     � c�                     ����  - � 
SourceFile ED:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\MockObject.cfc 1cfMockObject2ecfc989107402$funcINVOKEMOCKFUNCTION  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 3LcfMockObject2ecfc989107402$funcINVOKEMOCKFUNCTION; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  RET  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   I  coldfusion/runtime/CfJspPage   pageContext #Lcoldfusion/runtime/NeoPageContext; " #	 ! $ getOut ()Ljavax/servlet/jsp/JspWriter; & ' javax/servlet/jsp/PageContext )
 * ( parent Ljavax/servlet/jsp/tagext/Tag; , -	 ! . 
METHODNAME 0 string 2 getVariable  (I)Lcoldfusion/runtime/Variable; 4 5 %coldfusion/runtime/ArgumentCollection 7
 8 6 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; : ;
  < putVariable  (Lcoldfusion/runtime/Variable;)V > ?
  @ ARGS B struct D 
		
		 F _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V H I
 ! J   L set (Ljava/lang/Object;)V N O coldfusion/runtime/Variable Q
 R P 
		 T 0 V java/lang/String X MOCKRETURNS Z _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; \ ]
 ! ^ _Map #(Ljava/lang/Object;)Ljava/util/Map; ` a coldfusion/runtime/Cast c
 d b _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; f g
 ! h _String &(Ljava/lang/Object;)Ljava/lang/String; j k
 d l StructKeyExists $(Ljava/util/Map;Ljava/lang/String;)Z n o coldfusion/runtime/CFPage q
 r p 
			
			 t MOCKREQUESTS v _resolve x ]
 ! y _arrayGetAt 8(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object; { |
 ! } ArrayLen (Ljava/lang/Object;)I  �
 r � _mod (II)I � �
 ! � _Object (D)Ljava/lang/Object; � �
 d � java/lang/Object � 9(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object; { �
 ! � _List $(Ljava/lang/Object;)Ljava/util/List; � �
 d � ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z � �
 r � 
			
	 � invokeMockFunction � metaData Ljava/lang/Object; � �	  � any � &coldfusion/runtime/AttributeCollection � name � 
returntype � hint � SInternal method used to invoke a method. You should not need to call this directly. � 
Parameters � TYPE � REQUIRED � true � NAME � 
methodName � HINT � -The original name of the method being called. � ([Ljava/lang/Object;)V  �
 � � args � .The arguments that were passed into the method � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS RET I 
METHODNAME ARGS LineNumberTable <clinit> getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �           #     *� 
�                 � �     !     ��                 � �     !     ��                 � �    @ 	   �+� :+,� :	+� :
+� :-� %� +:-� /:*13� 9� =:+� A*CE� 9� =:+� A-G� K
M� S-U� KW� S-G� K--	� YY[S� _� e-� i� m� s� �-u� K-	� YYwS� z-� YY1S� _� ~� �-	� YY[S� z-� YY1S� _� ~� �� ��c� �� S-u� K
-	� YY[S� z� �Y-� iSY-� iS� �� S-U� K-G� K--	� YYwS� z-� YY1S� _� ~� �-� YYCS� _� �W-G� K-
� i�-�� K�       �   �      � � �   � � �   � � �   � � �   � � �   � � �   � , -   � � �   � � � 	  � � � 
  � � �   � � �   � � �  �   � ?   K C M Z N C M ` O j Q h Q h Q o Q y R w R w R ~ R � T � T � T � T � T � T � V � V � V � V � V � V � V � V � V � V � V � V � V � V � V � V � V � V � V V X% X. X X X X X; X � TC YL [[ [L [L [p [p [K [K [K [� [� ]� ]� [� ]  �      �     �� �Y� �Y�SY�SY�SY�SY�SY�SY�SY� �Y� �Y� �Y�SY3SY�SY�SY�SY�SY�SY�S� �SY� �Y� �Y�SYESY�SY�SY�SY�SY�SY�S� �SS� �� ��           �      � �     -     � YY1SYCS�                 � �     "     � ��                     