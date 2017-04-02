if upcase(NAME) = "GRP_PERSONAL_INJURY" then do;
ROLE = "REJECTED";
end;
else 
if upcase(NAME) = "GRP_PROPERTY_DAMAGE" then do;
ROLE = "INPUT";
end;
else 
if upcase(NAME) = "GRP_VIOLATION_TYPE" then do;
ROLE = "INPUT";
end;
else 
if upcase(NAME) = "Q_CONTRIBUTED_TO_ACCIDENTNO" then do;
ROLE = "ASSESS";
end;
else 
if upcase(NAME) = "Q_CONTRIBUTED_TO_ACCIDENTYES" then do;
ROLE = "ASSESS";
end;
