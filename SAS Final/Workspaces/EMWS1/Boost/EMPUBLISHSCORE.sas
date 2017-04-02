****************************************************************;
******             DECISION TREE SCORING CODE             ******;
****************************************************************;

******         LENGTHS OF NEW CHARACTER VARIABLES         ******;
LENGTH I_Contributed_To_Accident  $    3; 
LENGTH U_Contributed_To_Accident  $    3; 
LENGTH _WARN_  $    4; 

******              LABELS FOR NEW VARIABLES              ******;
label P_Contributed_To_AccidentYes = 
'Predicted: Contributed_To_Accident=Yes' ;
      P_Contributed_To_AccidentYes  = 0;
label P_Contributed_To_AccidentNo = 'Predicted: Contributed_To_Accident=No' ;
      P_Contributed_To_AccidentNo  = 0;
label Q_Contributed_To_AccidentYes = 
'Unadjusted P: Contributed_To_Accident=Yes' ;
      Q_Contributed_To_AccidentYes  = 0;
label Q_Contributed_To_AccidentNo = 
'Unadjusted P: Contributed_To_Accident=No' ;
      Q_Contributed_To_AccidentNo  = 0;
label I_Contributed_To_Accident = 'Into: Contributed_To_Accident' ;
label U_Contributed_To_Accident = 
'Unnormalized Into: Contributed_To_Accident' ;
label _WARN_ = 'Warnings' ;


******      TEMPORARY VARIABLES FOR FORMATTED VALUES      ******;
LENGTH _ARBFMT_3 $      3; DROP _ARBFMT_3; 
_ARBFMT_3 = ' '; /* Initialize to avoid warning. */
LENGTH _ARBFMT_12 $     12; DROP _ARBFMT_12; 
_ARBFMT_12 = ' '; /* Initialize to avoid warning. */


 DROP _ARB_F_;
 DROP _ARB_BADF_;
     _ARB_F_ = -0.001904001;
     _ARB_BADF_ = 0;
******             ASSIGN OBSERVATION TO NODE             ******;
 DROP _ARB_P_;
 _ARB_P_ = 0;
 DROP _ARB_PPATH_; _ARB_PPATH_ = 1;

********** LEAF     1  NODE   244 ***************;
IF _ARB_BADF_ EQ 0 THEN DO; 

   DROP _BRANCH_;
  _BRANCH_ = -1;
  _ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
   %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('2' ) THEN DO;
     _BRANCH_ =    1; 
    END; 
  IF _BRANCH_ LT 0 THEN DO; 
     IF MISSING( GRP_Property_Damage  ) THEN _BRANCH_ = 1;
    ELSE IF _ARBFMT_12 NOTIN (
      '2' ,'3' 
       ) THEN _BRANCH_ = 1;
  END; 
  IF _BRANCH_ GT 0 THEN DO;

    _BRANCH_ = -1;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
      IF _ARBFMT_12 IN ('2' ) THEN DO;
       _BRANCH_ =    1; 
      END; 
    IF _BRANCH_ LT 0 THEN DO; 
       IF MISSING( GRP_Violation_Type  ) THEN _BRANCH_ = 1;
      ELSE IF _ARBFMT_12 NOTIN (
        '2' ,'3' ,'4' 
         ) THEN _BRANCH_ = 1;
    END; 
    IF _BRANCH_ GT 0 THEN DO;
       _ARB_F_ + 0.0057607125;
      END;
    END;
  END;

********** LEAF     2  NODE   245 ***************;
IF _ARB_BADF_ EQ 0 THEN DO; 

  _BRANCH_ = -1;
  _ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
   %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('2' ) THEN DO;
     _BRANCH_ =    1; 
    END; 
  IF _BRANCH_ LT 0 THEN DO; 
     IF MISSING( GRP_Property_Damage  ) THEN _BRANCH_ = 1;
    ELSE IF _ARBFMT_12 NOTIN (
      '2' ,'3' 
       ) THEN _BRANCH_ = 1;
  END; 
  IF _BRANCH_ GT 0 THEN DO;

    _BRANCH_ = -1;
    _ARBFMT_12 = PUT( GRP_Violation_Type , BEST12.);
     %DMNORMIP( _ARBFMT_12);
      IF _ARBFMT_12 IN ('3' ,'4' ) THEN DO;
       _BRANCH_ =    2; 
      END; 

    IF _BRANCH_ GT 0 THEN DO;
       _ARB_F_ + 0.0640167189;
      END;
    END;
  END;

********** LEAF     3  NODE   243 ***************;
IF _ARB_BADF_ EQ 0 THEN DO; 

  _BRANCH_ = -1;
  _ARBFMT_12 = PUT( GRP_Property_Damage , BEST12.);
   %DMNORMIP( _ARBFMT_12);
    IF _ARBFMT_12 IN ('3' ) THEN DO;
     _BRANCH_ =    2; 
    END; 

  IF _BRANCH_ GT 0 THEN DO;
     _ARB_F_ + -0.089313204;
    END;
  END;

_ARB_F_ = 2.0 * _ARB_F_;
IF _ARB_BADF_ NE 0 THEN P_Contributed_To_AccidentNo  = 0.4990480008;
ELSE IF _ARB_F_ > 45.0 THEN P_Contributed_To_AccidentNo  = 1.0;
ELSE IF _ARB_F_ < -45.0 THEN P_Contributed_To_AccidentNo  = 0.0;
ELSE P_Contributed_To_AccidentNo  = 1.0/(1.0 + EXP( - _ARB_F_));
P_Contributed_To_AccidentYes  = 1.0 - P_Contributed_To_AccidentNo ;
*****  CREATE Q_: POSTERIORS WITHOUT PRIORS ****;
Q_Contributed_To_AccidentYes  = P_Contributed_To_AccidentYes ;
Q_Contributed_To_AccidentNo  = P_Contributed_To_AccidentNo ;

*****  I_ AND U_ VARIABLES *******************;
 DROP _ARB_I_ _ARB_IP_;
 _ARB_IP_ = -1.0;
 IF _ARB_IP_ + 1.0/32768.0 < P_Contributed_To_AccidentYes THEN DO;
   _ARB_IP_ = P_Contributed_To_AccidentYes ;
   _ARB_I_  = 1;
   END;
 IF _ARB_IP_ + 1.0/32768.0 < P_Contributed_To_AccidentNo THEN DO;
   _ARB_IP_ = P_Contributed_To_AccidentNo ;
   _ARB_I_  = 2;
   END;
 SELECT( _ARB_I_);
  WHEN( 1) DO;
    I_Contributed_To_Accident  = 'YES' ;
    U_Contributed_To_Accident  = 'Yes' ;
     END;
  WHEN( 2) DO;
    I_Contributed_To_Accident  = 'NO' ;
    U_Contributed_To_Accident  = 'No' ;
     END;
   END;

****************************************************************;
******          END OF DECISION TREE SCORING CODE         ******;
****************************************************************;

