����  - � 
SourceFile GD:\wwwroot\cfunit\src\net\sourceforge\cfunitReport\test\TestLogFile.cfc ,cfTestLogFile2ecfc836649994$funcTESTREADLINE  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this .LcfTestLogFile2ecfc836649994$funcTESTREADLINE; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 
		 ) _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V + ,
  - fileName / . 1 
ExpandPath &(Ljava/lang/String;)Ljava/lang/String; 3 4 coldfusion/runtime/CFPage 6
 7 5 \testFile.xlog 9 concat ; 4 java/lang/String =
 > < _set '(Ljava/lang/String;Ljava/lang/Object;)V @ A
  B 		
		 D fr F 	component H 	VARIABLES J CFCPATH L _resolveAndAutoscalarize 9(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/Object; N O
  P _String &(Ljava/lang/Object;)Ljava/lang/String; R S coldfusion/runtime/Cast U
 V T .LogFile X CreateObject 8(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object; Z [
 7 \ init ^ java/lang/Object ` _autoscalarize &(Ljava/lang/String;)Ljava/lang/Object; b c
  d _invoke K(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object; f g
  h 
		
		 j assertFalse l _get n c
  o ;LogFile.isLastLine() returned true before getting any lines q 
isLastLine s 
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object; u v
  w assertEquals y 6LogFile.cfc does not parse the correct number of lines { 12 } getLineCount  _double (Ljava/lang/Object;)D � �
 V � 1 � (Ljava/lang/String;)D � �
 V � _Object (D)Ljava/lang/Object; � �
 V � i � SetVariable 8(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object; � �
 7 � 
			 � 
assertTrue � -LogFile.getLine() did not return a structure. � getLine � IsStruct (Ljava/lang/Object;)Z � �
 7 � (Z)Ljava/lang/Object; � �
 V � nextLine � CFLOOP � checkRequestTimeout (Ljava/lang/String;)V � �
  � _checkCondition (DDD)Z � �
  � ALogFile.isLastLine() returned false after looping the entire file � 8LogFile.nextLine() allowed to exceed the file line count � getCurrentLine � setCurrentLine � 100 � >LogFile.setCurrentLine() allowed to exceed the file line count ���       3LogFile.setCurrentLine() allowed a negitive number. � 
		
	 � testReadLine � metaData Ljava/lang/Object; � �	  � void � public � &coldfusion/runtime/AttributeCollection � name � 
returntype � access � 
Parameters � ([Ljava/lang/Object;)V  �
 � � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS t10 D t12 t14 LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �           #     *� 
�                 � �     !     Ȱ                 � �     !     °                 � �    E    �+� :+,� :	-� � $:-� (:-*� .-0-2� 8:� ?� C-E� .-G--I-K� >YMS� Q� WY� ?� ]_� aY-0� eS� i� C-k� .-m� pm-� aYrSY--G� pt� a� iS� xW-*� .-z� pz-� aY|SY~SY--G� p�� a� iS� xW-k� .9
--G� p�� a� i� �9�� �9� �:-�� �W� v-�� .-�� p�-� aY�SY--G� p�� a� i� �� �S� xW-�� .--G� p�� a� iW-*� .
c\9� �:-�� �W�� �
� ����-k� .-�� p�-� aY�SY--G� pt� a� iS� xW-k� .--G� p�� a� iW-*� .-z� pz-� aY�SY~SY--G� p�� a� iS� xW-k� .--G� p�� aY�S� iW-*� .-z� pz-� aY�SY~SY--G� p�� a� iS� xW-k� .--G� p�� aY �� �S� iW-*� .-z� pz-� aY�SY�SY--G� p�� a� iS� xW-�� .�       �   �      � � �   � � �   � � �   � � �   � � �   � � �   � % &   � � �   � � � 	  � � � 
  � � �   � � �  �  � v    " 	 " 	 . 
 - 
 - 
 3 
 - 
 - 
 * 
 * 
 ; 
 H  J  J  \  J  J  G  l  F  F  C  C  y  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �     " 1 7 6 6 6 " " " Q Z Y Y Y j �  � � � � � � � � � � � � � � � � � �   � � �  " 0 ! ! ! 7 ? N S Y X ? ? ? m v � u u u � � � � � � � � � �   �      Z     <� �Y� aY�SY�SY�SY�SY�SY�SY�SY� aS� ׳ Ʊ           <      � �     !     ʰ                 � �     #     � >�                 � �     "     � ư                     ����  - e 
SourceFile GD:\wwwroot\cfunit\src\net\sourceforge\cfunitReport\test\TestLogFile.cfc cfTestLogFile2ecfc836649994  coldfusion/runtime/CFComponent  <init> ()V  
  	 this LcfTestLogFile2ecfc836649994; LocalVariableTable Code com.macromedia.SourceModTime  ��� coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;   javax/servlet/jsp/PageContext 
   parent Ljavax/servlet/jsp/tagext/Tag;  	    

	 " _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V $ %
  & 
 ( setUp Lcoldfusion/runtime/UDFMethod; %cfTestLogFile2ecfc836649994$funcSETUP ,
 - 	 * +	  / setUp 1 registerUDF 3(Ljava/lang/String;Lcoldfusion/runtime/UDFMethod;)V 3 4
  5 testReadLine ,cfTestLogFile2ecfc836649994$funcTESTREADLINE 8
 9 	 7 +	  ; testReadLine = metaData Ljava/lang/Object; ? @	  A &coldfusion/runtime/AttributeCollection C java/lang/Object E name G TestFileReader I extends K )net.sourceforge.cfunit.framework.TestCase M Name O TestLogFile Q 	Functions S	 - A	 9 A ([Ljava/lang/Object;)V  W
 D X runPage ()Ljava/lang/Object; out Ljavax/servlet/jsp/JspWriter; value LineNumberTable <clinit> 
getExtends ()Ljava/lang/String; getMetadata registerUDFs 1       * +    7 +    ? @           #     *� 
�                 Z [     x     $*� � L*� !N*+#� '*+#� '*+)� '�       *    $       $ \ ]    $ ^ @    $    _                `      � 	    \� -Y� .� 0� 9Y� :� <� DY� FYHSYJSYLSYNSYPSYRSYTSY� FY� USY� VSS� Y� B�           \     _   
  J  P   a b     !     N�                 c [     "     � B�                 d      1     *2� 0� 6*>� <� 6�                          ����  - � 
SourceFile GD:\wwwroot\cfunit\src\net\sourceforge\cfunitReport\test\TestLogFile.cfc %cfTestLogFile2ecfc836649994$funcSETUP  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 'LcfTestLogFile2ecfc836649994$funcSETUP; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 
		 ) _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V + ,
  - 	VARIABLES / java/lang/String 1 WEBROOT 3 / 5 
ExpandPath &(Ljava/lang/String;)Ljava/lang/String; 7 8 coldfusion/runtime/CFPage :
 ; 9 _structSetAt :(Ljava/lang/String;[Ljava/lang/Object;Ljava/lang/Object;)V = >
  ? ABSDIR A ../ C CFCPATH E absDir G _autoscalarize &(Ljava/lang/String;)Ljava/lang/Object; I J
  K _String &(Ljava/lang/Object;)Ljava/lang/String; M N coldfusion/runtime/Cast P
 Q O webroot S   U ReplaceNoCase J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; W X
 ; Y . [ \ ] ListChangeDelims _ X
 ; ` 
	 b setUp d metaData Ljava/lang/Object; f g	  h void j public l &coldfusion/runtime/AttributeCollection n java/lang/Object p name r 
returntype t access v 
Parameters x ([Ljava/lang/Object;)V  z
 o { getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       f g           #     *� 
�                 } ~     !     k�                  ~     !     e�                 � �    �  
   �+� :+,� :	-� � $:-� (:-*� .-0� 2Y4S-6� <� @-*� .-0� 2YBS-D� <� @-*� .-0� 2YFS-H� L� R-T� L� RV� Z\^� a� @-c� .�       f 
   �       � � �    � � g    � � �    � � �    � � �    � � g    � % &    � � �    � � � 	 �   v     "  "  7  6  6  *  *  ?  T  S  S  G  G  \  p  p  y  y  �  p  p  �  �  p  p  d  d  �   �      Z     <� oY� qYsSYeSYuSYkSYwSYmSYySY� qS� |� i�           <      � ~     !     m�                 � �     #     � 2�                 � �     "     � i�                     