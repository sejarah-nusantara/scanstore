����  - j 
SourceFile =D:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\MockCFC.cfc 3cfMockCFC2ecfc910875182$funcCALLFAKEPRIVATEFUNCTION  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 5LcfMockCFC2ecfc910875182$funcCALLFAKEPRIVATEFUNCTION; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 
		 ) _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V + ,
  - fakePrivateFunction / _get &(Ljava/lang/String;)Ljava/lang/Object; 1 2
  3 java/lang/Object 5 
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object; 7 8
  9 
	 ; java/lang/String = callFakePrivateFunction ? metaData Ljava/lang/Object; A B	  C public E &coldfusion/runtime/AttributeCollection G name I access K 
Parameters M ([Ljava/lang/Object;)V  O
 H P getName ()Ljava/lang/String; runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       A B           #     *� 
�                 R S     !     @�                 T U     �  
   E+� :+,� :	-� � $:-� (:-*� .-0� 40-� 6� :W-<� .�       f 
   E       E V W    E X B    E Y Z    E [ \    E ] ^    E _ B    E % &    E ` a    E b a 	 c   "     "  "  *  *  *  *  ;   d      N     0� HY� 6YJSY@SYLSYFSYNSY� 6S� Q� D�           0      e S     !     F�                 f g     #     � >�                 h i     "     � D�                     ����  - � 
SourceFile =D:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\MockCFC.cfc #cfMockCFC2ecfc910875182$funcSETPROP  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this %LcfMockCFC2ecfc910875182$funcSETPROP; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' PROP ) string + getVariable  (I)Lcoldfusion/runtime/Variable; - . %coldfusion/runtime/ArgumentCollection 0
 1 / _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 3 4
  5 putVariable  (Lcoldfusion/runtime/Variable;)V 7 8
  9 
		 ; _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V = >
  ? 	VARIABLES A java/lang/String C _resolveAndAutoscalarize D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object; E F
  G _structSetAt :(Ljava/lang/String;[Ljava/lang/Object;Ljava/lang/Object;)V I J
  K 
	 M setProp O metaData Ljava/lang/Object; Q R	  S void U public W false Y &coldfusion/runtime/AttributeCollection [ java/lang/Object ] name _ access a output c 
returntype e 
Parameters g REQUIRED i true k TYPE m NAME o prop q ([Ljava/lang/Object;)V  s
 \ t 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS PROP LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       Q R   	        #     *� 
�                 v w     !     Z�                 x w     !     V�                 y w     !     P�                 z {    ) 	    s+� :+,� :	-� � $:-� (:**,� 2� 6:
+
� :-<� @-B� DY*S-� DY*S� H� L-<� @�-N� @�       p    s       s | }    s ~ R    s  �    s � �    s � �    s � R    s % &    s � �    s � � 	   s � � 
 �   .     3 	 3 	 9 
 M  M  A  A  _  g  i   �      �     u� \Y
� ^Y`SYPSYbSYXSYdSYZSYfSYVSYhSY	� ^Y� \Y� ^YjSYlSYnSY,SYpSYrS� uSS� u� T�           u      � w     !     X�                 � �     (     
� DY*S�           
      � �     "     � T�                     ����  - � 
SourceFile =D:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\MockCFC.cfc (cfMockCFC2ecfc910875182$funcFAKEFUNCTION  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this *LcfMockCFC2ecfc910875182$funcFAKEFUNCTION; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 
		 ) _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V + ,
  - %class$coldfusion$tagext$lang$ThrowTag Ljava/lang/Class; coldfusion.tagext.lang.ThrowTag 1 forName %(Ljava/lang/String;)Ljava/lang/Class; 3 4 java/lang/Class 6
 7 5 / 0	  9 _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; ; <
  = coldfusion/tagext/lang/ThrowTag ? cfthrow A message C fakeFunction() not overridden E _validateTagAttrValue J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; G H
  I 
setMessage (Ljava/lang/String;)V K L
 @ M type O fakeFunctionInvoked Q setType S L
 @ T 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z V W
  X 
	 Z java/lang/String \ fakeFunction ^ metaData Ljava/lang/Object; ` a	  b &coldfusion/runtime/AttributeCollection d java/lang/Object f name h 
Parameters j ([Ljava/lang/Object;)V  l
 e m getName ()Ljava/lang/String; runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS throw0 !Lcoldfusion/tagext/lang/ThrowTag; LineNumberTable <clinit> getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       / 0    ` a           #     *� 
�                 o p     !     _�                 q r         i+� :+,� :	-� � $:-� (:-*� .-� :� >� @:

BDF� J� N
BPR� J� U
� Y� �-[� .�       p    i       i s t    i u a    i v w    i x y    i z {    i | a    i % &    i } ~    i  ~ 	   i � � 
 �        "  "  ?  M  *  _   �      K     -2� 8� :� eY� gYiSY_SYkSY� gS� n� c�           -      � �     #     � ]�                 � �     "     � c�                     ����  - � 
SourceFile =D:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\MockCFC.cfc cfMockCFC2ecfc910875182  coldfusion/runtime/CFComponent  <init> ()V  
  	 this LcfMockCFC2ecfc910875182; LocalVariableTable Code com.macromedia.SourceModTime  ���e coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;   javax/servlet/jsp/PageContext 
   parent Ljavax/servlet/jsp/tagext/Tag;  	    

	 " _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V $ %
  & 
	
	 ( 
	
 * fakePrivateFunction Lcoldfusion/runtime/UDFMethod; /cfMockCFC2ecfc910875182$funcFAKEPRIVATEFUNCTION .
 / 	 , -	  1 fakePrivateFunction 3 registerUDF 3(Ljava/lang/String;Lcoldfusion/runtime/UDFMethod;)V 5 6
  7 getProp #cfMockCFC2ecfc910875182$funcGETPROP :
 ; 	 9 -	  = getProp ? setProp #cfMockCFC2ecfc910875182$funcSETPROP B
 C 	 A -	  E setProp G callFakePrivateFunction 3cfMockCFC2ecfc910875182$funcCALLFAKEPRIVATEFUNCTION J
 K 	 I -	  M callFakePrivateFunction O fakeFunction (cfMockCFC2ecfc910875182$funcFAKEFUNCTION R
 S 	 Q -	  U fakeFunction W metaData Ljava/lang/Object; Y Z	  [ &coldfusion/runtime/AttributeCollection ] java/lang/Object _ name a MockCFC c hint e 1An imitation CFC used for testing CFC assertions. g Name i 	Functions k	 / [	 ; [	 C [	 K [	 S [ 
Properties r TYPE t string v NAME x prop z ([Ljava/lang/Object;)V  |
 ^ } runPage ()Ljava/lang/Object; out Ljavax/servlet/jsp/JspWriter; value LineNumberTable <clinit> getMetadata registerUDFs 1       , -    9 -    A -    I -    Q -    Y Z           #     *� 
�                  �     �     9*� � L*� !N*+#� '*+#� '*+)� '*+)� '*+)� '*++� '�       *    9       9 � �    9 � Z    9    �           "  )  0      �      �     �� /Y� 0� 2� ;Y� <� >� CY� D� F� KY� L� N� SY� T� V� ^Y
� `YbSYdSYfSYhSYjSYdSYlSY� `Y� mSY� nSY� oSY� pSY� qSSYsSY	� `Y� ^Y� `YuSYwSYySY{S� ~SS� ~� \�           �     �     h  n  t  z  �   � �     "     � \�                 �      L     .*4� 2� 8*@� >� 8*H� F� 8*P� N� 8*X� V� 8�           .               ����  - � 
SourceFile =D:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\MockCFC.cfc /cfMockCFC2ecfc910875182$funcFAKEPRIVATEFUNCTION  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 1LcfMockCFC2ecfc910875182$funcFAKEPRIVATEFUNCTION; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 
		 ) _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V + ,
  - %class$coldfusion$tagext$lang$ThrowTag Ljava/lang/Class; coldfusion.tagext.lang.ThrowTag 1 forName %(Ljava/lang/String;)Ljava/lang/Class; 3 4 java/lang/Class 6
 7 5 / 0	  9 _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; ; <
  = coldfusion/tagext/lang/ThrowTag ? cfthrow A message C fakeFunction() not overridden E _validateTagAttrValue J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; G H
  I 
setMessage (Ljava/lang/String;)V K L
 @ M type O fakeFunctionInvoked Q setType S L
 @ T 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z V W
  X 
	 Z java/lang/String \ fakePrivateFunction ^ metaData Ljava/lang/Object; ` a	  b private d &coldfusion/runtime/AttributeCollection f java/lang/Object h name j access l 
Parameters n ([Ljava/lang/Object;)V  p
 g q getName ()Ljava/lang/String; runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS throw1 !Lcoldfusion/tagext/lang/ThrowTag; LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       / 0    ` a           #     *� 
�                 s t     !     _�                 u v         i+� :+,� :	-� � $:-� (:-*� .-� :� >� @:

BDF� J� N
BPR� J� U
� Y� �-[� .�       p    i       i w x    i y a    i z {    i | }    i ~     i � a    i % &    i � �    i � � 	   i � � 
 �        "  "  ?  M  *  _   �      V     82� 8� :� gY� iYkSY_SYmSYeSYoSY� iS� r� c�           8      � t     !     e�                 � �     #     � ]�                 � �     "     � c�                     ����  - r 
SourceFile =D:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\MockCFC.cfc #cfMockCFC2ecfc910875182$funcGETPROP  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this %LcfMockCFC2ecfc910875182$funcGETPROP; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 
		 ) _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V + ,
  - 	VARIABLES / java/lang/String 1 PROP 3 _resolveAndAutoscalarize 9(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/Object; 5 6
  7 
	 9 getProp ; metaData Ljava/lang/Object; = >	  ? string A public C false E &coldfusion/runtime/AttributeCollection G java/lang/Object I name K access M output O 
returntype Q 
Parameters S ([Ljava/lang/Object;)V  U
 H V 	getOutput ()Ljava/lang/String; getReturnType getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       = >   	        #     *� 
�                 X Y     !     F�                 Z Y     !     B�                 [ Y     !     <�                 \ ]     �  
   D+� :+,� :	-� � $:-� (:-*� .-0� 2Y4S� 8�-:� .�       f 
   D       D ^ _    D ` >    D a b    D c d    D e f    D g >    D % &    D h i    D j i 	 k        "  "  *  *  *  :   l      f     H� HY
� JYLSY<SYNSYDSYPSYFSYRSYBSYTSY	� JS� W� @�           H      m Y     !     D�                 n o     #     � 2�                 p q     "     � @�                     