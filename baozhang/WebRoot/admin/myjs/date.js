var minus="";
var hours="";
var day="";
var month="";
var ampm="";
var ampmhour="";
var myweekday="";
var year="";
mydate=new Date();
minus=mydate.getMinutes();
if(minus<10)minus='0'+minus;
hours=mydate.getHours();
myweekday=mydate.getDay();
mymonth=mydate.getMonth()+1;
if(mymonth<10)mymonth='0'+mymonth;
myday= mydate.getDate();
if(myday<10)myday='0'+ myday;
myyear= mydate.getYear();
year=(myyear > 200) ? myyear : 1900 + myyear;

document.write(year+"-"+mymonth+"-"+myday+" "+hours+":"+minus);


