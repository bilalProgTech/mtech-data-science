data fewlines;
infile '/folders/myfolders/fewlines.txt';
length Record_Indicator $2.
Segment $4.
Order_Date $8.
Order_No $8.
Transaction_Time $14.
Order_Type $1.
Activity_type $1.
Symbol  $10.
Instrument $6.
Expiry_Date $9.
Strike_Price $8.
Option_Type $2.
Volume_Disclosed $8.
Volume_Original $8.
Limit_Price $8.
Trigger_Price $8.
Market_Flag $1.
OnStop_Flag $1.
IO_Flag $1.
Spread_Type $1.
Algo_Indicator $1.
Client_Identity_Flag $1.
;
 input
Record_Indicator $2.
Segment $4.
Order_Date $8.
Order_No $8.
Transaction_Time $14.
Order_Type $1.
Activity_type $1.
Symbol  $10.
Instrument $6.
Expiry_Date $9.
Strike_Price $8.
Option_Type $2.
Volume_Disclosed $8.
Volume_Original $8.
Limit_Price $8.
Trigger_Price $8.
Market_Flag $1.
OnStop_Flag $1.
IO_Flag $1.
Spread_Type $1.
Algo_Indicator $1.
Client_Identity_Flag $1.
;
 run;