����  -� 
SourceFile �E:\cf8_final\cfusion\wwwroot\CFIDE\scripts\ajax\FCKeditor\editor\dialog\fck_spellerpages\spellerpages\server-scripts\spellchecker.cfm cfspellchecker2ecfm1636164541  coldfusion/runtime/CFPage  <init> ()V  
  	 this Lcfspellchecker2ecfm1636164541; LocalVariableTable Code bindPageVariables D(Lcoldfusion/runtime/VariableScope;Lcoldfusion/runtime/LocalScope;)V   coldfusion/runtime/CfJspPage 
   LANG Lcoldfusion/runtime/Variable;  bindPageVariable r(Ljava/lang/String;Lcoldfusion/runtime/VariableScope;Lcoldfusion/runtime/LocalScope;)Lcoldfusion/runtime/Variable;  
    	   ASPELL_OPTS   	    CHRLF " " 	  $ WRDSLIST & & 	  ( 
SPELLERCSS * * 	  , WORD_WIN_SRC . . 	  0 WORD_CNT 2 2 	  4 SUBMITTED_TEXT 6 6 	  8 TEMPFILE : : 	  < CNT > > 	  @ BAD_WORD B B 	  D 
APSELL_DIR F F 	  H LASTINDEXOF J J 	  L 	INPUT_CNT N N 	  P TEXT R R 	  T LINE V V 	  X IDX Z Z 	  \ CRLF ^ ^ 	  ` WRDLIST b b 	  d I f f 	  h FOOD j j 	  l URL n n 	  p FORM r r 	  t LIST v v 	  x FIELD z z 	  | 
TEMPFOLDER ~ ~ 	  � TEXTS � � 	  � UNALTERED_TEXT � � 	  � com.macromedia.SourceModTime  ��` pageContext #Lcoldfusion/runtime/NeoPageContext; � �	  � getOut ()Ljavax/servlet/jsp/JspWriter; � � javax/servlet/jsp/PageContext �
 � � parent Ljavax/servlet/jsp/tagext/Tag; � �	  � $class$coldfusion$tagext$io$SilentTag Ljava/lang/Class; coldfusion.tagext.io.SilentTag � forName %(Ljava/lang/String;)Ljava/lang/Class; � � java/lang/Class �
 � � � �	  � _initTag P(Ljava/lang/Class;ILjavax/servlet/jsp/tagext/Tag;)Ljavax/servlet/jsp/tagext/Tag; � �
  � coldfusion/tagext/io/SilentTag � _setCurrentLineNo (I)V � �
  � 
doStartTag ()I � �
 � � 	_pushBody _(Ljavax/servlet/jsp/tagext/BodyTag;ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter; � �
  � c:\aspell\bin � set (Ljava/lang/Object;)V � � coldfusion/runtime/Variable �
 � � en_US � java/lang/StringBuffer � 
-a --lang= � (Ljava/lang/String;)V  �
 � � _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; � �
  � _String &(Ljava/lang/Object;)Ljava/lang/String; � � coldfusion/runtime/Cast �
 � � append ,(Ljava/lang/String;)Ljava/lang/StringBuffer; � �
 � �  --encoding=utf-8 -H � toString ()Ljava/lang/String; � � java/lang/Object �
 � � c:\aspell\temp � spell_ � 	RandRange (II)I � �
  � (I)Ljava/lang/String; � �
 � � concat &(Ljava/lang/String;)Ljava/lang/String; � � java/lang/String �
 � � ../spellerStyle.css � ../wordWindow.js � 	CHECKTEXT � textinputs[] � _arrayGetAt 8(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object; � �
  � _structSetAt :(Ljava/lang/String;[Ljava/lang/Object;Ljava/lang/Object;)V � �
  � URL.CHECKTEXT   checkSimpleParameter V(Lcoldfusion/runtime/Variable;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)V
  FORM.CHECKTEXT	 _resolveAndAutoscalarize 9(Ljava/lang/String;[Ljava/lang/String;)Ljava/lang/Object;
  %u201C,%u201D %22,%22 ReplaceList J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
  
 , P(Ljava/lang/String;Lcoldfusion/runtime/LocalScope;)Lcoldfusion/runtime/Variable; 
  java/util/StringTokenizer '(Ljava/lang/String;Ljava/lang/String;)V  
! 	nextToken# �
$ %& ^A( !* 	URLDecode, �
 - ^/ JSStringFormat1 �
 2 Trim4 �
 5 CFLOOP7 checkRequestTimeout9 �
 : hasMoreTokens ()Z<=
> "class$coldfusion$tagext$io$FileTag coldfusion.tagext.io.FileTagA@ �	 C coldfusion/tagext/io/FileTagE cffileG actionI writeK _validateTagAttrValueM
 N 	setActionP �
FQ outputS J(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;MU
 V 	setOutputX �
FY charset[ utf-8] 
setCharset_ �
F` fileb \d .txtf setFileh �
Fi 	_emptyTag !(Ljavax/servlet/jsp/tagext/Tag;)Zkl
 m (class$coldfusion$tagext$lang$ImportedTag "coldfusion.tagext.lang.ImportedTagpo �	 r "coldfusion/tagext/lang/ImportedTagt savecontentv /WEB-INF/cftagsx setName :(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Z)Vz{
u| food~ cfsavecontent� variable� &coldfusion/runtime/AttributeCollection� ([Ljava/lang/Object;)V �
�� setAttributecollection (Ljava/util/Map;)V��  coldfusion/tagext/lang/ModuleTag�
�� 	hasEndTag (Z)V��
��
� � _whitespace %(Ljava/io/Writer;Ljava/lang/String;)V��
 � 'class$coldfusion$tagext$lang$ExecuteTag !coldfusion.tagext.lang.ExecuteTag�� �	 � !coldfusion/tagext/lang/ExecuteTag� 	cfexecute� name� C:\WINDOWS\SYSTEM32\cmd.exe�z �
�� timeout� 100� _int (Ljava/lang/String;)I��
 �� ((Ljava/lang/String;Ljava/lang/String;I)IM�
 � 
setTimeout� �
�� 	arguments� /c type � .txt | � \aspell � setArguments� �
��
� � doAfterBody� � coldfusion/tagext/GenericTag�
�� doEndTag� � #javax/servlet/jsp/tagext/TagSupport�
��
�� _popBody =(ILjavax/servlet/jsp/JspWriter;)Ljavax/servlet/jsp/JspWriter;��
 � doCatch (Ljava/lang/Throwable;)V��
�� 	doFinally� 
�� delete� 	StructNew !()Lcoldfusion/util/FastHashtable;��
 � 
TEXTINPUTS� E(Lcoldfusion/runtime/Variable;[Ljava/lang/Object;Ljava/lang/Object;)V ��
 � WORDS� ABORT� 0� D(Lcoldfusion/runtime/Variable;[Ljava/lang/String;)Ljava/lang/Object;�
 � textinputs[� ] = decodeURIComponent("� ");� 
ListAppend�
 � _double (Ljava/lang/Object;)D��
 �� _Object (D)Ljava/lang/Object;��
 �� 1� -1� 
  _compare (Ljava/lang/Object;D)D
  & Find '(Ljava/lang/String;Ljava/lang/String;)I	
 
 (I)Ljava/lang/Object;�
 � _boolean (Ljava/lang/Object;)Z
 � #   	ListGetAt 9(Ljava/lang/String;ILjava/lang/String;)Ljava/lang/String;
  _get �
  LastIndexOf :  
_invokeUDF f(Ljava/lang/Object;Ljava/lang/String;Lcoldfusion/runtime/CFPage;[Ljava/lang/Object;)Ljava/lang/Object;"#
 $@        (D)I�(
 �) Len (Ljava/lang/Object;)I+,
 - Mid ((Ljava/lang/String;II)Ljava/lang/String;/0
 1  '3 '5 \'7 All9 Replace \(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;;<
 = , ? Right '(Ljava/lang/String;I)Ljava/lang/String;AB
 C words[E ][G ] = 'I ';K suggs[M ] = [O ];Q *S (D)ZU
 �V ] = [];X '(Ljava/lang/Object;Ljava/lang/String;)DZ
 [ 9alert('Spell check complete.\n\nNo misspellings found.');] top.window.close();_ $class$coldfusion$tagext$io$OutputTag coldfusion.tagext.io.OutputTagba �	 d coldfusion/tagext/io/OutputTagf
g � &class$coldfusion$tagext$net$ContentTag  coldfusion.tagext.net.ContentTagji �	 l  coldfusion/tagext/net/ContentTagn 	cfcontentp typer 	text/htmlt setTypev �
ow �<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="yK � java/io/Writer|
}{ )" />
<script language="javascript" src=" �"></script>
<script language="javascript">
var suggs = new Array();
var words = new Array();
var textinputs = new Array();
var error;

� � 
��

var wordWindowObj = new wordWindow();
wordWindowObj.originalSpellings = words;
wordWindowObj.suggestions = suggs;
wordWindowObj.textInputs = textinputs;

function init_spell() {
	// check if any error occured during server-side processing
	if( error ) {
		alert( error );
	} else {
		// call the init_spell() function in the parent frameset
		if (parent.frames.length) {
			parent.init_spell( wordWindowObj );
		} else {
			alert('This page was loaded outside of a frameset. It might not display properly');
		}
	}
}

</script>

</head>
<body onLoad="init_spell();">

<script type="text/javascript">
wordWindowObj.writeBody();
</script>

</body>
</html>�
g� coldfusion/tagext/QueryLoop�
��
��
g� Lcoldfusion/runtime/UDFMethod; -cfspellchecker2ecfm1636164541$funcLASTINDEXOF�
� 	�	 � registerUDF 3(Ljava/lang/String;Lcoldfusion/runtime/UDFMethod;)V��
 � metaData Ljava/lang/Object;��	 � 	Functions�	�� varscope "Lcoldfusion/runtime/VariableScope; locscope Lcoldfusion/runtime/LocalScope; runPage ()Ljava/lang/Object; out Ljavax/servlet/jsp/JspWriter; value silent6  Lcoldfusion/tagext/io/SilentTag; mode6 t6 Ljava/lang/String; t7 t8 t9 Ljava/util/StringTokenizer; t10 t11 t12 t13 file2 Lcoldfusion/tagext/io/FileTag; t15 module4 $Lcoldfusion/tagext/lang/ImportedTag; t17 mode4 execute3 #Lcoldfusion/tagext/lang/ExecuteTag; mode3 t21 t22 Ljava/lang/Throwable; t23 t24 t25 t26 t27 file5 t29 t30 t31 t32 t33 t34 t35 t36 t37 t38 t39 t40 t41 t42 t43 output8  Lcoldfusion/tagext/io/OutputTag; mode8 content7 "Lcoldfusion/tagext/net/ContentTag; t47 t48 t49 t50 t51 LineNumberTable java/lang/Throwable� <clinit> getMetadata registerUDFs 1     $            "     &     *     .     2     6     :     >     B     F     J     N     R     V     Z     ^     b     f     j     n     r     v     z     ~     �     �     � �   @ �   o �   � �   a �   i �   �   ��           #     *� 
�                      �    W*+,� **+,� � **+,� � !**#+,� � %**'+,� � )**++,� � -**/+,� � 1**3+,� � 5**7+,� � 9**;+,� � =**?+,� � A**C+,� � E**G+,� � I**K+,� � M**O+,� � Q**S+,� � U**W+,� � Y**[+,� � ]**_+,� � a**c+,� � e**g+,� � i**k+,� � m**o+,� � q**s+,� � u**w+,� � y**{+,� � }**+,� � �**�+,� � �**�+,� � ��           W      W��   W��  ��    o  4  �*� �� �L*� �N*� �-� �� �:*� �� �Y6�*+� �L*� I�� �*� ¶ �*� !� �YƷ �**� � ͸ Ӷ �ٶ ׶ ߶ �*� �� �*� =�*� �*'� � � � �*� -� �*� 1�� �*s� �Y�S*s�� �� **� q��**� u�
*o� �Y�S��*� 9*'� �*s� �Y�S�� ��� �*� U� �*� a� �**� 9� ͸ �::*{�:�Y�":	�	�%M,� �*� U**� U� ͸ �'� �**� a� ͸ Ӷ �)� �**� a� ͸ Ӷ �+� �**� a� ͸ Ӷ � �*� }*3� �***� }� ͸ Ӷ.� �**� }� ͸ �:
**� a� ͸ �:*W�:�Y
�":� [�%M,� �*� U**� U� ͸ �0� �*7� �*7� �**� Y� ͸ Ӹ3�6� �**� a� ͸ Ӷ � �8�;�?���8�;	�?���*� �**� 9� Ͷ �*�D� ��F:*@� �HJL�O�RHT**� U� ͸W�ZH\^�O�aHc� �Y**� �� ͸ ӷ �e� �**� =� ͸ Ӷ �g� ׶ ߸O�j�n� :�*�*�s� ��u:*H� �wy�}:���WW��Y� �Y�SYS��������Y6�	*+� �L*+��*��� ���:*I� �����O�������������� �Y�� �**� �� ͸ Ӷ �e� �**� =� ͸ Ӷ ��� �**� I� ͸ Ӷ ��� �**� !� ͸ Ӷ ׶ ߸W����Y6� �Ś����� :� *� e���*+���˚�!� � :� �:*+��L���� :� &���� � #:�Ө � :� �:�֩*�D� ��F:*O� �HJظO�RHc� �Y**� �� ͸ ӷ �e� �**� =� ͸ Ӷ �g� ׶ ߸O�j�n� :��*� �*Q� ��ܶ �**� �� �Y�S��**� �� �Y�S��**� �� �Y�S��*� i� �*s� �Y�S�� �::*S�: �Y�":!� �!�%M ,� �**� �� �Y�S*Z� �**� �� �Y�S�� ӻ �Y� �**� i� ͸ Ӷ �� �**� U� ͸ Ӷ �� ׶ ����*� i**� i� ͸�c��� �8�;!�?��j*� A�� �*� 5� �*� Q�� �**� m� ͸ �:":#*w�:$�Y"#�":%�8%�%M$,� �**� A� ���~����*f� �**� y� ͸ Ӹ�Y�� W*f� �**� y� ͸ Ӹ����*� E*h� �**� y� ͸ ��� �*� e*j� �**� y� ͸ �*j� �**� M�*� �Y!SY**� y� �S�%��&c�**j� �**� y� ͸.�*j� �**� M�*� �Y!SY**� y� �S�%��&cg�*�2� �*� )� �**� e� ͸ �:&:'*[�:(�Y&'�":)� e)�%M(,� �*� )*m� �**� )� ͸ �4*m� �*m� �**� ]� ͸ �68:�>�6� �6� �@�� �8�;)�?���*� )*o� �**� )� ͸ �*o� �**� )� ͸.�g�*�D� �**� �� �Y�S*q� �**� �� �Y�S�� ӻ �YF� �**� Q� ͸ Ӷ �H� �**� 5� ͸ Ӷ �J� �*q� �*q� �**� E� ͸ �68:�>�6� �L� ׶ ����**� �� �Y�S*r� �**� �� �Y�S�� ӻ �YN� �**� Q� ͸ Ӷ �H� �**� 5� ͸ Ӷ �P� �*r� �**� )� ͸ Ӹ6� �R� ׶ ����*� 5**� 5� ͸�c��� �� �*t� �T**� y� ͸ Ӹ��W� �*� Q**� Q� ͸�c��� �*� 5� �**� �� �Y�S*w� �**� �� �Y�S�� ӻ �YF� �**� Q� ͸ Ӷ �Y� ׶ �**� a� ͸ Ӹ��**� �� �Y�S*x� �**� �� �Y�S�� ӻ �YN� �**� Q� ͸ Ӷ �Y� ׶ �**� a� ͸ Ӹ��*� A**� A� ͸�c��� �8�;%�?���**� �� �Y�S���\�� 6**� �� �Y�S� �Y^� �**� %� ͸ Ӷ �`� ׶ ߶��Ś�� � :*� *�:+*+��L�+��� �*�e-� ��g:,* �� �,�hY6-� �*�m,� ��o:.* �� �.qsu�O�x.�n� :/� �/�+z�~+**� -� ͸ Ӷ~+��~+**� 1� ͸ Ӷ~+��~+**� �� �Y�S�� Ӷ~+��~+��~*+��+**� �� �Y�S�� Ӷ~*+��+**� �� �Y�S�� Ӷ~+��~,����,��� :0� #0�� � #:1,1��� � :2� 2�:3,���3*+��� p\b  e���e��   ,'-  bci�brx      
 4  �      ���   ���   � � �   ���   �� f   ���   ���   ��    ��� 	  ��� 
  ���   ��    ���   ���   ���   ���   ���   �� f   ���   �� f   ���   ���   ���   ���   ���   ���   ���   ���   ���   ���   ���   ��     ��� !  ��� "  ��� #  ��  $  ��� %  ��� &  ��� '  ��  (  ��� )  ��� *  ��� +  ��� ,  �� f -  ��� .  ��� /  ��� 0  ��� 1  ��� 2  ��� 3�  �� :  :  6  6  C  C  ?  ?  P  U  U  c  L  L  H  H  r  r  n  n  {  �  �  �  �  {  {  w  w  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  �  � % � % �  �  �  �  �  � & � & � & �  � ' � ' ' ' � ' � ' � ' � ' , , , , - - - -% /% /2 /` 0` 0k 0` 0` 0q 0q 0` 0` 0 1` 1` 1� 1� 1` 1` 1� 2` 2` 2� 2� 2` 2` 2\ 0\ 0� 3� 3� 3� 3� 3� 3� 4� 4� 4� 4	 7	 7 7	 7	 7& 7& 7& 7& 7& 7& 7	 7	 7: 7: 7: 7	 7	 7 7 7V 4� 4d /% /k =k =g =g =� @� @� @� @� @� @� @� @� @� @� @v @3 H� I� I� I� I� I� I� I� I� I� I� I I
 I
 I� I� I H� O� O� O� O� O� O O� O� O/ Q/ Q% Q% QD RD R5 R5 RY SY SJ SJ Sn Tn T_ T_ Tx Xx Xt Xt X~ Y~ Y� Z� Z� Z� Z� Z� Z Z Z Z� Z� Z Z� Z� Z� Z� Z( [( [3 [( [( [$ [$ [F Y~ YM `M `I `I `W aW aS aS aa ba b] b] bg cg ct c� e� e� e� e� e� f� f� f� f� f� f� f� f� f� f� f h h h h h h� h� h  j  j1 jC jI j1 j1 jX j1 j1 je je je je jw j� j� jw jw j� jw jw je je j  j  j j j� k� k� k� k� l� l� m� m m m m m m" m m m m m m m. m m m4 m� m� m� m� mH l� lU oU of of of of or of of oU oU oK oK o� q� q� q� q� q� q� q� q� q� q� q� q� q� q� q� q� q� q	 q� q� q	 q� q� q} q} q	) r	) r	B r	H r	H r	V r	\ r	\ r	j r	v r	v r	v r	v r	� r	> r	> r	� r	) r	) r	 r	 r	� s	� s	� s	� s	� s	� s	� s	� t	� t	� t	� t	� u	� u	� u	� u	� u	� u	� u	� v	� v	� v	� v
 w
 w
  w
& w
& w
4 w
 w
 w
= w
= w
= w
 w
 w	� w	� w
c x
c x
| x
� x
� x
� x
x x
x x
� x
� x
� x
c x
c x
N x
N x	� t� f� e
� {
� {
� {
� {
� {
� {
� {
� cg c
� ~
� ~
�    
� 
� 
� 
� 
� ~  � �m �� �� �� �� �� �� �� �� �� �� �� �� �� �	 �	 � �* �* �) �L �    �      � 	    a�� �� �B� ��Dq� ��s�� ���c� ��ek� ��m��Y������Y� �Y�SY� �Y��SS�����           a    �     U  ��     "     ���                �      (     
*K�����           
           �    �����  - � 
SourceFile �E:\cf8_final\cfusion\wwwroot\CFIDE\scripts\ajax\FCKeditor\editor\dialog\fck_spellerpages\spellerpages\server-scripts\spellchecker.cfm -cfspellchecker2ecfm1636164541$funcLASTINDEXOF  coldfusion/runtime/UDFMethod  <init> ()V  
  	 this /Lcfspellchecker2ecfm1636164541$funcLASTINDEXOF; LocalVariableTable Code 	ARGUMENTS  bindInternal C(Ljava/lang/String;Ljava/lang/Object;)Lcoldfusion/runtime/Variable;   coldfusion/runtime/LocalScope 
   THIS  coldfusion/runtime/CfJspPage  pageContext #Lcoldfusion/runtime/NeoPageContext;  	   getOut ()Ljavax/servlet/jsp/JspWriter;    javax/servlet/jsp/PageContext "
 # ! parent Ljavax/servlet/jsp/tagext/Tag; % &	  ' SUBS ) getVariable  (I)Lcoldfusion/runtime/Variable; + , %coldfusion/runtime/ArgumentCollection .
 / - _validateArg a(Ljava/lang/String;ZLjava/lang/String;Lcoldfusion/runtime/Variable;)Lcoldfusion/runtime/Variable; 1 2
  3 putVariable  (Lcoldfusion/runtime/Variable;)V 5 6
  7 STR 9 _setCurrentLineNo (I)V ; <
  = _autoscalarize 1(Lcoldfusion/runtime/Variable;)Ljava/lang/Object; ? @
  A Len (Ljava/lang/Object;)I C D coldfusion/runtime/CFPage F
 G E _String &(Ljava/lang/Object;)Ljava/lang/String; I J coldfusion/runtime/Cast L
 M K Reverse &(Ljava/lang/String;)Ljava/lang/String; O P
 G Q Find '(Ljava/lang/String;Ljava/lang/String;)I S T
 G U _Object (D)Ljava/lang/Object; W X
 M Y java/lang/String [ LastIndexOf ] metaData Ljava/lang/Object; _ `	  a &coldfusion/runtime/AttributeCollection c java/lang/Object e Name g 
Parameters i REQUIRED k true m NAME o ([Ljava/lang/Object;)V  q
 d r getName ()Ljava/lang/String; runFunction �(Lcoldfusion/runtime/LocalScope;Ljava/lang/Object;Lcoldfusion/runtime/CFPage;Lcoldfusion/runtime/ArgumentCollection;)Ljava/lang/Object; __localScope Lcoldfusion/runtime/LocalScope; instance 
parentPage Lcoldfusion/runtime/CFPage; __arguments 'Lcoldfusion/runtime/ArgumentCollection; out Ljavax/servlet/jsp/JspWriter; value Lcoldfusion/runtime/Variable; LineNumberTable <clinit> getParamList ()[Ljava/lang/String; getMetadata ()Ljava/lang/Object; 1       _ `           #     *� 
�                 t u     !     ^�                 v w    p     �+� :+,� :	-� � $:-� (:**� 0� 4:
+
� 8*:� 0� 4:+� 8- � >-� B� H�- � >-
� B� N- � >-� B� N� R� V�gc� Z��       z    �       � x y    � z `    � { |    � } ~    �  �    � � `    � % &    �  �    �  � 	   � ) � 
   � 9 �  �   R     2  T   T   T   T   d   d   s   s   s   s   d   d   T   T   �   T   T   T    �      �     i� dY� fYhSY^SYjSY� fY� dY� fYlSYnSYpSY*S� sSY� dY� fYlSYnSYpSY:S� sSS� s� b�           i      � �     -     � \Y*SY:S�                 � �     "     � b�                     