����  - � 
SourceFile HD:\wwwroot\cfunit\src\net\sourceforge\cfunitReport\test\TestLogProxy.cfc 5cfTestLogProxy2ecfc753540027$funcTESTGENERATEXMLTESTS  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 7LcfTestLogProxy2ecfc753540027$funcTESTGENERATEXMLTESTS; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  LOGFILE  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   PROXY  LOGFILENAME   EXPECT " XMLFILENAME $ coldfusion/runtime/CfJspPage & pageContext #Lcoldfusion/runtime/NeoPageContext; ( )	 ' * getOut ()Ljavax/servlet/jsp/JspWriter; , - javax/servlet/jsp/PageContext /
 0 . parent Ljavax/servlet/jsp/tagext/Tag; 2 3	 ' 4 
		 6 _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V 8 9
 ' : . < 
ExpandPath &(Ljava/lang/String;)Ljava/lang/String; > ? coldfusion/runtime/CFPage A
 B @ \testFile.xlog D concat F ? java/lang/String H
 I G set (Ljava/lang/Object;)V K L coldfusion/runtime/Variable N
 O M \testFile.xml Q 
		
		 S 	component U 	VARIABLES W CFCPATH Y _resolveAndAutoscalarize 9(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/Object; [ \
 ' ] _String &(Ljava/lang/Object;)Ljava/lang/String; _ ` coldfusion/runtime/Cast b
 c a 	.LogProxy e CreateObject 8(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object; g h
 B i   k .LogFile m init o java/lang/Object q _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; s t
 ' u _invoke K(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object; w x
 ' y "class$coldfusion$tagext$io$FileTag Ljava/lang/Class; coldfusion.tagext.io.FileTag } forName %(Ljava/lang/String;)Ljava/lang/Class;  � java/lang/Class �
 � � { |	  � _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; � �
 ' � coldfusion/tagext/io/FileTag � cffile � action � read � _validateTagAttrValue J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; � �
 ' � 	setAction (Ljava/lang/String;)V � �
 � � variable � expect � setVariable � �
 � � file � setFile � �
 � � 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z � �
 ' � assertEquals � _get &(Ljava/lang/String;)Ljava/lang/Object; � �
 ' � generateXMLTests() failed � � t
 ' � generateXMLTests � ToString � `
 B � 
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object; � �
 ' � 
		
	 � testGenerateXMLTests � metaData Ljava/lang/Object; � �	  � void � public � &coldfusion/runtime/AttributeCollection � name � 
returntype � access � 
Parameters � ([Ljava/lang/Object;)V  �
 � � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LOGFILE PROXY LOGFILENAME EXPECT XMLFILENAME file0 Lcoldfusion/tagext/io/FileTag; LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       { |    � �           #     *� 
�                 � �     !     ǰ                 � �     !     ��                 � �    K    �+� :+,� :	+� :
+� :+!� :+#� :+%� :-� +� 1:-� 5:-7� ;-=� CE� J� P-7� ;-=� CR� J� P-T� ;-V-X� IYZS� ^� df� J� j� P-7� ;l� P-T� ;
--V-X� IYZS� ^� dn� J� jp� rY-� vS� z� P-T� ;-� �� �� �:���� �� ����� �� ���-� v� d� �� �� �� �-T� ;-�� ��-� rY�SY-� vSY---� ��� rY-
� vS� z� �S� �W-�� ;�       �   �      � � �   � � �   � � �   � � �   � � �   � � �   � 2 3   � � �   � � � 	  � � � 
  � � �   � � �   � � �   � � �   � � �  �   � ?    J 	 J 	 U 
 T 
 T 
 Z 
 T 
 R 
 R 
 b 
 m  l  l  r  l  j  j  z  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �   ) )  � B J Y ^ i w h h g J J J �   �      b     D~� �� �� �Y� rY�SY�SY�SY�SY�SY�SY�SY� rS� ֳ ű           D      � �     !     ɰ                 � �     #     � I�                 � �     "     � Ű                     ����  - � 
SourceFile HD:\wwwroot\cfunit\src\net\sourceforge\cfunitReport\test\TestLogProxy.cfc &cfTestLogProxy2ecfc753540027$funcSETUP  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this (LcfTestLogProxy2ecfc753540027$funcSETUP; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
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
   �       � � �    � � g    � � �    � � �    � � �    � � g    � % &    � � �    � � � 	 �   v     "  "  7  6  6  *  *  ?  T  S  S  G  G  \  p  p  y  y  �  p  p  �  �  p  p  d  d  �   �      Z     <� oY� qYsSYeSYuSYkSYwSYmSYySY� qS� |� i�           <      � ~     !     m�                 � �     #     � 2�                 � �     "     � i�                     ����  - c 
SourceFile HD:\wwwroot\cfunit\src\net\sourceforge\cfunitReport\test\TestLogProxy.cfc cfTestLogProxy2ecfc753540027  coldfusion/runtime/CFComponent  <init> ()V  
  	 this LcfTestLogProxy2ecfc753540027; LocalVariableTable Code com.macromedia.SourceModTime  ��� coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;   javax/servlet/jsp/PageContext 
   parent Ljavax/servlet/jsp/tagext/Tag;  	    
	
	 " _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V $ %
  & 

 ( setUp Lcoldfusion/runtime/UDFMethod; &cfTestLogProxy2ecfc753540027$funcSETUP ,
 - 	 * +	  / setUp 1 registerUDF 3(Ljava/lang/String;Lcoldfusion/runtime/UDFMethod;)V 3 4
  5 testGenerateXMLTests 5cfTestLogProxy2ecfc753540027$funcTESTGENERATEXMLTESTS 8
 9 	 7 +	  ; testGenerateXMLTests = metaData Ljava/lang/Object; ? @	  A &coldfusion/runtime/AttributeCollection C java/lang/Object E name G TestLogProxy I extends K )net.sourceforge.cfunit.framework.TestCase M Name O 	Functions Q	 - A	 9 A ([Ljava/lang/Object;)V  U
 D V runPage ()Ljava/lang/Object; out Ljavax/servlet/jsp/JspWriter; value LineNumberTable <clinit> 
getExtends ()Ljava/lang/String; getMetadata registerUDFs 1       * +    7 +    ? @           #     *� 
�                 X Y     x     $*� � L*� !N*+#� '*+#� '*+)� '�       *    $       $ Z [    $ \ @    $    ]               ^      � 	    \� -Y� .� 0� 9Y� :� <� DY� FYHSYJSYLSYNSYPSYJSYRSY� FY� SSY� TSS� W� B�           \     ]   
  J  P   _ `     !     N�                 a Y     "     � B�                 b      1     *2� 0� 6*>� <� 6�                          