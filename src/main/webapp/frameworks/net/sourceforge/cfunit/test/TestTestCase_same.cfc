����  -8 
SourceFile GD:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\TestTestCase_same.cfc 2cfTestTestCase_same2ecfc1299569909$funcTESTSAMECFC  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 4LcfTestTestCase_same2ecfc1299569909$funcTESTSAMECFC; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  	OBJECTBAD  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   OBJECT  BFAILURETHROWN   coldfusion/runtime/CfJspPage " pageContext #Lcoldfusion/runtime/NeoPageContext; $ %	 # & getOut ()Ljavax/servlet/jsp/JspWriter; ( ) javax/servlet/jsp/PageContext +
 , * parent Ljavax/servlet/jsp/tagext/Tag; . /	 # 0 
		 2 _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V 4 5
 # 6 false 8 set (Ljava/lang/Object;)V : ; coldfusion/runtime/Variable =
 > < 	component @ 	VARIABLES B java/lang/String D ROOT F _resolveAndAutoscalarize 9(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/Object; H I
 # J _String &(Ljava/lang/Object;)Ljava/lang/String; L M coldfusion/runtime/Cast O
 P N .framework.TestCase R concat &(Ljava/lang/String;)Ljava/lang/String; T U
 E V CreateObject 8(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object; X Y coldfusion/runtime/CFPage [
 \ Z 
		
		 ^ &class$coldfusion$tagext$lang$InvokeTag Ljava/lang/Class;  coldfusion.tagext.lang.InvokeTag b forName %(Ljava/lang/String;)Ljava/lang/Class; d e java/lang/Class g
 h f ` a	  j _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; l m
 # n  coldfusion/tagext/lang/InvokeTag p 
assertSame r 	setMethod (Ljava/lang/String;)V t u
 q v 
doStartTag ()I x y
 q z 	_pushBody _(Ljavax/servlet/jsp/tagext/BodyTag;ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; | }
 # ~ 
			 � .class$coldfusion$tagext$lang$InvokeArgumentTag (coldfusion.tagext.lang.InvokeArgumentTag � � a	  � (coldfusion/tagext/lang/InvokeArgumentTag � message � setName � u
 � � ,AssertSame failed when it should have passes � setValue � ;
 � � 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z � �
 # � expected � _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; � �
 # � actual � doAfterBody � y coldfusion/tagext/GenericTag �
 � � _popBody =(ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; � �
 # � doEndTag � y
 q � *coldfusion/runtime/TransientVariableHolder � &(Lcoldfusion/runtime/NeoPageContext;)V  �
 � � 
				 � 

			
			 � unwrap ,(Ljava/lang/Throwable;)Ljava/lang/Throwable; � � coldfusion/runtime/NeoException �
 � � t0 [Ljava/lang/String; AssertionFailedError � � �	  � findThrowableTarget +(Ljava/lang/Throwable;[Ljava/lang/String;)I � �
 � � CFCATCH � bind '(Ljava/lang/String;Ljava/lang/Object;)V � �
 � � true � unbind � 
 � � _boolean (Ljava/lang/Object;)Z � �
 P � fail � !AssertSame failed to assert a CFC � 
		
	 � testSameCFC � metaData Ljava/lang/Object; � �	  � void � public � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returntype � access � 
Parameters � ([Ljava/lang/Object;)V  �
 � � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS 	OBJECTBAD OBJECT BFAILURETHROWN invoke29 "Lcoldfusion/tagext/lang/InvokeTag; mode29 I invokeargument26 *Lcoldfusion/tagext/lang/InvokeArgumentTag; t16 invokeargument27 t18 invokeargument28 t20 t21 Ljava/lang/Throwable; t22 t23 ,Lcoldfusion/runtime/TransientVariableHolder; invoke32 mode32 invokeargument30 t27 invokeargument31 t29 t30 t31 t32 t33 #Lcoldfusion/runtime/AbortException; t34 Ljava/lang/Exception; __cfcatchThrowable2 t36 t37 invoke34 mode34 invokeargument33 t41 t42 t43 LineNumberTable !coldfusion/runtime/AbortException. java/lang/Exception0 <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       ` a    � a    � �    � �           #     *� 
�                 � �     !     �                 � �     !     ڰ                 � �    ? 	 ,  �+� :+,� :	+� :
+� :+!� :-� '� -:-� 1:-3� 79� ?-3� 7-A-C� EYGS� K� QS� W� ]� ?-3� 7
-A-C� EYGS� K� QS� W� ]� ?-_� 7-� k� o� q:s� w� {Y6� �-� :-�� 7-� �� o� �:�� ��� �� �� :� ��-�� 7-� �� o� �:�� �-� �� �� �� :� ^�-�� 7-� �� o� �:�� �-� �� �� �� :� $�-3� 7� ���I� � :� �:-� �:�� �� �-_� 7� �Y-� '� �:-�� 7-� k� o� q:s� w� {Y6� �-� :-�� 7-� �� o� �:�� �-
� �� �� �� :� d� ��-�� 7-� �� o� �:�� �-� �� �� �� :� '� ��-�� 7� ���y� � :� �:-� �:�� �� : � q �-�� 7� c� R:!!�:""� �:##� �� ê     6           �#� �-�� 7˶ ?-�� 7� "�� � :$� $�:%� Ω%-_� 7-� �� ��� �-�� 7-� k� o� q:&&Զ w&� {Y6'� q-&'� :-�� 7-� �&� o� �:((�� �(ֶ �(� �� :)� $)�-�� 7&� ����� � :*� *�:+-'� �:�+&� �� �-3� 7-ض 7�  ���  ���  ���/���1�  h��      � ,  �      � � �   � � �   � � �   � � �   � � �   �  �   � . /   �   � 	  � 
  �   �   �   �	
   �   � �   �   � �   �   � �   �   � �   �   �   �
   �   � �   �   � �   �   � �   � �    � ! !  �"# "  �$ #  �% $  �& � %  �' &  �(
 '  �) (  �* � )  �+ *  �, � +-  J R   � : � : � D � B � B � I � T � V � V � h � V � V � S � Q � Q � s � ~ � � � � � � � � � � � } � { � { � � � � � � � � � � � � � �! �( �( � �B �[ �b �b �J �| � � �� �� �� �� � � � � �: �S �Z �Z �B �w �� �� �� �� �� �� �� � �� �) �1 �1 �1 �? �X �t �� �� �| �� �G �� �1 �� � 2      v     Xc� i� k�� i� �� EY�S� �� �Y� �Y�SY�SY�SY�SY�SY�SY�SY� �S� � ޱ           X     3 �     !     �                45     #     � E�                67     "     � ް                     ����  -4 
SourceFile GD:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\TestTestCase_same.cfc 9cfTestTestCase_same2ecfc1299569909$funcTESTSAMEJAVAOBJECT  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this ;LcfTestTestCase_same2ecfc1299569909$funcTESTSAMEJAVAOBJECT; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  	OBJECTBAD  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   OBJECT  BFAILURETHROWN   coldfusion/runtime/CfJspPage " pageContext #Lcoldfusion/runtime/NeoPageContext; $ %	 # & getOut ()Ljavax/servlet/jsp/JspWriter; ( ) javax/servlet/jsp/PageContext +
 , * parent Ljavax/servlet/jsp/tagext/Tag; . /	 # 0 
		 2 _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V 4 5
 # 6 false 8 set (Ljava/lang/Object;)V : ; coldfusion/runtime/Variable =
 > < java @ java.lang.Object B CreateObject 8(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/Object; D E coldfusion/runtime/CFPage G
 H F init J java/lang/Object L _invoke K(Ljava/lang/Object;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object; N O
 # P java.lang.String R String Object T 
		
		 V &class$coldfusion$tagext$lang$InvokeTag Ljava/lang/Class;  coldfusion.tagext.lang.InvokeTag Z forName %(Ljava/lang/String;)Ljava/lang/Class; \ ] java/lang/Class _
 ` ^ X Y	  b _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; d e
 # f  coldfusion/tagext/lang/InvokeTag h 
assertSame j 	setMethod (Ljava/lang/String;)V l m
 i n 
doStartTag ()I p q
 i r 	_pushBody _(Ljavax/servlet/jsp/tagext/BodyTag;ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; t u
 # v 
			 x .class$coldfusion$tagext$lang$InvokeArgumentTag (coldfusion.tagext.lang.InvokeArgumentTag { z Y	  } (coldfusion/tagext/lang/InvokeArgumentTag  message � setName � m
 � � ,AssertSame failed when it should have passes � setValue � ;
 � � 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z � �
 # � expected � _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; � �
 # � actual � doAfterBody � q coldfusion/tagext/GenericTag �
 � � _popBody =(ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; � �
 # � doEndTag � q
 i � 

				
		 � *coldfusion/runtime/TransientVariableHolder � &(Lcoldfusion/runtime/NeoPageContext;)V  �
 � � 
				 � 

			
			 � unwrap ,(Ljava/lang/Throwable;)Ljava/lang/Throwable; � � coldfusion/runtime/NeoException �
 � � t0 [Ljava/lang/String; java/lang/String � AssertionFailedError � � �	  � findThrowableTarget +(Ljava/lang/Throwable;[Ljava/lang/String;)I � �
 � � CFCATCH � bind '(Ljava/lang/String;Ljava/lang/Object;)V � �
 � � true � unbind � 
 � � _boolean (Ljava/lang/Object;)Z � � coldfusion/runtime/Cast �
 � � fail � )AssertSame failed to assert a Java object � 
	 � testSameJavaObject � metaData Ljava/lang/Object; � �	  � void � public � &coldfusion/runtime/AttributeCollection � name � 
returntype � access � 
Parameters � ([Ljava/lang/Object;)V  �
 � � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS 	OBJECTBAD OBJECT BFAILURETHROWN invoke38 "Lcoldfusion/tagext/lang/InvokeTag; mode38 I invokeargument35 *Lcoldfusion/tagext/lang/InvokeArgumentTag; t16 invokeargument36 t18 invokeargument37 t20 t21 Ljava/lang/Throwable; t22 t23 ,Lcoldfusion/runtime/TransientVariableHolder; invoke41 mode41 invokeargument39 t27 invokeargument40 t29 t30 t31 t32 t33 #Lcoldfusion/runtime/AbortException; t34 Ljava/lang/Exception; __cfcatchThrowable3 t36 t37 invoke43 mode43 invokeargument42 t41 t42 t43 LineNumberTable !coldfusion/runtime/AbortException* java/lang/Exception, <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       X Y    z Y    � �    � �           #     *� 
�                 � �     !     ް                 � �     !     ذ                 � �      ,  �+� :+,� :	+� :
+� :+!� :-� '� -:-� 1:-3� 79� ?-3� 7--AC� IK� M� Q� ?-3� 7
--AS� IK� MYUS� Q� ?-W� 7-� c� g� i:k� o� sY6� �-� w:-y� 7-� ~� g� �:�� ��� �� �� :� ��-y� 7-� ~� g� �:�� �-� �� �� �� :� ^�-y� 7-� ~� g� �:�� �-� �� �� �� :� $�-3� 7� ���I� � :� �:-� �:�� �� �-�� 7� �Y-� '� �:-y� 7-� c� g� i:k� o� sY6� �-� w:-�� 7-� ~� g� �:�� �-
� �� �� �� :� d� ��-�� 7-� ~� g� �:�� �-� �� �� �� :� '� ��-y� 7� ���y� � :� �:-� �:�� �� : � r �-�� 7� d� S:!!�:""� �:##� �� ��      7           �#� �-�� 7Ƕ ?-y� 7� "�� � :$� $�:%� ʩ%-W� 7-� �� ��� �-y� 7-� c� g� i:&&Ҷ o&� sY6'� q-&'� w:-�� 7-� ~&� g� �:((�� �(Զ �(� �� :)� $)�-y� 7&� ����� � :*� *�:+-'� �:�+&� �� �-3� 7-ֶ 7�  �{�  �v|  ���+���-�  X��      � ,  �      � � �   � � �   � � �   � � �   � � �   � � �   � . /   � � �   � � � 	  �  � 
  � �   � �   �   �   �   �	 �   �
   � �   �   � �   �   � �   �   �   �   �   � �   �   � �   �   � �   � �    � !  � "  �  #  �! $  �" � %  �# &  �$ '  �% (  �& � )  �' *  �( � +)  6 M   � : � : � D � B � B � I � U � W � T � S � Q � Q � h � t � v � s � � � r � p � p � � � � � � � � � � � � � � � � � � � �1 �J �Q �Q �9 �k � � �� �� �� �� � � � �� �) �B �I �I �1 �f �� �� �� �� �� �� �� �� �� � �! �! �! �/ �H �d �} �� �l �� �7 �� �! �� � .      v     X[� a� c|� a� ~� �Y�S� �� �Y� MY�SY�SY�SY�SY�SY�SY�SY� MS� �� ܱ           X     / �     !     �                01     #     � ��                23     "     � ܰ                     ����  -T 
SourceFile GD:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\TestTestCase_same.cfc 5cfTestTestCase_same2ecfc1299569909$funcTESTSAMESTRUCT  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 7LcfTestTestCase_same2ecfc1299569909$funcTESTSAMESTRUCT; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  	OBJECTBAD  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   OBJECT  BFAILURETHROWN   coldfusion/runtime/CfJspPage " pageContext #Lcoldfusion/runtime/NeoPageContext; $ %	 # & getOut ()Ljavax/servlet/jsp/JspWriter; ( ) javax/servlet/jsp/PageContext +
 , * parent Ljavax/servlet/jsp/tagext/Tag; . /	 # 0 
		 2 _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V 4 5
 # 6 false 8 set (Ljava/lang/Object;)V : ; coldfusion/runtime/Variable =
 > < 	StructNew !()Lcoldfusion/util/FastHashtable; @ A coldfusion/runtime/CFPage C
 D B 
		
		 F &class$coldfusion$tagext$lang$InvokeTag Ljava/lang/Class;  coldfusion.tagext.lang.InvokeTag J forName %(Ljava/lang/String;)Ljava/lang/Class; L M java/lang/Class O
 P N H I	  R _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; T U
 # V  coldfusion/tagext/lang/InvokeTag X 
assertSame Z 	setMethod (Ljava/lang/String;)V \ ]
 Y ^ 
doStartTag ()I ` a
 Y b 	_pushBody _(Ljavax/servlet/jsp/tagext/BodyTag;ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; d e
 # f 
			 h .class$coldfusion$tagext$lang$InvokeArgumentTag (coldfusion.tagext.lang.InvokeArgumentTag k j I	  m (coldfusion/tagext/lang/InvokeArgumentTag o message q setName s ]
 p t FAssertSame failed when it should have passes, using an empty structure v setValue x ;
 p y 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z { |
 # } expected  _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; � �
 # � actual � doAfterBody � a coldfusion/tagext/GenericTag �
 � � _popBody =(ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; � �
 # � doEndTag � a
 Y � 	
		
 		 � _Map #(Ljava/lang/Object;)Ljava/util/Map; � � coldfusion/runtime/Cast �
 � � key1 � abc � StructInsert 6(Ljava/util/Map;Ljava/lang/String;Ljava/lang/Object;)Z � �
 D � 
 		 � key2 � xyz � IAssertSame failed when it should have passes, using a populated structure � assertEquals � JAssertSame changed the object so that it is no longer equal to what it was � 

				
		 � *coldfusion/runtime/TransientVariableHolder � &(Lcoldfusion/runtime/NeoPageContext;)V  �
 � � 
				 � 

			
			 � unwrap ,(Ljava/lang/Throwable;)Ljava/lang/Throwable; � � coldfusion/runtime/NeoException �
 � � t0 [Ljava/lang/String; java/lang/String � AssertionFailedError � � �	  � findThrowableTarget +(Ljava/lang/Throwable;[Ljava/lang/String;)I � �
 � � CFCATCH � bind '(Ljava/lang/String;Ljava/lang/Object;)V � �
 � � true � unbind � 
 � � _boolean (Ljava/lang/Object;)Z � �
 � � fail � 'AssertSame failed to assert a structure � 
	 � testSameStruct � metaData Ljava/lang/Object; � �	  � void � public � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returntype � access � 
Parameters � ([Ljava/lang/Object;)V  �
 � � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS 	OBJECTBAD OBJECT BFAILURETHROWN invoke12 "Lcoldfusion/tagext/lang/InvokeTag; mode12 I invokeargument9 *Lcoldfusion/tagext/lang/InvokeArgumentTag; t16 invokeargument10 t18 invokeargument11 t20 t21 Ljava/lang/Throwable; t22 invoke16 mode16 invokeargument13 t26 invokeargument14 t28 invokeargument15 t30 t31 t32 invoke20 mode20 invokeargument17 t36 invokeargument18 t38 invokeargument19 t40 t41 t42 t43 ,Lcoldfusion/runtime/TransientVariableHolder; invoke23 mode23 invokeargument21 t47 invokeargument22 t49 t50 t51 t52 t53 #Lcoldfusion/runtime/AbortException; t54 Ljava/lang/Exception; __cfcatchThrowable1 t56 t57 invoke25 mode25 invokeargument24 t61 t62 t63 LineNumberTable !coldfusion/runtime/AbortExceptionJ java/lang/ExceptionL <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       H I    j I    � �    � �           #     *� 
�                 � �     !     �                 � �     !     �                 � �    g  @  S+� :+,� :	+� :
+� :+!� :-� '� -:-� 1:-3� 79� ?-3� 7� E� ?-3� 7
� E� ?-G� 7-� S� W� Y:[� _� cY6� �-� g:-i� 7-� n� W� p:r� uw� z� ~� :� ��-i� 7-� n� W� p:�� u-� �� z� ~� :� ^�-i� 7-� n� W� p:�� u-� �� z� ~� :� $�-3� 7� ���I� � :� �:-� �:�� �� �-�� 7--� �� ���� �W-�� 7--� �� ���� �W-3� 7--
� �� ���� �W-3� 7--
� �� ���� �W-G� 7-� S� W� Y:[� _� cY6� �-� g:-i� 7-� n� W� p:r� u�� z� ~� :� ��-i� 7-� n� W� p:�� u-� �� z� ~� :� ^�-i� 7-� n� W� p:�� u-� �� z� ~� :� $�-3� 7� ���I� � :� �: -� �:� � �� �-G� 7-� S� W� Y:!!�� _!� cY6"� �-!"� g:-i� 7-� n!� W� p:##r� u#�� z#� ~� :$� �$�-i� 7-� n!� W� p:%%�� u%-
� �� z%� ~� :&� ^&�-i� 7-� n!� W� p:''�� u'-� �� z'� ~� :(� $(�-3� 7!� ���I� � :)� )�:*-"� �:�*!� �� �-�� 7� �Y-� '� �:+-i� 7-� S� W� Y:,,[� _,� cY6-� �-,-� g:-�� 7-� n,� W� p:..�� u.-
� �� z.� ~� :/� d� �/�-�� 7-� n,� W� p:00�� u0-� �� z0� ~� :1� '� �1�-i� 7,� ���y� � :2� 2�:3--� �:�3,� �� :4� q4�-�� 7� c� R:55�:66� �:77� Ǹ ˪     6           +�7� �-�� 7Ӷ ?-i� 7� 6�� � :8� 8�:9+� ֩9-G� 7-� �� ��� �-i� 7-� S� W� Y:::ܶ _:� cY6;� q-:;� g:-�� 7-� n:� W� p:<<r� u<޶ z<� ~� :=� $=�-i� 7:� ����� � :>� >�:?-;� �:�?:� �� �-3� 7-� 7�  �X^  ��  &��  Q��  (#K((M(ux  �       � @  S      S �    S �   S   S   S   S �   S . /   S	
   S
 	  S
 
  S
   S
   S   S   S   S �   S   S �   S   S �   S   S �   S   S   S   S  �   S!   S" �   S#   S$ �   S%   S& �    S' !  S( "  S) #  S* � $  S+ %  S, � &  S- '  S. � (  S/ )  S0 � *  S12 +  S3 ,  S4 -  S5 .  S6 � /  S7 0  S8 � 1  S9 2  S: � 3  S; � 4  S<= 5  S>? 6  S@ 7  SA 8  SB � 9  SC :  SD ;  SE <  SF � =  SG >  SH � ?I  : �   U : W : W D X B X B X I X S Y Q Y Q Y Y Y c Z a Z a Z i Z � \ � \ � ] � ] � ] � ] � ^ � ^ � ^ � ^ ^' _. _. _ _H _ q \ `� b� b� b� b� b� b� b� b� b� c� c� c� c� c� c� c� c� c� d� d� d� d� d� d� d� d� d� e� e� e� e� e� e� e� e� e  g g5 h< h$ hR hk ir ir iZ i� i� j� j� j� j� j� g� k m2 mK nR n: nh n� o� o� op o� o� p� p� p� p� p m q( sA t] tv u} u} ue u� u� v� v� v� v� v0 t wU y_ z_ z] z] zd z s� |� ~� ~� ~� ~� � � �� �� �
 �� A �� ~I � N      v     XK� Q� Sl� Q� n� �Y�S� ǻ �Y� �Y�SY�SY�SY�SY�SY�SY�SY� �S� �� �           X     O �     !     �                PQ     #     � ð                RS     "     � �                     ����  -% 
SourceFile GD:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\TestTestCase_same.cfc 5cfTestTestCase_same2ecfc1299569909$funcTESTSAMESIMPLE  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 7LcfTestTestCase_same2ecfc1299569909$funcTESTSAMESIMPLE; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  EXPECTED  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   EXPECTEDBAD  BFAILURETHROWN   ACTUAL " coldfusion/runtime/CfJspPage $ pageContext #Lcoldfusion/runtime/NeoPageContext; & '	 % ( getOut ()Ljavax/servlet/jsp/JspWriter; * + javax/servlet/jsp/PageContext -
 . , parent Ljavax/servlet/jsp/tagext/Tag; 0 1	 % 2 
		 4 _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V 6 7
 % 8 false : set (Ljava/lang/Object;)V < = coldfusion/runtime/Variable ?
 @ > abc B xyz D 
		
		 F &class$coldfusion$tagext$lang$InvokeTag Ljava/lang/Class;  coldfusion.tagext.lang.InvokeTag J forName %(Ljava/lang/String;)Ljava/lang/Class; L M java/lang/Class O
 P N H I	  R _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; T U
 % V  coldfusion/tagext/lang/InvokeTag X 
assertSame Z 	setMethod (Ljava/lang/String;)V \ ]
 Y ^ 
doStartTag ()I ` a
 Y b 	_pushBody _(Ljavax/servlet/jsp/tagext/BodyTag;ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; d e
 % f 
			 h .class$coldfusion$tagext$lang$InvokeArgumentTag (coldfusion.tagext.lang.InvokeArgumentTag k j I	  m (coldfusion/tagext/lang/InvokeArgumentTag o message q setName s ]
 p t ,AssertSame failed when it should have passes v setValue x =
 p y 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z { |
 % } expected  _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; � �
 % � actual � doAfterBody � a coldfusion/tagext/GenericTag �
 � � _popBody =(ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; � �
 % � doEndTag � a
 Y � *coldfusion/runtime/TransientVariableHolder � &(Lcoldfusion/runtime/NeoPageContext;)V  �
 � � 
				 � 
				
			 � unwrap ,(Ljava/lang/Throwable;)Ljava/lang/Throwable; � � coldfusion/runtime/NeoException �
 � � t0 [Ljava/lang/String; java/lang/String � AssertionFailedError � � �	  � findThrowableTarget +(Ljava/lang/Throwable;[Ljava/lang/String;)I � �
 � � CFCATCH � bind '(Ljava/lang/String;Ljava/lang/Object;)V � �
 � � true � unbind � 
 � � _boolean (Ljava/lang/Object;)Z � � coldfusion/runtime/Cast �
 � � fail � *AssertSame failed to assert a simple value � 
		
	 � testSameSimple � metaData Ljava/lang/Object; � �	  � void � public � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returntype � access � 
Parameters � ([Ljava/lang/Object;)V  �
 � � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS EXPECTED EXPECTEDBAD BFAILURETHROWN ACTUAL invoke3 "Lcoldfusion/tagext/lang/InvokeTag; mode3 I invokeargument0 *Lcoldfusion/tagext/lang/InvokeArgumentTag; t17 invokeargument1 t19 invokeargument2 t21 t22 Ljava/lang/Throwable; t23 t24 ,Lcoldfusion/runtime/TransientVariableHolder; invoke6 mode6 invokeargument4 t28 invokeargument5 t30 t31 t32 t33 t34 #Lcoldfusion/runtime/AbortException; t35 Ljava/lang/Exception; __cfcatchThrowable0 t37 t38 invoke8 mode8 invokeargument7 t42 t43 t44 LineNumberTable !coldfusion/runtime/AbortException java/lang/Exception <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       H I    j I    � �    � �           #     *� 
�                 � �     !     ̰                 � �     !     ư                 � �    	  -  �+� :+,� :	+� :
+� :+!� :+#� :-� )� /:-� 3:-5� 9;� A-5� 9
C� A-5� 9C� A-5� 9E� A-G� 9-� S� W� Y:[� _� cY6� �-� g:-i� 9-� n� W� p:r� uw� z� ~� :� ��-i� 9-� n� W� p:�� u-
� �� z� ~� :� ^�-i� 9-� n� W� p:�� u-� �� z� ~� :� $�-5� 9� ���I� � :� �:-� �:�� �� �-G� 9� �Y-� )� �:-i� 9-� S� W� Y:[� _� cY6� �-� g:-�� 9-� n� W� p:�� u-� �� z� ~� :� d� ��-�� 9-� n� W� p:�� u-� �� z� ~� :� '� ��-i� 9� ���y� � :� �: -� �:� � �� :!� p!�-�� 9� b� Q:""�:##� �:$$� �� ��    5           �$� �-�� 9�� A-i� 9� #�� � :%� %�:&� ��&-G� 9-� �� ��� �-i� 9-� S� W� Y:''�� _'� cY6(� q-'(� g:-�� 9-� n'� W� p:))r� u)¶ z)� ~� :*� $*�-i� 9'� ����� � :+� +�:,-(� �:�,'� �� �-5� 9-Ķ 9�  �ms  �hn  ���������  H��      � -  �      � � �   � � �   � � �   � � �   � � �   � � �   � 0 1   � � �   � � � 	  � � � 
  � � �   � � �   � � �   � � �   � � �   � � �   � � �   � � �   � � �   � � �   � � �   � �    � �   �   � �   � �   � �   � �   � �   �	 �   �
    � �    � � !  � "  � #  �  $  �  %  � � &  � � '  � � (  � � )  � � *  �  +  � � ,  * J    B  B  L  J  J  Q  [ 	 Y 	 Y 	 ` 	 j 
 h 
 h 
 o 
 y  w  w  ~  �  �  �  �  �  �  	 	  � # < C C + ]  � � � � � � � � �  4 ; ; # X � � � � � � � � � 	     8 T m  t  \  �  ' � ! � "       v     XK� Q� Sl� Q� n� �Y�S� �� �Y� �Y�SY�SY�SY�SY�SY�SY�SY� �S� ݳ ʱ           X       �     !     ΰ                !"     #     � ��                #$     "     � ʰ                     ����  - � 
SourceFile GD:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\TestTestCase_same.cfc "cfTestTestCase_same2ecfc1299569909  coldfusion/runtime/CFComponent  <init> ()V  
  	 this $LcfTestTestCase_same2ecfc1299569909; LocalVariableTable Code com.macromedia.SourceModTime  ���� coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;   javax/servlet/jsp/PageContext 
   parent Ljavax/servlet/jsp/tagext/Tag;  	    
	 " _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V $ %
  & 	VARIABLES ( java/lang/String * ROOT , ../ . 
ExpandPath &(Ljava/lang/String;)Ljava/lang/String; 0 1 coldfusion/runtime/CFPage 3
 4 2 / 6   8 ReplaceNoCase J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String; : ;
 4 < _structSetAt :(Ljava/lang/String;[Ljava/lang/Object;Ljava/lang/Object;)V > ?
  @ CFUROOT B _resolveAndAutoscalarize 9(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/Object; D E
  F _String &(Ljava/lang/Object;)Ljava/lang/String; H I coldfusion/runtime/Cast K
 L J . N \ P ListChangeDelims R ;
 4 S TSTROOT U concat W 1
 + X /test Z 

	
		
	 \ 
	
	
	
	 ^ 
	
	 ` _factor0 O(Ljavax/servlet/jsp/tagext/Tag;Ljavax/servlet/jsp/JspWriter;)Ljava/lang/Object; b c
  d 
	
 f testSameSimple Lcoldfusion/runtime/UDFMethod; 5cfTestTestCase_same2ecfc1299569909$funcTESTSAMESIMPLE j
 k 	 h i	  m testSameSimple o registerUDF 3(Ljava/lang/String;Lcoldfusion/runtime/UDFMethod;)V q r
  s testSameCFC 2cfTestTestCase_same2ecfc1299569909$funcTESTSAMECFC v
 w 	 u i	  y testSameCFC { testSameQuery 4cfTestTestCase_same2ecfc1299569909$funcTESTSAMEQUERY ~
  	 } i	  � testSameQuery � testSameJavaObject 9cfTestTestCase_same2ecfc1299569909$funcTESTSAMEJAVAOBJECT �
 � 	 � i	  � testSameJavaObject � testSameStruct 5cfTestTestCase_same2ecfc1299569909$funcTESTSAMESTRUCT �
 � 	 � i	  � testSameStruct � metaData Ljava/lang/Object; � �	  � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � TesTestCase_same � extends � 4cfunit.src.net.sourceforge.cfunit.framework.TestCase � Name � TestTestCase_same � 	Functions �	 k �	 w �	  �	 � �	 � � ([Ljava/lang/Object;)V  �
 � � __factorParent out Ljavax/servlet/jsp/JspWriter; value LineNumberTable runPage ()Ljava/lang/Object; <clinit> 
getExtends ()Ljava/lang/String; getMetadata registerUDFs 1       h i    u i    } i    � i    � i    � �           #     *� 
�                 b c    z 
    �*,#� '*)� +Y-S*/� 5*7� 59� =� A*,#� '*)� +YCS*)� +Y-S� G� MOQ� T� A*,#� '*)� +YVS7*)� +Y-S� G� M� Y[� Y� A*,]� '*,_� '*,a� '*,a� '*�       *    �       � �     � � �    � � �  �   � $                          '  :  :  L  N  :  :  .  .  V  i  k  k  i  i  �  i  i  ]  ]  �  � $ � � � �  � �     y     )*� � L*� !N*-+� e� �*+a� '*+g� '�       *    )       ) � �    ) � �    )    �      �   �     �      � 	    �� kY� l� n� wY� x� z� Y� �� �� �Y� �� �� �Y� �� �� �Y� �Y�SY�SY�SY�SY�SY�SY�SY� �Y� �SY� �SY� �SY� �SY� �SS� �� ��           �     �     h  n � t � z � � U  � �     !     ��                 � �     "     � ��                 �      L     .*p� n� t*|� z� t*�� �� t*�� �� t*�� �� t�           .               ����  -D 
SourceFile GD:\wwwroot\cfunit\src\net\sourceforge\cfunit\test\TestTestCase_same.cfc 4cfTestTestCase_same2ecfc1299569909$funcTESTSAMEQUERY  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this 6LcfTestTestCase_same2ecfc1299569909$funcTESTSAMEQUERY; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  	OBJECTBAD  1(Ljava/lang/String;)Lcoldfusion/runtime/Variable;  
   OBJECT  BFAILURETHROWN   coldfusion/runtime/CfJspPage " pageContext #Lcoldfusion/runtime/NeoPageContext; $ %	 # & getOut ()Ljavax/servlet/jsp/JspWriter; ( ) javax/servlet/jsp/PageContext +
 , * parent Ljavax/servlet/jsp/tagext/Tag; . /	 # 0 
		 2 _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V 4 5
 # 6 false 8 set (Ljava/lang/Object;)V : ; coldfusion/runtime/Variable =
 > < 
c1, c2, c3 @ QueryNew /(Ljava/lang/String;)Lcoldfusion/sql/QueryTable; B C coldfusion/runtime/CFPage E
 F D 
		
		 H _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; J K
 # L QueryAddRow (Ljava/lang/Object;I)I N O
 F P c1 R abc T QuerySetCell :(Ljava/lang/Object;Ljava/lang/String;Ljava/lang/Object;I)Z V W
 F X c2 Z def \ c3 ^ ghi ` 123 b 456 d 789 f XXX h &class$coldfusion$tagext$lang$InvokeTag Ljava/lang/Class;  coldfusion.tagext.lang.InvokeTag l forName %(Ljava/lang/String;)Ljava/lang/Class; n o java/lang/Class q
 r p j k	  t _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; v w
 # x  coldfusion/tagext/lang/InvokeTag z 
assertSame | 	setMethod (Ljava/lang/String;)V ~ 
 { � 
doStartTag ()I � �
 { � 	_pushBody _(Ljavax/servlet/jsp/tagext/BodyTag;ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; � �
 # � 
			 � .class$coldfusion$tagext$lang$InvokeArgumentTag (coldfusion.tagext.lang.InvokeArgumentTag � � k	  � (coldfusion/tagext/lang/InvokeArgumentTag � message � setName � 
 � � ,AssertSame failed when it should have passes � setValue � ;
 � � 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Z � �
 # � expected � actual � doAfterBody � � coldfusion/tagext/GenericTag �
 � � _popBody =(ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; � �
 # � doEndTag � �
 { � 

				
		 � *coldfusion/runtime/TransientVariableHolder � &(Lcoldfusion/runtime/NeoPageContext;)V  �
 � � 
				 � 

			
			 � unwrap ,(Ljava/lang/Throwable;)Ljava/lang/Throwable; � � coldfusion/runtime/NeoException �
 � � t0 [Ljava/lang/String; java/lang/String � AssertionFailedError � � �	  � findThrowableTarget +(Ljava/lang/Throwable;[Ljava/lang/String;)I � �
 � � CFCATCH � bind '(Ljava/lang/String;Ljava/lang/Object;)V � �
 � � true � unbind � 
 � � _boolean (Ljava/lang/Object;)Z � � coldfusion/runtime/Cast �
 � � fail � #AssertSame failed to assert a query � 
		
	 � testSameQuery � metaData Ljava/lang/Object; � �	  � void � public � &coldfusion/runtime/AttributeCollection � java/lang/Object � name � 
returntype � access � 
Parameters � ([Ljava/lang/Object;)V  �
 � � getReturnType ()Ljava/lang/String; getName runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value 	ARGUMENTS Lcoldfusion/runtime/Variable; THIS 	OBJECTBAD OBJECT BFAILURETHROWN invoke47 "Lcoldfusion/tagext/lang/InvokeTag; mode47 I invokeargument44 *Lcoldfusion/tagext/lang/InvokeArgumentTag; t16 invokeargument45 t18 invokeargument46 t20 t21 Ljava/lang/Throwable; t22 t23 ,Lcoldfusion/runtime/TransientVariableHolder; invoke50 mode50 invokeargument48 t27 invokeargument49 t29 t30 t31 t32 t33 #Lcoldfusion/runtime/AbortException; t34 Ljava/lang/Exception; __cfcatchThrowable4 t36 t37 invoke52 mode52 invokeargument51 t41 t42 t43 LineNumberTable !coldfusion/runtime/AbortException: java/lang/Exception< <clinit> 	getAccess getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       j k    � k    � �    � �           #     *� 
�                 � �     !     �                  �     !     �                    
G  ,  +� :+,� :	+� :
+� :+!� :-� '� -:-� 1:-3� 79� ?-3� 7-A� G� ?-3� 7
-A� G� ?-I� 7--� M� QW-3� 7--
� M� QW-I� 7--� MSU� YW-3� 7--� M[]� YW-3� 7--� M_a� YW-3� 7--� MSc� YW-3� 7--� M[e� YW-3� 7--� M_g� YW-I� 7--
� MSU� YW-3� 7--
� M[]� YW-3� 7--
� M_a� YW-3� 7--
� MSc� YW-3� 7--
� M[e� YW-3� 7--
� M_i� YW-I� 7-� u� y� {:}� �� �Y6� �-� �:-�� 7-� �� y� �:�� ��� �� �� :� ��-�� 7-� �� y� �:�� �-� M� �� �� :� ^�-�� 7-� �� y� �:�� �-� M� �� �� :� $�-3� 7� ���I� � :� �:-� �:�� �� �-�� 7� �Y-� '� �:-�� 7-� u� y� {:}� �� �Y6� �-� �:-�� 7-� �� y� �:�� �-
� M� �� �� :� d� ��-�� 7-� �� y� �:�� �-� M� �� �� :� '� ��-�� 7� ���y� � :� �:-� �:�� �� : � o �-�� 7� a� P:!!�:""� �:##� ɸ ͪ   4           �#� �-�� 7ն ?-�� 7� "�� � :$� $�:%� ة%-I� 7-� M� ��� �-�� 7-� u� y� {:&&� �&� �Y6'� q-&'� �:-�� 7-� �&� y� �:((�� �(� �(� �� :)� $)�-�� 7&� ����� � :*� *�:+-'� �:�+&� �� �-3� 7-� 7� ���  ��  ���;���=�-0  ���      � ,            �      	   
    �    . /       	   
                  �       �       �        �   !"   #   $   %   & �   '   ( �   )   * �   + �    ,- !  ./ "  0 #  1 $  2 � %  3 &  4 '  5 (  6 � )  7 *  8 � +9  : �   � : � : � D � B � B � I � T � S � Q � Q � \ � g � f � d � d � o � x � x � ~ � w � w � w � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � � �  �  � � � �
 � � � � � � � � � � �  �  �" � � � �' �0 �0 �6 �8 �8 �: �/ �/ �/ �? �H �H �N �P �P �R �G �G �G �W �` �` �f �h �h �j �_ �_ �_ �o �x �x �~ �� �� �� �w �w �w �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� �� � � �� �" �; �B �B �* �\ �u �| �| �d �� �� �� �� �� � �0 �7 �7 � �T �m �t �t �\ �� �� �� � � � � � � �� �A �I �I �I �W �p �� �� �� �� �� �_ �� �I � � >      v     Xm� s� u�� s� �� �Y�S� ɻ �Y� �Y�SY�SY�SY�SY�SY�SY�SY� �S� �� �           X     ? �     !     �                @A     #     � Ű                BC     "     � �                     