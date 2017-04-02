*------------------------------------------------------------*;
* EndGrp: ;
* User: Divya;
* Date: 23NOV16: 03:23;
*------------------------------------------------------------* ;
* Ensemble Code;
*------------------------------------------------------------* ;
* Bagging: Loop=1;
* Temporary Variables;
drop _BagVar1;
_BagVar1 = 0;
drop _BagVar2;
_BagVar2 = 0;
*------------------------------------------------------------*;
* Grp: StartGroup;
* User: Divya;
* Date: 23NOV16: 03:23;
* Bagging: Loop=1;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Tree5: DecisionTree;
* User: Divya;
* Date: 23NOV16: 03:23;
* Bagging: Loop=1;
*------------------------------------------------------------*;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Contributed_To_Accident  $    3;
LENGTH I_Contributed_To_Accident  $    3;
LENGTH U_Contributed_To_Accident  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Contributed_To_AccidentYes =
'Predicted: Contributed_To_Accident=Yes' ;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
label Q_Contributed_To_AccidentYes =
'Unadjusted P: Contributed_To_Accident=Yes' ;
label Q_Contributed_To_AccidentNo =
'Unadjusted P: Contributed_To_Accident=No' ;
label V_Contributed_To_AccidentYes =
'Validated: Contributed_To_Accident=Yes' ;
label V_Contributed_To_AccidentNo = 'Validated: Contributed_To_Accident=No' ;
label R_Contributed_To_AccidentYes = 'Residual: Contributed_To_Accident=Yes' ;
label R_Contributed_To_AccidentNo = 'Residual: Contributed_To_Accident=No' ;
label F_Contributed_To_Accident = 'From: Contributed_To_Accident' ;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident =
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( Contributed_To_Accident , $3.);
 %DMNORMCP( _ARBFMT_3, F_Contributed_To_Accident );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('3' ) THEN DO;
  _NODE_  =                    3;
  _LEAF_  =                    4;
  P_Contributed_To_AccidentYes  =     0.96969696969696;
  P_Contributed_To_AccidentNo  =     0.03030303030303;
  Q_Contributed_To_AccidentYes  =     0.96969696969696;
  Q_Contributed_To_AccidentNo  =     0.03030303030303;
  V_Contributed_To_AccidentYes  =      0.2156862745098;
  V_Contributed_To_AccidentNo  =     0.78431372549019;
  I_Contributed_To_Accident  = 'YES' ;
  U_Contributed_To_Accident  = 'Yes' ;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( GRP_Personal_Injury , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('3' ) THEN DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Contributed_To_AccidentYes  =      0.9763779527559;
    P_Contributed_To_AccidentNo  =     0.02362204724409;
    Q_Contributed_To_AccidentYes  =      0.9763779527559;
    Q_Contributed_To_AccidentNo  =     0.02362204724409;
    V_Contributed_To_AccidentYes  =                    0;
    V_Contributed_To_AccidentNo  =                    0;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
    END;
  ELSE DO;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
      _NODE_  =                    7;
      _LEAF_  =                    2;
      P_Contributed_To_AccidentYes  =     0.18579234972677;
      P_Contributed_To_AccidentNo  =     0.81420765027322;
      Q_Contributed_To_AccidentYes  =     0.18579234972677;
      Q_Contributed_To_AccidentNo  =     0.81420765027322;
      V_Contributed_To_AccidentYes  =     0.00302343159486;
      V_Contributed_To_AccidentNo  =     0.99697656840514;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    ELSE DO;
      _NODE_  =                    6;
      _LEAF_  =                    1;
      P_Contributed_To_AccidentYes  =     0.38775510204081;
      P_Contributed_To_AccidentNo  =     0.61224489795918;
      Q_Contributed_To_AccidentYes  =     0.38775510204081;
      Q_Contributed_To_AccidentNo  =     0.61224489795918;
      V_Contributed_To_AccidentYes  =     0.02827289489858;
      V_Contributed_To_AccidentNo  =     0.97172710510141;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Contributed_To_Accident  NE 'YES'
AND F_Contributed_To_Accident  NE 'NO'  THEN DO;
        R_Contributed_To_AccidentYes  = .;
        R_Contributed_To_AccidentNo  = .;
 END;
 ELSE DO;
       R_Contributed_To_AccidentYes  =  -P_Contributed_To_AccidentYes ;
       R_Contributed_To_AccidentNo  =  -P_Contributed_To_AccidentNo ;
       SELECT( F_Contributed_To_Accident  );
          WHEN( 'YES'  ) R_Contributed_To_AccidentYes  =
        R_Contributed_To_AccidentYes  +1;
          WHEN( 'NO'  ) R_Contributed_To_AccidentNo  =
        R_Contributed_To_AccidentNo  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp: EndGroup;
* User: Divya;
* Date: 23NOV16: 03:23;
* Bagging: Loop=1;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Bagging: Saving Probabilities for Next Iteration;
*------------------------------------------------------------*;
_BagVar1 = P_Contributed_To_AccidentYes;
_BagVar2 = P_Contributed_To_AccidentNo;
*------------------------------------------------------------*;
* Grp: StartGroup;
* User: Divya;
* Date: 23NOV16: 03:23;
* Bagging: Loop=2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Tree5: DecisionTree;
* User: Divya;
* Date: 23NOV16: 03:23;
* Bagging: Loop=2;
*------------------------------------------------------------*;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Contributed_To_Accident  $    3;
LENGTH I_Contributed_To_Accident  $    3;
LENGTH U_Contributed_To_Accident  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Contributed_To_AccidentYes =
'Predicted: Contributed_To_Accident=Yes' ;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
label Q_Contributed_To_AccidentYes =
'Unadjusted P: Contributed_To_Accident=Yes' ;
label Q_Contributed_To_AccidentNo =
'Unadjusted P: Contributed_To_Accident=No' ;
label V_Contributed_To_AccidentYes =
'Validated: Contributed_To_Accident=Yes' ;
label V_Contributed_To_AccidentNo = 'Validated: Contributed_To_Accident=No' ;
label R_Contributed_To_AccidentYes = 'Residual: Contributed_To_Accident=Yes' ;
label R_Contributed_To_AccidentNo = 'Residual: Contributed_To_Accident=No' ;
label F_Contributed_To_Accident = 'From: Contributed_To_Accident' ;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident =
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( Contributed_To_Accident , $3.);
 %DMNORMCP( _ARBFMT_3, F_Contributed_To_Accident );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( GRP_Personal_Injury , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('3' ) THEN DO;
  _NODE_  =                    3;
  _LEAF_  =                    4;
  P_Contributed_To_AccidentYes  =     0.98561151079136;
  P_Contributed_To_AccidentNo  =     0.01438848920863;
  Q_Contributed_To_AccidentYes  =     0.98561151079136;
  Q_Contributed_To_AccidentNo  =     0.01438848920863;
  V_Contributed_To_AccidentYes  =                    0;
  V_Contributed_To_AccidentNo  =                    0;
  I_Contributed_To_Accident  = 'YES' ;
  U_Contributed_To_Accident  = 'Yes' ;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('3' ) THEN DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Contributed_To_AccidentYes  =     0.93421052631578;
    P_Contributed_To_AccidentNo  =     0.06578947368421;
    Q_Contributed_To_AccidentYes  =     0.93421052631578;
    Q_Contributed_To_AccidentNo  =     0.06578947368421;
    V_Contributed_To_AccidentYes  =      0.2156862745098;
    V_Contributed_To_AccidentNo  =     0.78431372549019;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
    END;
  ELSE DO;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
      _NODE_  =                    7;
      _LEAF_  =                    2;
      P_Contributed_To_AccidentYes  =     0.15028901734104;
      P_Contributed_To_AccidentNo  =     0.84971098265895;
      Q_Contributed_To_AccidentYes  =     0.15028901734104;
      Q_Contributed_To_AccidentNo  =     0.84971098265895;
      V_Contributed_To_AccidentYes  =     0.00302343159486;
      V_Contributed_To_AccidentNo  =     0.99697656840514;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    ELSE DO;
      _NODE_  =                    6;
      _LEAF_  =                    1;
      P_Contributed_To_AccidentYes  =     0.34456928838951;
      P_Contributed_To_AccidentNo  =     0.65543071161048;
      Q_Contributed_To_AccidentYes  =     0.34456928838951;
      Q_Contributed_To_AccidentNo  =     0.65543071161048;
      V_Contributed_To_AccidentYes  =     0.02827289489858;
      V_Contributed_To_AccidentNo  =     0.97172710510141;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Contributed_To_Accident  NE 'YES'
AND F_Contributed_To_Accident  NE 'NO'  THEN DO;
        R_Contributed_To_AccidentYes  = .;
        R_Contributed_To_AccidentNo  = .;
 END;
 ELSE DO;
       R_Contributed_To_AccidentYes  =  -P_Contributed_To_AccidentYes ;
       R_Contributed_To_AccidentNo  =  -P_Contributed_To_AccidentNo ;
       SELECT( F_Contributed_To_Accident  );
          WHEN( 'YES'  ) R_Contributed_To_AccidentYes  =
        R_Contributed_To_AccidentYes  +1;
          WHEN( 'NO'  ) R_Contributed_To_AccidentNo  =
        R_Contributed_To_AccidentNo  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp: EndGroup;
* User: Divya;
* Date: 23NOV16: 03:23;
* Bagging: Loop=2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Bagging: accumulate probabilities for iteration: 2;
*------------------------------------------------------------*;
P_Contributed_To_AccidentYes = _BagVar1*(1/2) + P_Contributed_To_AccidentYes*(1/2);
P_Contributed_To_AccidentNo = _BagVar2*(1/2) + P_Contributed_To_AccidentNo*(1/2);
*------------------------------------------------------------*;
* Bagging: Saving Probabilities for Next Iteration;
*------------------------------------------------------------*;
_BagVar1 = P_Contributed_To_AccidentYes;
_BagVar2 = P_Contributed_To_AccidentNo;
*------------------------------------------------------------*;
* Grp: StartGroup;
* User: Divya;
* Date: 23NOV16: 03:24;
* Bagging: Loop=3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Tree5: DecisionTree;
* User: Divya;
* Date: 23NOV16: 03:24;
* Bagging: Loop=3;
*------------------------------------------------------------*;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Contributed_To_Accident  $    3;
LENGTH I_Contributed_To_Accident  $    3;
LENGTH U_Contributed_To_Accident  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Contributed_To_AccidentYes =
'Predicted: Contributed_To_Accident=Yes' ;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
label Q_Contributed_To_AccidentYes =
'Unadjusted P: Contributed_To_Accident=Yes' ;
label Q_Contributed_To_AccidentNo =
'Unadjusted P: Contributed_To_Accident=No' ;
label V_Contributed_To_AccidentYes =
'Validated: Contributed_To_Accident=Yes' ;
label V_Contributed_To_AccidentNo = 'Validated: Contributed_To_Accident=No' ;
label R_Contributed_To_AccidentYes = 'Residual: Contributed_To_Accident=Yes' ;
label R_Contributed_To_AccidentNo = 'Residual: Contributed_To_Accident=No' ;
label F_Contributed_To_Accident = 'From: Contributed_To_Accident' ;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident =
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( Contributed_To_Accident , $3.);
 %DMNORMCP( _ARBFMT_3, F_Contributed_To_Accident );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( GRP_Personal_Injury , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('3' ) THEN DO;
  _NODE_  =                    3;
  _LEAF_  =                    4;
  P_Contributed_To_AccidentYes  =     0.97902097902097;
  P_Contributed_To_AccidentNo  =     0.02097902097902;
  Q_Contributed_To_AccidentYes  =     0.97902097902097;
  Q_Contributed_To_AccidentNo  =     0.02097902097902;
  V_Contributed_To_AccidentYes  =                    0;
  V_Contributed_To_AccidentNo  =                    0;
  I_Contributed_To_Accident  = 'YES' ;
  U_Contributed_To_Accident  = 'Yes' ;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('3' ) THEN DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Contributed_To_AccidentYes  =     0.94409937888198;
    P_Contributed_To_AccidentNo  =     0.05590062111801;
    Q_Contributed_To_AccidentYes  =     0.94409937888198;
    Q_Contributed_To_AccidentNo  =     0.05590062111801;
    V_Contributed_To_AccidentYes  =      0.2156862745098;
    V_Contributed_To_AccidentNo  =     0.78431372549019;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
    END;
  ELSE DO;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
      _NODE_  =                    7;
      _LEAF_  =                    2;
      P_Contributed_To_AccidentYes  =     0.18407960199004;
      P_Contributed_To_AccidentNo  =     0.81592039800995;
      Q_Contributed_To_AccidentYes  =     0.18407960199004;
      Q_Contributed_To_AccidentNo  =     0.81592039800995;
      V_Contributed_To_AccidentYes  =     0.00302343159486;
      V_Contributed_To_AccidentNo  =     0.99697656840514;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    ELSE DO;
      _NODE_  =                    6;
      _LEAF_  =                    1;
      P_Contributed_To_AccidentYes  =     0.35091277890466;
      P_Contributed_To_AccidentNo  =     0.64908722109533;
      Q_Contributed_To_AccidentYes  =     0.35091277890466;
      Q_Contributed_To_AccidentNo  =     0.64908722109533;
      V_Contributed_To_AccidentYes  =     0.02827289489858;
      V_Contributed_To_AccidentNo  =     0.97172710510141;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Contributed_To_Accident  NE 'YES'
AND F_Contributed_To_Accident  NE 'NO'  THEN DO;
        R_Contributed_To_AccidentYes  = .;
        R_Contributed_To_AccidentNo  = .;
 END;
 ELSE DO;
       R_Contributed_To_AccidentYes  =  -P_Contributed_To_AccidentYes ;
       R_Contributed_To_AccidentNo  =  -P_Contributed_To_AccidentNo ;
       SELECT( F_Contributed_To_Accident  );
          WHEN( 'YES'  ) R_Contributed_To_AccidentYes  =
        R_Contributed_To_AccidentYes  +1;
          WHEN( 'NO'  ) R_Contributed_To_AccidentNo  =
        R_Contributed_To_AccidentNo  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp: EndGroup;
* User: Divya;
* Date: 23NOV16: 03:24;
* Bagging: Loop=3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Bagging: accumulate probabilities for iteration: 3;
*------------------------------------------------------------*;
P_Contributed_To_AccidentYes = _BagVar1*(2/3) + P_Contributed_To_AccidentYes*(1/3);
P_Contributed_To_AccidentNo = _BagVar2*(2/3) + P_Contributed_To_AccidentNo*(1/3);
*------------------------------------------------------------*;
* Bagging: Saving Probabilities for Next Iteration;
*------------------------------------------------------------*;
_BagVar1 = P_Contributed_To_AccidentYes;
_BagVar2 = P_Contributed_To_AccidentNo;
*------------------------------------------------------------*;
* Grp: StartGroup;
* User: Divya;
* Date: 23NOV16: 03:24;
* Bagging: Loop=4;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Tree5: DecisionTree;
* User: Divya;
* Date: 23NOV16: 03:24;
* Bagging: Loop=4;
*------------------------------------------------------------*;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Contributed_To_Accident  $    3;
LENGTH I_Contributed_To_Accident  $    3;
LENGTH U_Contributed_To_Accident  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Contributed_To_AccidentYes =
'Predicted: Contributed_To_Accident=Yes' ;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
label Q_Contributed_To_AccidentYes =
'Unadjusted P: Contributed_To_Accident=Yes' ;
label Q_Contributed_To_AccidentNo =
'Unadjusted P: Contributed_To_Accident=No' ;
label V_Contributed_To_AccidentYes =
'Validated: Contributed_To_Accident=Yes' ;
label V_Contributed_To_AccidentNo = 'Validated: Contributed_To_Accident=No' ;
label R_Contributed_To_AccidentYes = 'Residual: Contributed_To_Accident=Yes' ;
label R_Contributed_To_AccidentNo = 'Residual: Contributed_To_Accident=No' ;
label F_Contributed_To_Accident = 'From: Contributed_To_Accident' ;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident =
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( Contributed_To_Accident , $3.);
 %DMNORMCP( _ARBFMT_3, F_Contributed_To_Accident );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('3' ) THEN DO;
  _NODE_  =                    3;
  _LEAF_  =                    4;
  P_Contributed_To_AccidentYes  =     0.93491124260355;
  P_Contributed_To_AccidentNo  =     0.06508875739644;
  Q_Contributed_To_AccidentYes  =     0.93491124260355;
  Q_Contributed_To_AccidentNo  =     0.06508875739644;
  V_Contributed_To_AccidentYes  =      0.2156862745098;
  V_Contributed_To_AccidentNo  =     0.78431372549019;
  I_Contributed_To_Accident  = 'YES' ;
  U_Contributed_To_Accident  = 'Yes' ;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( GRP_Personal_Injury , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('3' ) THEN DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Contributed_To_AccidentYes  =     0.94776119402985;
    P_Contributed_To_AccidentNo  =     0.05223880597014;
    Q_Contributed_To_AccidentYes  =     0.94776119402985;
    Q_Contributed_To_AccidentNo  =     0.05223880597014;
    V_Contributed_To_AccidentYes  =                    0;
    V_Contributed_To_AccidentNo  =                    0;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
    END;
  ELSE DO;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
      _NODE_  =                    7;
      _LEAF_  =                    2;
      P_Contributed_To_AccidentYes  =     0.13333333333333;
      P_Contributed_To_AccidentNo  =     0.86666666666666;
      Q_Contributed_To_AccidentYes  =     0.13333333333333;
      Q_Contributed_To_AccidentNo  =     0.86666666666666;
      V_Contributed_To_AccidentYes  =     0.00302343159486;
      V_Contributed_To_AccidentNo  =     0.99697656840514;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    ELSE DO;
      _NODE_  =                    6;
      _LEAF_  =                    1;
      P_Contributed_To_AccidentYes  =     0.37358490566037;
      P_Contributed_To_AccidentNo  =     0.62641509433962;
      Q_Contributed_To_AccidentYes  =     0.37358490566037;
      Q_Contributed_To_AccidentNo  =     0.62641509433962;
      V_Contributed_To_AccidentYes  =     0.02827289489858;
      V_Contributed_To_AccidentNo  =     0.97172710510141;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Contributed_To_Accident  NE 'YES'
AND F_Contributed_To_Accident  NE 'NO'  THEN DO;
        R_Contributed_To_AccidentYes  = .;
        R_Contributed_To_AccidentNo  = .;
 END;
 ELSE DO;
       R_Contributed_To_AccidentYes  =  -P_Contributed_To_AccidentYes ;
       R_Contributed_To_AccidentNo  =  -P_Contributed_To_AccidentNo ;
       SELECT( F_Contributed_To_Accident  );
          WHEN( 'YES'  ) R_Contributed_To_AccidentYes  =
        R_Contributed_To_AccidentYes  +1;
          WHEN( 'NO'  ) R_Contributed_To_AccidentNo  =
        R_Contributed_To_AccidentNo  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp: EndGroup;
* User: Divya;
* Date: 23NOV16: 03:24;
* Bagging: Loop=4;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Bagging: accumulate probabilities for iteration: 4;
*------------------------------------------------------------*;
P_Contributed_To_AccidentYes = _BagVar1*(3/4) + P_Contributed_To_AccidentYes*(1/4);
P_Contributed_To_AccidentNo = _BagVar2*(3/4) + P_Contributed_To_AccidentNo*(1/4);
*------------------------------------------------------------*;
* Bagging: Saving Probabilities for Next Iteration;
*------------------------------------------------------------*;
_BagVar1 = P_Contributed_To_AccidentYes;
_BagVar2 = P_Contributed_To_AccidentNo;
*------------------------------------------------------------*;
* Grp: StartGroup;
* User: Divya;
* Date: 23NOV16: 03:25;
* Bagging: Loop=5;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Tree5: DecisionTree;
* User: Divya;
* Date: 23NOV16: 03:25;
* Bagging: Loop=5;
*------------------------------------------------------------*;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Contributed_To_Accident  $    3;
LENGTH I_Contributed_To_Accident  $    3;
LENGTH U_Contributed_To_Accident  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Contributed_To_AccidentYes =
'Predicted: Contributed_To_Accident=Yes' ;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
label Q_Contributed_To_AccidentYes =
'Unadjusted P: Contributed_To_Accident=Yes' ;
label Q_Contributed_To_AccidentNo =
'Unadjusted P: Contributed_To_Accident=No' ;
label V_Contributed_To_AccidentYes =
'Validated: Contributed_To_Accident=Yes' ;
label V_Contributed_To_AccidentNo = 'Validated: Contributed_To_Accident=No' ;
label R_Contributed_To_AccidentYes = 'Residual: Contributed_To_Accident=Yes' ;
label R_Contributed_To_AccidentNo = 'Residual: Contributed_To_Accident=No' ;
label F_Contributed_To_Accident = 'From: Contributed_To_Accident' ;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident =
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( Contributed_To_Accident , $3.);
 %DMNORMCP( _ARBFMT_3, F_Contributed_To_Accident );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('3' ) THEN DO;
  _NODE_  =                    3;
  _LEAF_  =                    4;
  P_Contributed_To_AccidentYes  =      0.9217877094972;
  P_Contributed_To_AccidentNo  =     0.07821229050279;
  Q_Contributed_To_AccidentYes  =      0.9217877094972;
  Q_Contributed_To_AccidentNo  =     0.07821229050279;
  V_Contributed_To_AccidentYes  =      0.2156862745098;
  V_Contributed_To_AccidentNo  =     0.78431372549019;
  I_Contributed_To_Accident  = 'YES' ;
  U_Contributed_To_Accident  = 'Yes' ;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( GRP_Personal_Injury , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('3' ) THEN DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Contributed_To_AccidentYes  =                    1;
    P_Contributed_To_AccidentNo  =                    0;
    Q_Contributed_To_AccidentYes  =                    1;
    Q_Contributed_To_AccidentNo  =                    0;
    V_Contributed_To_AccidentYes  =                    0;
    V_Contributed_To_AccidentNo  =                    0;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
    END;
  ELSE DO;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
      _NODE_  =                    7;
      _LEAF_  =                    2;
      P_Contributed_To_AccidentYes  =     0.13089005235602;
      P_Contributed_To_AccidentNo  =     0.86910994764397;
      Q_Contributed_To_AccidentYes  =     0.13089005235602;
      Q_Contributed_To_AccidentNo  =     0.86910994764397;
      V_Contributed_To_AccidentYes  =     0.00302343159486;
      V_Contributed_To_AccidentNo  =     0.99697656840514;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    ELSE DO;
      _NODE_  =                    6;
      _LEAF_  =                    1;
      P_Contributed_To_AccidentYes  =          0.322265625;
      P_Contributed_To_AccidentNo  =          0.677734375;
      Q_Contributed_To_AccidentYes  =          0.322265625;
      Q_Contributed_To_AccidentNo  =          0.677734375;
      V_Contributed_To_AccidentYes  =     0.02827289489858;
      V_Contributed_To_AccidentNo  =     0.97172710510141;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Contributed_To_Accident  NE 'YES'
AND F_Contributed_To_Accident  NE 'NO'  THEN DO;
        R_Contributed_To_AccidentYes  = .;
        R_Contributed_To_AccidentNo  = .;
 END;
 ELSE DO;
       R_Contributed_To_AccidentYes  =  -P_Contributed_To_AccidentYes ;
       R_Contributed_To_AccidentNo  =  -P_Contributed_To_AccidentNo ;
       SELECT( F_Contributed_To_Accident  );
          WHEN( 'YES'  ) R_Contributed_To_AccidentYes  =
        R_Contributed_To_AccidentYes  +1;
          WHEN( 'NO'  ) R_Contributed_To_AccidentNo  =
        R_Contributed_To_AccidentNo  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp: EndGroup;
* User: Divya;
* Date: 23NOV16: 03:25;
* Bagging: Loop=5;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Bagging: accumulate probabilities for iteration: 5;
*------------------------------------------------------------*;
P_Contributed_To_AccidentYes = _BagVar1*(4/5) + P_Contributed_To_AccidentYes*(1/5);
P_Contributed_To_AccidentNo = _BagVar2*(4/5) + P_Contributed_To_AccidentNo*(1/5);
*------------------------------------------------------------*;
* Bagging: Saving Probabilities for Next Iteration;
*------------------------------------------------------------*;
_BagVar1 = P_Contributed_To_AccidentYes;
_BagVar2 = P_Contributed_To_AccidentNo;
*------------------------------------------------------------*;
* Grp: StartGroup;
* User: Divya;
* Date: 23NOV16: 03:25;
* Bagging: Loop=6;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Tree5: DecisionTree;
* User: Divya;
* Date: 23NOV16: 03:25;
* Bagging: Loop=6;
*------------------------------------------------------------*;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Contributed_To_Accident  $    3;
LENGTH I_Contributed_To_Accident  $    3;
LENGTH U_Contributed_To_Accident  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Contributed_To_AccidentYes =
'Predicted: Contributed_To_Accident=Yes' ;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
label Q_Contributed_To_AccidentYes =
'Unadjusted P: Contributed_To_Accident=Yes' ;
label Q_Contributed_To_AccidentNo =
'Unadjusted P: Contributed_To_Accident=No' ;
label V_Contributed_To_AccidentYes =
'Validated: Contributed_To_Accident=Yes' ;
label V_Contributed_To_AccidentNo = 'Validated: Contributed_To_Accident=No' ;
label R_Contributed_To_AccidentYes = 'Residual: Contributed_To_Accident=Yes' ;
label R_Contributed_To_AccidentNo = 'Residual: Contributed_To_Accident=No' ;
label F_Contributed_To_Accident = 'From: Contributed_To_Accident' ;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident =
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( Contributed_To_Accident , $3.);
 %DMNORMCP( _ARBFMT_3, F_Contributed_To_Accident );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('3' ) THEN DO;
  _NODE_  =                    3;
  _LEAF_  =                    4;
  P_Contributed_To_AccidentYes  =     0.94943820224719;
  P_Contributed_To_AccidentNo  =      0.0505617977528;
  Q_Contributed_To_AccidentYes  =     0.94943820224719;
  Q_Contributed_To_AccidentNo  =      0.0505617977528;
  V_Contributed_To_AccidentYes  =      0.2156862745098;
  V_Contributed_To_AccidentNo  =     0.78431372549019;
  I_Contributed_To_Accident  = 'YES' ;
  U_Contributed_To_Accident  = 'Yes' ;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( GRP_Personal_Injury , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('3' ) THEN DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Contributed_To_AccidentYes  =                0.952;
    P_Contributed_To_AccidentNo  =                0.048;
    Q_Contributed_To_AccidentYes  =                0.952;
    Q_Contributed_To_AccidentNo  =                0.048;
    V_Contributed_To_AccidentYes  =                    0;
    V_Contributed_To_AccidentNo  =                    0;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
    END;
  ELSE DO;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
      _NODE_  =                    7;
      _LEAF_  =                    2;
      P_Contributed_To_AccidentYes  =     0.13775510204081;
      P_Contributed_To_AccidentNo  =     0.86224489795918;
      Q_Contributed_To_AccidentYes  =     0.13775510204081;
      Q_Contributed_To_AccidentNo  =     0.86224489795918;
      V_Contributed_To_AccidentYes  =     0.00302343159486;
      V_Contributed_To_AccidentNo  =     0.99697656840514;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    ELSE DO;
      _NODE_  =                    6;
      _LEAF_  =                    1;
      P_Contributed_To_AccidentYes  =     0.34068136272545;
      P_Contributed_To_AccidentNo  =     0.65931863727454;
      Q_Contributed_To_AccidentYes  =     0.34068136272545;
      Q_Contributed_To_AccidentNo  =     0.65931863727454;
      V_Contributed_To_AccidentYes  =     0.02827289489858;
      V_Contributed_To_AccidentNo  =     0.97172710510141;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Contributed_To_Accident  NE 'YES'
AND F_Contributed_To_Accident  NE 'NO'  THEN DO;
        R_Contributed_To_AccidentYes  = .;
        R_Contributed_To_AccidentNo  = .;
 END;
 ELSE DO;
       R_Contributed_To_AccidentYes  =  -P_Contributed_To_AccidentYes ;
       R_Contributed_To_AccidentNo  =  -P_Contributed_To_AccidentNo ;
       SELECT( F_Contributed_To_Accident  );
          WHEN( 'YES'  ) R_Contributed_To_AccidentYes  =
        R_Contributed_To_AccidentYes  +1;
          WHEN( 'NO'  ) R_Contributed_To_AccidentNo  =
        R_Contributed_To_AccidentNo  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp: EndGroup;
* User: Divya;
* Date: 23NOV16: 03:25;
* Bagging: Loop=6;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Bagging: accumulate probabilities for iteration: 6;
*------------------------------------------------------------*;
P_Contributed_To_AccidentYes = _BagVar1*(5/6) + P_Contributed_To_AccidentYes*(1/6);
P_Contributed_To_AccidentNo = _BagVar2*(5/6) + P_Contributed_To_AccidentNo*(1/6);
*------------------------------------------------------------*;
* Bagging: Saving Probabilities for Next Iteration;
*------------------------------------------------------------*;
_BagVar1 = P_Contributed_To_AccidentYes;
_BagVar2 = P_Contributed_To_AccidentNo;
*------------------------------------------------------------*;
* Grp: StartGroup;
* User: Divya;
* Date: 23NOV16: 03:25;
* Bagging: Loop=7;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Tree5: DecisionTree;
* User: Divya;
* Date: 23NOV16: 03:25;
* Bagging: Loop=7;
*------------------------------------------------------------*;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Contributed_To_Accident  $    3;
LENGTH I_Contributed_To_Accident  $    3;
LENGTH U_Contributed_To_Accident  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Contributed_To_AccidentYes =
'Predicted: Contributed_To_Accident=Yes' ;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
label Q_Contributed_To_AccidentYes =
'Unadjusted P: Contributed_To_Accident=Yes' ;
label Q_Contributed_To_AccidentNo =
'Unadjusted P: Contributed_To_Accident=No' ;
label V_Contributed_To_AccidentYes =
'Validated: Contributed_To_Accident=Yes' ;
label V_Contributed_To_AccidentNo = 'Validated: Contributed_To_Accident=No' ;
label R_Contributed_To_AccidentYes = 'Residual: Contributed_To_Accident=Yes' ;
label R_Contributed_To_AccidentNo = 'Residual: Contributed_To_Accident=No' ;
label F_Contributed_To_Accident = 'From: Contributed_To_Accident' ;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident =
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( Contributed_To_Accident , $3.);
 %DMNORMCP( _ARBFMT_3, F_Contributed_To_Accident );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('3' ) THEN DO;
  _NODE_  =                    3;
  _LEAF_  =                    4;
  P_Contributed_To_AccidentYes  =     0.96534653465346;
  P_Contributed_To_AccidentNo  =     0.03465346534653;
  Q_Contributed_To_AccidentYes  =     0.96534653465346;
  Q_Contributed_To_AccidentNo  =     0.03465346534653;
  V_Contributed_To_AccidentYes  =      0.2156862745098;
  V_Contributed_To_AccidentNo  =     0.78431372549019;
  I_Contributed_To_Accident  = 'YES' ;
  U_Contributed_To_Accident  = 'Yes' ;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( GRP_Personal_Injury , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('3' ) THEN DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Contributed_To_AccidentYes  =     0.97872340425531;
    P_Contributed_To_AccidentNo  =     0.02127659574468;
    Q_Contributed_To_AccidentYes  =     0.97872340425531;
    Q_Contributed_To_AccidentNo  =     0.02127659574468;
    V_Contributed_To_AccidentYes  =                    0;
    V_Contributed_To_AccidentNo  =                    0;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
    END;
  ELSE DO;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
      _NODE_  =                    7;
      _LEAF_  =                    2;
      P_Contributed_To_AccidentYes  =     0.16216216216216;
      P_Contributed_To_AccidentNo  =     0.83783783783783;
      Q_Contributed_To_AccidentYes  =     0.16216216216216;
      Q_Contributed_To_AccidentNo  =     0.83783783783783;
      V_Contributed_To_AccidentYes  =     0.00302343159486;
      V_Contributed_To_AccidentNo  =     0.99697656840514;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    ELSE DO;
      _NODE_  =                    6;
      _LEAF_  =                    1;
      P_Contributed_To_AccidentYes  =     0.36382978723404;
      P_Contributed_To_AccidentNo  =     0.63617021276595;
      Q_Contributed_To_AccidentYes  =     0.36382978723404;
      Q_Contributed_To_AccidentNo  =     0.63617021276595;
      V_Contributed_To_AccidentYes  =     0.02827289489858;
      V_Contributed_To_AccidentNo  =     0.97172710510141;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Contributed_To_Accident  NE 'YES'
AND F_Contributed_To_Accident  NE 'NO'  THEN DO;
        R_Contributed_To_AccidentYes  = .;
        R_Contributed_To_AccidentNo  = .;
 END;
 ELSE DO;
       R_Contributed_To_AccidentYes  =  -P_Contributed_To_AccidentYes ;
       R_Contributed_To_AccidentNo  =  -P_Contributed_To_AccidentNo ;
       SELECT( F_Contributed_To_Accident  );
          WHEN( 'YES'  ) R_Contributed_To_AccidentYes  =
        R_Contributed_To_AccidentYes  +1;
          WHEN( 'NO'  ) R_Contributed_To_AccidentNo  =
        R_Contributed_To_AccidentNo  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp: EndGroup;
* User: Divya;
* Date: 23NOV16: 03:25;
* Bagging: Loop=7;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Bagging: accumulate probabilities for iteration: 7;
*------------------------------------------------------------*;
P_Contributed_To_AccidentYes = _BagVar1*(6/7) + P_Contributed_To_AccidentYes*(1/7);
P_Contributed_To_AccidentNo = _BagVar2*(6/7) + P_Contributed_To_AccidentNo*(1/7);
*------------------------------------------------------------*;
* Bagging: Saving Probabilities for Next Iteration;
*------------------------------------------------------------*;
_BagVar1 = P_Contributed_To_AccidentYes;
_BagVar2 = P_Contributed_To_AccidentNo;
*------------------------------------------------------------*;
* Grp: StartGroup;
* User: Divya;
* Date: 23NOV16: 03:26;
* Bagging: Loop=8;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Tree5: DecisionTree;
* User: Divya;
* Date: 23NOV16: 03:26;
* Bagging: Loop=8;
*------------------------------------------------------------*;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Contributed_To_Accident  $    3;
LENGTH I_Contributed_To_Accident  $    3;
LENGTH U_Contributed_To_Accident  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Contributed_To_AccidentYes =
'Predicted: Contributed_To_Accident=Yes' ;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
label Q_Contributed_To_AccidentYes =
'Unadjusted P: Contributed_To_Accident=Yes' ;
label Q_Contributed_To_AccidentNo =
'Unadjusted P: Contributed_To_Accident=No' ;
label V_Contributed_To_AccidentYes =
'Validated: Contributed_To_Accident=Yes' ;
label V_Contributed_To_AccidentNo = 'Validated: Contributed_To_Accident=No' ;
label R_Contributed_To_AccidentYes = 'Residual: Contributed_To_Accident=Yes' ;
label R_Contributed_To_AccidentNo = 'Residual: Contributed_To_Accident=No' ;
label F_Contributed_To_Accident = 'From: Contributed_To_Accident' ;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident =
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( Contributed_To_Accident , $3.);
 %DMNORMCP( _ARBFMT_3, F_Contributed_To_Accident );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('3' ) THEN DO;
  _NODE_  =                    3;
  _LEAF_  =                    4;
  P_Contributed_To_AccidentYes  =     0.96511627906976;
  P_Contributed_To_AccidentNo  =     0.03488372093023;
  Q_Contributed_To_AccidentYes  =     0.96511627906976;
  Q_Contributed_To_AccidentNo  =     0.03488372093023;
  V_Contributed_To_AccidentYes  =      0.2156862745098;
  V_Contributed_To_AccidentNo  =     0.78431372549019;
  I_Contributed_To_Accident  = 'YES' ;
  U_Contributed_To_Accident  = 'Yes' ;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( GRP_Personal_Injury , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('3' ) THEN DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Contributed_To_AccidentYes  =     0.97826086956521;
    P_Contributed_To_AccidentNo  =     0.02173913043478;
    Q_Contributed_To_AccidentYes  =     0.97826086956521;
    Q_Contributed_To_AccidentNo  =     0.02173913043478;
    V_Contributed_To_AccidentYes  =                    0;
    V_Contributed_To_AccidentNo  =                    0;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
    END;
  ELSE DO;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
      _NODE_  =                    9;
      _LEAF_  =                    2;
      P_Contributed_To_AccidentYes  =     0.18539325842696;
      P_Contributed_To_AccidentNo  =     0.81460674157303;
      Q_Contributed_To_AccidentYes  =     0.18539325842696;
      Q_Contributed_To_AccidentNo  =     0.81460674157303;
      V_Contributed_To_AccidentYes  =     0.00302343159486;
      V_Contributed_To_AccidentNo  =     0.99697656840514;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    ELSE DO;
      _NODE_  =                    8;
      _LEAF_  =                    1;
      P_Contributed_To_AccidentYes  =     0.32941176470588;
      P_Contributed_To_AccidentNo  =     0.67058823529411;
      Q_Contributed_To_AccidentYes  =     0.32941176470588;
      Q_Contributed_To_AccidentNo  =     0.67058823529411;
      V_Contributed_To_AccidentYes  =     0.02827289489858;
      V_Contributed_To_AccidentNo  =     0.97172710510141;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Contributed_To_Accident  NE 'YES'
AND F_Contributed_To_Accident  NE 'NO'  THEN DO;
        R_Contributed_To_AccidentYes  = .;
        R_Contributed_To_AccidentNo  = .;
 END;
 ELSE DO;
       R_Contributed_To_AccidentYes  =  -P_Contributed_To_AccidentYes ;
       R_Contributed_To_AccidentNo  =  -P_Contributed_To_AccidentNo ;
       SELECT( F_Contributed_To_Accident  );
          WHEN( 'YES'  ) R_Contributed_To_AccidentYes  =
        R_Contributed_To_AccidentYes  +1;
          WHEN( 'NO'  ) R_Contributed_To_AccidentNo  =
        R_Contributed_To_AccidentNo  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp: EndGroup;
* User: Divya;
* Date: 23NOV16: 03:26;
* Bagging: Loop=8;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Bagging: accumulate probabilities for iteration: 8;
*------------------------------------------------------------*;
P_Contributed_To_AccidentYes = _BagVar1*(7/8) + P_Contributed_To_AccidentYes*(1/8);
P_Contributed_To_AccidentNo = _BagVar2*(7/8) + P_Contributed_To_AccidentNo*(1/8);
*------------------------------------------------------------*;
* Bagging: Saving Probabilities for Next Iteration;
*------------------------------------------------------------*;
_BagVar1 = P_Contributed_To_AccidentYes;
_BagVar2 = P_Contributed_To_AccidentNo;
*------------------------------------------------------------*;
* Grp: StartGroup;
* User: Divya;
* Date: 23NOV16: 03:26;
* Bagging: Loop=9;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Tree5: DecisionTree;
* User: Divya;
* Date: 23NOV16: 03:26;
* Bagging: Loop=9;
*------------------------------------------------------------*;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Contributed_To_Accident  $    3;
LENGTH I_Contributed_To_Accident  $    3;
LENGTH U_Contributed_To_Accident  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Contributed_To_AccidentYes =
'Predicted: Contributed_To_Accident=Yes' ;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
label Q_Contributed_To_AccidentYes =
'Unadjusted P: Contributed_To_Accident=Yes' ;
label Q_Contributed_To_AccidentNo =
'Unadjusted P: Contributed_To_Accident=No' ;
label V_Contributed_To_AccidentYes =
'Validated: Contributed_To_Accident=Yes' ;
label V_Contributed_To_AccidentNo = 'Validated: Contributed_To_Accident=No' ;
label R_Contributed_To_AccidentYes = 'Residual: Contributed_To_Accident=Yes' ;
label R_Contributed_To_AccidentNo = 'Residual: Contributed_To_Accident=No' ;
label F_Contributed_To_Accident = 'From: Contributed_To_Accident' ;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident =
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( Contributed_To_Accident , $3.);
 %DMNORMCP( _ARBFMT_3, F_Contributed_To_Accident );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('3' ) THEN DO;
  _NODE_  =                    3;
  _LEAF_  =                    4;
  P_Contributed_To_AccidentYes  =     0.96174863387978;
  P_Contributed_To_AccidentNo  =     0.03825136612021;
  Q_Contributed_To_AccidentYes  =     0.96174863387978;
  Q_Contributed_To_AccidentNo  =     0.03825136612021;
  V_Contributed_To_AccidentYes  =      0.2156862745098;
  V_Contributed_To_AccidentNo  =     0.78431372549019;
  I_Contributed_To_Accident  = 'YES' ;
  U_Contributed_To_Accident  = 'Yes' ;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( GRP_Personal_Injury , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('3' ) THEN DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Contributed_To_AccidentYes  =     0.97391304347826;
    P_Contributed_To_AccidentNo  =     0.02608695652173;
    Q_Contributed_To_AccidentYes  =     0.97391304347826;
    Q_Contributed_To_AccidentNo  =     0.02608695652173;
    V_Contributed_To_AccidentYes  =                    0;
    V_Contributed_To_AccidentNo  =                    0;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
    END;
  ELSE DO;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
      _NODE_  =                    7;
      _LEAF_  =                    2;
      P_Contributed_To_AccidentYes  =     0.15463917525773;
      P_Contributed_To_AccidentNo  =     0.84536082474226;
      Q_Contributed_To_AccidentYes  =     0.15463917525773;
      Q_Contributed_To_AccidentNo  =     0.84536082474226;
      V_Contributed_To_AccidentYes  =     0.00302343159486;
      V_Contributed_To_AccidentNo  =     0.99697656840514;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    ELSE DO;
      _NODE_  =                    6;
      _LEAF_  =                    1;
      P_Contributed_To_AccidentYes  =     0.35770750988142;
      P_Contributed_To_AccidentNo  =     0.64229249011857;
      Q_Contributed_To_AccidentYes  =     0.35770750988142;
      Q_Contributed_To_AccidentNo  =     0.64229249011857;
      V_Contributed_To_AccidentYes  =     0.02827289489858;
      V_Contributed_To_AccidentNo  =     0.97172710510141;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Contributed_To_Accident  NE 'YES'
AND F_Contributed_To_Accident  NE 'NO'  THEN DO;
        R_Contributed_To_AccidentYes  = .;
        R_Contributed_To_AccidentNo  = .;
 END;
 ELSE DO;
       R_Contributed_To_AccidentYes  =  -P_Contributed_To_AccidentYes ;
       R_Contributed_To_AccidentNo  =  -P_Contributed_To_AccidentNo ;
       SELECT( F_Contributed_To_Accident  );
          WHEN( 'YES'  ) R_Contributed_To_AccidentYes  =
        R_Contributed_To_AccidentYes  +1;
          WHEN( 'NO'  ) R_Contributed_To_AccidentNo  =
        R_Contributed_To_AccidentNo  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp: EndGroup;
* User: Divya;
* Date: 23NOV16: 03:26;
* Bagging: Loop=9;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Bagging: accumulate probabilities for iteration: 9;
*------------------------------------------------------------*;
P_Contributed_To_AccidentYes = _BagVar1*(8/9) + P_Contributed_To_AccidentYes*(1/9);
P_Contributed_To_AccidentNo = _BagVar2*(8/9) + P_Contributed_To_AccidentNo*(1/9);
*------------------------------------------------------------*;
* Bagging: Saving Probabilities for Next Iteration;
*------------------------------------------------------------*;
_BagVar1 = P_Contributed_To_AccidentYes;
_BagVar2 = P_Contributed_To_AccidentNo;
*------------------------------------------------------------*;
* Grp: StartGroup;
* User: Divya;
* Date: 23NOV16: 03:27;
* Bagging: Loop=10;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Tree5: DecisionTree;
* User: Divya;
* Date: 23NOV16: 03:27;
* Bagging: Loop=10;
*------------------------------------------------------------*;
****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;
 
******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH F_Contributed_To_Accident  $    3;
LENGTH I_Contributed_To_Accident  $    3;
LENGTH U_Contributed_To_Accident  $    3;
LENGTH _WARN_  $    4;
 
******              LABELS FOR NEW VARIABLES              ******;
label _NODE_ = 'Node' ;
label _LEAF_ = 'Leaf' ;
label P_Contributed_To_AccidentYes =
'Predicted: Contributed_To_Accident=Yes' ;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
label Q_Contributed_To_AccidentYes =
'Unadjusted P: Contributed_To_Accident=Yes' ;
label Q_Contributed_To_AccidentNo =
'Unadjusted P: Contributed_To_Accident=No' ;
label V_Contributed_To_AccidentYes =
'Validated: Contributed_To_Accident=Yes' ;
label V_Contributed_To_AccidentNo = 'Validated: Contributed_To_Accident=No' ;
label R_Contributed_To_AccidentYes = 'Residual: Contributed_To_Accident=Yes' ;
label R_Contributed_To_AccidentNo = 'Residual: Contributed_To_Accident=No' ;
label F_Contributed_To_Accident = 'From: Contributed_To_Accident' ;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident =
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;
 
 
******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3;
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12;
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */
 
 
_ARBFMT_3 = PUT( Contributed_To_Accident , $3.);
 %DMNORMCP( _ARBFMT_3, F_Contributed_To_Accident );
 
******             ASSIGN OBSERVATION TO NODE             ******;
_ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
 %DMNORMIP( _ARBFMT_12);
IF _ARBFMT_12 IN ('3' ) THEN DO;
  _NODE_  =                    3;
  _LEAF_  =                    4;
  P_Contributed_To_AccidentYes  =                 0.92;
  P_Contributed_To_AccidentNo  =                 0.08;
  Q_Contributed_To_AccidentYes  =                 0.92;
  Q_Contributed_To_AccidentNo  =                 0.08;
  V_Contributed_To_AccidentYes  =      0.2156862745098;
  V_Contributed_To_AccidentNo  =     0.78431372549019;
  I_Contributed_To_Accident  = 'YES' ;
  U_Contributed_To_Accident  = 'Yes' ;
  END;
ELSE DO;
  _ARBFMT_12 = PUT( GRP_Personal_Injury , BEST12.);
   %DMNORMIP( _ARBFMT_12);
  IF _ARBFMT_12 IN ('3' ) THEN DO;
    _NODE_  =                    5;
    _LEAF_  =                    3;
    P_Contributed_To_AccidentYes  =     0.96638655462184;
    P_Contributed_To_AccidentNo  =     0.03361344537815;
    Q_Contributed_To_AccidentYes  =     0.96638655462184;
    Q_Contributed_To_AccidentNo  =     0.03361344537815;
    V_Contributed_To_AccidentYes  =                    0;
    V_Contributed_To_AccidentNo  =                    0;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
    END;
  ELSE DO;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
      _NODE_  =                    7;
      _LEAF_  =                    2;
      P_Contributed_To_AccidentYes  =     0.18357487922705;
      P_Contributed_To_AccidentNo  =     0.81642512077294;
      Q_Contributed_To_AccidentYes  =     0.18357487922705;
      Q_Contributed_To_AccidentNo  =     0.81642512077294;
      V_Contributed_To_AccidentYes  =     0.00302343159486;
      V_Contributed_To_AccidentNo  =     0.99697656840514;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    ELSE DO;
      _NODE_  =                    6;
      _LEAF_  =                    1;
      P_Contributed_To_AccidentYes  =     0.36228813559322;
      P_Contributed_To_AccidentNo  =     0.63771186440677;
      Q_Contributed_To_AccidentYes  =     0.36228813559322;
      Q_Contributed_To_AccidentNo  =     0.63771186440677;
      V_Contributed_To_AccidentYes  =     0.02827289489858;
      V_Contributed_To_AccidentNo  =     0.97172710510141;
      I_Contributed_To_Accident  = 'NO' ;
      U_Contributed_To_Accident  = 'No' ;
      END;
    END;
  END;
 
*****  RESIDUALS R_ *************;
IF  F_Contributed_To_Accident  NE 'YES'
AND F_Contributed_To_Accident  NE 'NO'  THEN DO;
        R_Contributed_To_AccidentYes  = .;
        R_Contributed_To_AccidentNo  = .;
 END;
 ELSE DO;
       R_Contributed_To_AccidentYes  =  -P_Contributed_To_AccidentYes ;
       R_Contributed_To_AccidentNo  =  -P_Contributed_To_AccidentNo ;
       SELECT( F_Contributed_To_Accident  );
          WHEN( 'YES'  ) R_Contributed_To_AccidentYes  =
        R_Contributed_To_AccidentYes  +1;
          WHEN( 'NO'  ) R_Contributed_To_AccidentNo  =
        R_Contributed_To_AccidentNo  +1;
       END;
 END;
 
****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;
 
drop _LEAF_;
*------------------------------------------------------------*;
* EndGrp: EndGroup;
* User: Divya;
* Date: 23NOV16: 03:27;
* Bagging: Loop=10;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Bagging: accumulate final probabilities;
*------------------------------------------------------------*;
P_Contributed_To_AccidentYes = _BagVar1*(9/10) + P_Contributed_To_AccidentYes*(1/10);
P_Contributed_To_AccidentNo = _BagVar2*(9/10) + P_Contributed_To_AccidentNo*(1/10);
*------------------------------------------------------------*;
*Computing Residual Vars: Contributed_To_Accident;
*------------------------------------------------------------*;
Length R_Contributed_To_AccidentYes 8;
Label R_Contributed_To_AccidentYes='Residual: Contributed_To_Accident=Yes';
Length R_Contributed_To_AccidentNo 8;
Label R_Contributed_To_AccidentNo='Residual: Contributed_To_Accident=No';
if 
 F_Contributed_To_Accident ne 'YES'
and F_Contributed_To_Accident ne 'NO'
 then do;
R_Contributed_To_AccidentYes=.;
R_Contributed_To_AccidentNo=.;
end;
else do;
R_Contributed_To_AccidentYes= - P_Contributed_To_AccidentYes;
R_Contributed_To_AccidentNo= - P_Contributed_To_AccidentNo;
select(F_Contributed_To_Accident);
when('YES')R_Contributed_To_AccidentYes= R_Contributed_To_AccidentYes+1;
when('NO')R_Contributed_To_AccidentNo= R_Contributed_To_AccidentNo+1;
otherwise;
end;
end;
*------------------------------------------------------------*;
*Computing Classification Vars: Contributed_To_Accident;
*------------------------------------------------------------*;
length _format200 $200;
drop _format200;
_format200= ' ' ;
length _p_ 8;
_p_= 0 ;
drop _p_ ;
if P_Contributed_To_AccidentYes - _p_ > 1e-8 then do ;
   _p_= P_Contributed_To_AccidentYes ;
   _format200='YES';
end;
if P_Contributed_To_AccidentNo - _p_ > 1e-8 then do ;
   _p_= P_Contributed_To_AccidentNo ;
   _format200='NO';
end;
I_Contributed_To_Accident=dmnorm(_format200,32); ;
if I_Contributed_To_Accident='YES' then
U_Contributed_To_Accident='YES';
if I_Contributed_To_Accident='NO' then
U_Contributed_To_Accident='NO';
*------------------------------------------------------------*;
*Computing Residual Vars: Contributed_To_Accident;
*------------------------------------------------------------*;
Length R_Contributed_To_AccidentYes 8;
Label R_Contributed_To_AccidentYes='Residual: Contributed_To_Accident=Yes';
Length R_Contributed_To_AccidentNo 8;
Label R_Contributed_To_AccidentNo='Residual: Contributed_To_Accident=No';
if 
 F_Contributed_To_Accident ne 'YES'
and F_Contributed_To_Accident ne 'NO'
 then do;
R_Contributed_To_AccidentYes=.;
R_Contributed_To_AccidentNo=.;
end;
else do;
R_Contributed_To_AccidentYes= - P_Contributed_To_AccidentYes;
R_Contributed_To_AccidentNo= - P_Contributed_To_AccidentNo;
select(F_Contributed_To_Accident);
when('YES')R_Contributed_To_AccidentYes= R_Contributed_To_AccidentYes+1;
when('NO')R_Contributed_To_AccidentNo= R_Contributed_To_AccidentNo+1;
otherwise;
end;
end;
