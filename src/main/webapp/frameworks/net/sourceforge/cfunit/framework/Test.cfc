����  - r 
SourceFile ?D:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\Test.cfc cfTest2ecfc2098835018  coldfusion/runtime/CFComponent  <init> ()V  
  	 this LcfTest2ecfc2098835018; LocalVariableTable Code com.macromedia.SourceModTime  ���� coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;   javax/servlet/jsp/PageContext 
   parent Ljavax/servlet/jsp/tagext/Tag;  	    
	 " _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V $ %
  & 
	
	 ( 
	
			
	 * 
 , run Lcoldfusion/runtime/UDFMethod; cfTest2ecfc2098835018$funcRUN 0
 1 	 . /	  3 run 5 registerUDF 3(Ljava/lang/String;Lcoldfusion/runtime/UDFMethod;)V 7 8
  9 ArrayConcat %cfTest2ecfc2098835018$funcARRAYCONCAT <
 = 	 ; /	  ? ArrayConcat A countTestCases (cfTest2ecfc2098835018$funcCOUNTTESTCASES D
 E 	 C /	  G countTestCases I metaData Ljava/lang/Object; K L	  M &coldfusion/runtime/AttributeCollection O java/lang/Object Q extends S Assert U hint W 3A <em>Test</em> can be run and collect its results. Y Name [ Test ] 	Functions _	 1 M	 = M	 E M ([Ljava/lang/Object;)V  d
 P e runPage ()Ljava/lang/Object; out Ljavax/servlet/jsp/JspWriter; value LineNumberTable <clinit> 
getExtends ()Ljava/lang/String; getMetadata registerUDFs 1       . /    ; /    C /    K L           #     *� 
�                 g h     �     +*� � L*� !N*+#� '*+)� '*++� '*+-� '�       *    +       + i j    + k L    +    l           "  " *     m      � 	    l� 1Y� 2� 4� =Y� >� @� EY� F� H� PY� RYTSYVSYXSYZSY\SY^SY`SY� RY� aSY� bSY� cSS� f� N�           l     l     T  Z  `   n o     !     V�                 p h     "     � N�                 q      :     *6� 4� :*B� @� :*J� H� :�                          ����  - � 
SourceFile ?D:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\Test.cfc cfTest2ecfc2098835018$funcRUN  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this LcfTest2ecfc2098835018$funcRUN; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 
		 ) _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V + ,
  - %class$coldfusion$tagext$lang$ThrowTag Ljava/lang/Class; coldfusion.tagext.lang.ThrowTag 1 forName %(Ljava/lang/String;)Ljava/lang/Class; 3 4 java/lang/Class 6
 7 5 / 0	  9 _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; ; <
  = coldfusion/tagext/lang/ThrowTag ? cfthrow A message C Method run() must be overriden E _validateTagAttrValue J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; G H
  I 
setMessage (Ljava/lang/String;)V K L
 @ M type O AbstractMethod Q setType S L
 @ T 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z V W
  X  
	 Z java/lang/String \ run ^ metaData Ljava/lang/Object; ` a	  b 
TestResult d public f &coldfusion/runtime/AttributeCollection h java/lang/Object j name l access n 
returntype p hint r =Runs a test and collects its result in a TestResult instance. t 
Parameters v ([Ljava/lang/Object;)V  x
 i y getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS throw1 !Lcoldfusion/tagext/lang/ThrowTag; LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       / 0    ` a           #     *� 
�                 { |     !     e�                 } |     !     _�                 ~          i+� :+,� :	-� � $:-� (:-*� .-� :� >� @:

BDF� J� N
BPR� J� U
� Y� �-[� .�       p    i       i � �    i � a    i � �    i � �    i � �    i � a    i % &    i � �    i � � 	   i � � 
 �        "  "  ?  M  *  _   �      n     P2� 8� :� iY
� kYmSY_SYoSYgSYqSYeSYsSYuSYwSY	� kS� z� c�           P      � |     !     g�                 � �     #     � ]�                 � �     "     � c�                     ����  - � 
SourceFile ?D:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\Test.cfc %cfTest2ecfc2098835018$funcARRAYCONCAT  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 'LcfTest2ecfc2098835018$funcARRAYCONCAT; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  I  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;   !	  " getOut ()Ljavax/servlet/jsp/JspWriter; $ % javax/servlet/jsp/PageContext '
 ( & parent Ljavax/servlet/jsp/tagext/Tag; * +	  , A1 . getVariable  (I)Lcoldfusion/runtime/Variable; 0 1 %coldfusion/runtime/ArgumentCollection 3
 4 2 _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 6 7
  8 putVariable  (Lcoldfusion/runtime/Variable;)V : ;
  < A2 > 1 @ set (Ljava/lang/Object;)V B C coldfusion/runtime/Variable E
 F D _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; H I
  J IsArray (Ljava/lang/Object;)Z L M coldfusion/runtime/CFPage O
 P N _Object (Z)Ljava/lang/Object; R S coldfusion/runtime/Cast U
 V T _boolean X M
 V Y �Error in <Code>ArrayConcat()</code>! Correct usage: ArrayConcat(<I>Array1</I>, <I>Array2</I>) -- Concatenates Array2 to the end of Array1 [ WriteOutput (Ljava/lang/String;)Z ] ^
 P _ 0 a _List $(Ljava/lang/Object;)Ljava/util/List; c d
 V e _arrayGetAt C(Lcoldfusion/runtime/Variable;Ljava/lang/Object;)Ljava/lang/Object; g h
  i ArrayAppend %(Ljava/util/List;Ljava/lang/Object;)Z k l
 P m _double (Ljava/lang/Object;)D o p
 V q (D)Ljava/lang/Object; R s
 V t ArrayLen (Ljava/lang/Object;)I v w
 P x (I)Ljava/lang/Object; R z
 V { _compare '(Ljava/lang/Object;Ljava/lang/Object;)D } ~
   java/lang/String � ArrayConcat � metaData Ljava/lang/Object; � �	  � &coldfusion/runtime/AttributeCollection � java/lang/Object � Name � 
Parameters � REQUIRED � true � NAME � ([Ljava/lang/Object;)V  �
 � � getName ()Ljava/lang/String; runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS I A1 A2 LineNumberTable <clinit> getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       � �           #     *� 
�                 � �     !     ��                 � �    [     �+� :+,� :	+� :
-� #� ):-� -:*/� 5� 9:+� =*?� 5� 9:+� =
A� G-� K� Q�� WY� Z� W-� K� Q�� W� Z� -\� `Wb�
A� G� 0--� K� f--
� K� j� nW
-
� K� rc� u� G-
� K-� K� y� |� ��t|����-� K��       �    �       � � �    � � �    � � �    � � �    � � �    � � �    � * +    � � �    � � � 	   � � � 
   � � �    � � �  �   � 3    :  X   V  ] ! ] ! ] ! ] ! ] ! ] ! s ! s ! s ! s ! s ! s ! ] ! � " � " � ! � # � # � " � ! ]   � % � % � % � & � & � & � & � & � & � % � % � % � % � % � % � % � % � % � % � % � % � % � $ � ( � ( � '  �      �     i� �Y� �Y�SY�SY�SY� �Y� �Y� �Y�SY�SY�SY/S� �SY� �Y� �Y�SY�SY�SY?S� �SS� �� ��           i      � �     -     � �Y/SY?S�                 � �     "     � ��                     ����  - � 
SourceFile ?D:\wwwroot\cfunit\src\net\sourceforge\cfunit\framework\Test.cfc (cfTest2ecfc2098835018$funcCOUNTTESTCASES  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this *LcfTest2ecfc2098835018$funcCOUNTTESTCASES; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' 
		 ) _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V + ,
  - %class$coldfusion$tagext$lang$ThrowTag Ljava/lang/Class; coldfusion.tagext.lang.ThrowTag 1 forName %(Ljava/lang/String;)Ljava/lang/Class; 3 4 java/lang/Class 6
 7 5 / 0	  9 _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; ; <
  = coldfusion/tagext/lang/ThrowTag ? cfthrow A message C )Method countTestCases() must be overriden E _validateTagAttrValue J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; G H
  I 
setMessage (Ljava/lang/String;)V K L
 @ M type O AbstractMethod Q setType S L
 @ T 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z V W
  X  
	 Z java/lang/String \ countTestCases ^ metaData Ljava/lang/Object; ` a	  b numeric d public f &coldfusion/runtime/AttributeCollection h java/lang/Object j name l access n 
returntype p hint r >Counts the number of test cases that will be run by this test. t 
Parameters v ([Ljava/lang/Object;)V  x
 i y getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS throw0 !Lcoldfusion/tagext/lang/ThrowTag; LineNumberTable <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       / 0    ` a           #     *� 
�                 { |     !     e�                 } |     !     _�                 ~          i+� :+,� :	-� � $:-� (:-*� .-� :� >� @:

BDF� J� N
BPR� J� U
� Y� �-[� .�       p    i       i � �    i � a    i � �    i � �    i � �    i � a    i % &    i � �    i � � 	   i � � 
 �        "  "  ?  M  *  _   �      n     P2� 8� :� iY
� kYmSY_SYoSYgSYqSYeSYsSYuSYwSY	� kS� z� c�           P      � |     !     g�                 � �     #     � ]�                 � �     "     � c�                     