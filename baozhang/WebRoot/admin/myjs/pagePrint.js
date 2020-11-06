function createBill(id,bz_name,addreass,phone,project,order_date,weixiu_name,plan_time,divId){
var div1 =document.createElement("div");
 div1.setAttribute("id", "bill_detail");
 var h1= document.createElement("h3");
 h1.setAttribute("align", "center");
 h1.innerText ="维  修   单";
 div1.appendChild(h1);
 mydate=new Date();
 var h2= document.createElement("h5");
 h2.setAttribute("align", "center");
 h2.innerText ="单号:"+id+"  时间:"+mydate.getYear()+"-"+(mydate.getMonth()+1)+"-"+mydate.getDate()+" "+mydate.getHours()+":"+mydate.getMinutes();
 div1.appendChild(h2);
  
  var t1= document.createElement("table");
  t1.setAttribute("width","95%");
  t1.setAttribute("border","1");
  t1.setAttribute("align","acenter");
  t1.setAttribute("cellpadding","1");
  t1.setAttribute("cellspacing","0");
  
  //第一行
  var tr1 = t1.insertRow(t1.rows.length);
  
  var td11 = tr1.insertCell(0); 
  td11.setAttribute("width","9%");
  td11.setAttribute("height","25");
  td11.innerHTML="用户名称"; 
  tr1.appendChild(td11);
  
  var td12 = tr1.insertCell(1); 
  td12.setAttribute("colspan","2");
  td12.innerHTML=" "+bz_name; 
  tr1.appendChild(td12);
  
  
  var td13 = tr1.insertCell(2); 
  td13.setAttribute("width","11%");
  td13.setAttribute("height","25");
  td13.innerHTML="用户地址" ;
  tr1.appendChild(td13);
  
  var td14 = tr1.insertCell(3); 
  td14.setAttribute("colspan","2");
  td14.innerHTML=addreass; 
  tr1.appendChild(td14);
  
  var td15 = tr1.insertCell(4); 
  td15.setAttribute("width","11%");
  td15.setAttribute("height","25");
  td15.innerHTML="联系电话"; 
  tr1.appendChild(td15);
  
  var td16 = tr1.insertCell(5); 
  td16.setAttribute("colspan","2");
  td16.innerHTML=phone; 
  tr1.appendChild(td16);
  
 //第二行
 var tr2 = t1.insertRow(t1.rows.length);
  
  var td21 = tr2.insertCell(0); 
  td21.setAttribute("width","9%");
  td21.setAttribute("rowspan","3");
  td21.innerHTML="报修项目"; 
  tr2.appendChild(td21); 
  
  var td22 = tr2.insertCell(1); 
  td22.setAttribute("width","16%");
  td22.setAttribute("rowspan","3");
  td22.innerHTML=" "+project; 
  tr2.appendChild(td22); 
  
   var td23 = tr2.insertCell(2); 
  td23.setAttribute("width","9%");
  td23.setAttribute("height","25");
  td23.innerHTML="预约时间"; 
  tr2.appendChild(td23);
  
  var td24= tr2.insertCell(3); 
  td24.setAttribute("width","11%");
  td24.innerHTML=plan_time; 
  tr2.appendChild(td24); 
  
  var td25 = tr2.insertCell(4); 
  td25.setAttribute("width","12%");
  td25.innerHTML="到达时间"; 
  tr2.appendChild(td25);
  
  var td26= tr2.insertCell(5); 
  td26.setAttribute("width","12%");
  td26.innerHTML=" "; 
  tr2.appendChild(td26); 
  
   var td27 = tr2.insertCell(6); 
  td27.setAttribute("width","11%");
  td27.innerHTML="确认人" ;
  tr2.appendChild(td27);
  
  var td28= tr2.insertCell(7); 
  td28.setAttribute("width","25%");
  td28.innerHTML=" " ;
  tr2.appendChild(td28); 
  
  //第三行
  var tr3 = t1.insertRow(t1.rows.length);
  
  var td31 = tr3.insertCell(0); 
  td31.setAttribute("width","9%");
  td31.setAttribute("height","25");
  td31.innerHTML="记录时间"; 
  tr3.appendChild(td31); 
  
  var td32 = tr3.insertCell(1); 
  td32.setAttribute("colspan","2");
  tr3.appendChild(td32);
  
  var td33 = tr3.insertCell(2); 
  td33.setAttribute("width","12%");
  td33.innerHTML="记录人"; 
  tr3.appendChild(td33); 
  
  var td34 = tr3.insertCell(3); 
  td34.setAttribute("colspan","2");
  tr3.appendChild(td34);  
  
  //第四行
  var tr4 = t1.insertRow(t1.rows.length);
  
  var td41 = tr4.insertCell(0); 
  td41.setAttribute("width","9%");
  td41.setAttribute("height","25");
  td41.innerHTML="接单时间"; 
  tr4.appendChild(td41); 
  
  var td42 = tr4.insertCell(1); 
  td42.setAttribute("colspan","2");
  tr4.appendChild(td42);
  
  var td43 = tr4.insertCell(2); 
  td43.setAttribute("width","12%");
  td43.innerHTML="接单人"; 
  tr4.appendChild(td43); 
  
  var td44 = tr4.insertCell(3); 
  td44.setAttribute("colspan","2");
  tr4.appendChild(td44);  
  
  //第五行
  
  
  var tr5 = t1.insertRow(t1.rows.length);
  var td51 = tr5.insertCell(0); 
  td51.setAttribute("width","9%");
  td51.setAttribute("rowspan","2");
  td51.innerHTML="维修项目"; 
  tr5.appendChild(td51); 
  
  var td52 = tr5.insertCell(1); 
  td52.setAttribute("width","16%");
  td52.setAttribute("rowspan","2");
  tr5.appendChild(td52); 
  
  var td53 = tr5.insertCell(2); 
  td53.setAttribute("width","12%");
  td53.setAttribute("height","25");
  td53.innerHTML="开工时间"; 
  tr5.appendChild(td53); 
  
  var td54 = tr5.insertCell(3); 
  td54.setAttribute("colspan","2");
  tr5.appendChild(td54);  
  
  var td55 = tr5.insertCell(4); 
  td55.setAttribute("width","12%");
  td55.innerHTML="维修工时"; 
  tr5.appendChild(td55); 
  
  var td56 = tr5.insertCell(5); 
  td56.setAttribute("colspan","2");
  tr5.appendChild(td56); 
  
  //第6行
  var tr6 = t1.insertRow(t1.rows.length);
  var td63 = tr6.insertCell(0); 
  td63.setAttribute("width","12%");
  td63.setAttribute("height","25");
  td63.innerHTML="完工时间";
  tr6.appendChild(td63); 
  
  var td64 = tr6.insertCell(1); 
  td64.setAttribute("colspan","2");
  tr6.appendChild(td64);  
  
  var td65 = tr6.insertCell(2); 
  td65.setAttribute("width","12%");
  td65.innerHTML="维修人";
  tr6.appendChild(td65); 
  
  var td66 = tr6.insertCell(3); 
  td66.setAttribute("colspan","2");
  tr6.appendChild(td66); 
  
  //第7行
  
   var tr7 = t1.insertRow(t1.rows.length);
  
  var td71= tr7.insertCell(0); 
  td71.setAttribute("height","25");
  td71.innerHTML="材料名称";
  tr7.appendChild(td71); 
   
  var td72= tr7.insertCell(1); 
  td72.innerHTML="材料提供方";
  tr7.appendChild(td72);  
  
  var td73= tr7.insertCell(2); 
  td73.innerHTML="规格";
  tr7.appendChild(td73);  
  
  var td74= tr7.insertCell(3); 
  td74.innerHTML="数量";
  tr7.appendChild(td74);  
  
  var td75= tr7.insertCell(4); 
  td75.innerHTML="单价(元)";
  tr7.appendChild(td75);  
  
  var td76= tr7.insertCell(5); 
  td76.innerHTML="计价(元)";
  tr7.appendChild(td76);
  
  var td77= tr7.insertCell(6); 
  td77.innerHTML="备注";
  td77.setAttribute("colspan","2");
  tr7.appendChild(td77); 
  
  //第8行  
  var tr8 = t1.insertRow(t1.rows.length);
  
  var td81= tr8.insertCell(0); 
  td81.setAttribute("height","25");
  tr8.appendChild(td81); 
   
  var td82= tr8.insertCell(1); 
  tr8.appendChild(td82);  
  
  var td83= tr8.insertCell(2); 
  tr8.appendChild(td83);  
  
  var td84= tr8.insertCell(3); 
  tr8.appendChild(td84);  
  
  var td85= tr8.insertCell(4); 
  tr8.appendChild(td85);  
  
  var td86= tr8.insertCell(5); 
  tr8.appendChild(td86);
  
  var td87= tr8.insertCell(6); 
  td87.setAttribute("colspan","2");
  tr8.appendChild(td87); 
  
  //第9行  
  var tr9 = t1.insertRow(t1.rows.length);
  
  var td91= tr9.insertCell(0); 
  td91.setAttribute("height","25");
  tr9.appendChild(td91); 
   
  var td92= tr9.insertCell(1); 
  tr9.appendChild(td92);  
  
  var td93= tr9.insertCell(2); 
  tr9.appendChild(td93);  
  
  var td94= tr9.insertCell(3); 
  tr9.appendChild(td94);  
  
  var td95= tr9.insertCell(4); 
  tr9.appendChild(td95);  
  
  var td96= tr9.insertCell(5); 
  tr9.appendChild(td96);
  
  var td97= tr9.insertCell(6); 
  td97.setAttribute("colspan","2");
  tr9.appendChild(td97); 
  
  //第10行  
  var tr10 = t1.insertRow(t1.rows.length);
  
  var td101= tr10.insertCell(0); 
  td101.setAttribute("height","25");
  tr10.appendChild(td101); 
   
  var td102= tr10.insertCell(1); 
  tr10.appendChild(td102);  
  
  var td103= tr10.insertCell(2); 
  tr10.appendChild(td103);  
  
  var td104= tr10.insertCell(3); 
  tr10.appendChild(td104);  
  
  var td105= tr10.insertCell(4); 
  tr10.appendChild(td105);  
  
  var td106= tr10.insertCell(5); 
  tr10.appendChild(td106);
  
  var td107= tr10.insertCell(6); 
  td107.setAttribute("colspan","2");
  tr10.appendChild(td107); 
  
  //第11行  
  var tr11 = t1.insertRow(t1.rows.length);
  
  var td111= tr11.insertCell(0); 
  td111.setAttribute("height","25");
  tr11.appendChild(td111); 
   
  var td112= tr11.insertCell(1); 
  tr11.appendChild(td112);  
  
  var td113= tr11.insertCell(2); 
  tr11.appendChild(td113);  
  
  var td114= tr11.insertCell(3); 
  tr11.appendChild(td114);  
  
  var td115= tr11.insertCell(4); 
  tr11.appendChild(td115);  
  
  var td116= tr11.insertCell(5); 
  tr11.appendChild(td116);
  
  var td117= tr11.insertCell(6); 
  td117.setAttribute("colspan","2");
  tr11.appendChild(td117); 
  
  
  //第12行  
  var tr12 = t1.insertRow(t1.rows.length);
  
  var td121= tr12.insertCell(0); 
  td121.setAttribute("height","25");
  tr12.appendChild(td121); 
   
  var td122= tr12.insertCell(1); 
  tr12.appendChild(td122);  
  
  var td123= tr12.insertCell(2); 
  tr12.appendChild(td123);  
  
  var td124= tr12.insertCell(3); 
  tr12.appendChild(td124);  
  
  var td125= tr12.insertCell(4); 
  tr12.appendChild(td125);  
  
  var td126= tr12.insertCell(5); 
  tr12.appendChild(td126);
  
  var td127= tr12.insertCell(6); 
  td127.setAttribute("colspan","2");
  tr12.appendChild(td127); 
  
  //第13行  
  var tr13 = t1.insertRow(t1.rows.length);
  
  var td131= tr13.insertCell(0);
  td131.setAttribute("height","25"); 
  td131.innerHTML="工程主管";
  tr13.appendChild(td131); 
  
  var td132= tr13.insertCell(1); 
  td132.setAttribute("colspan","7");
  tr13.appendChild(td132); 
  
  
  //第14行  
  var tr14 = t1.insertRow(t1.rows.length);
  
  var td141= tr14.insertCell(0); 
  td141.innerHTML="用户意见";
  td141.setAttribute("height","25");
  tr14.appendChild(td141); 
  
  var td142= tr14.insertCell(1); 
  td142.setAttribute("colspan","2");
  tr14.appendChild(td142); 
  
  
  var td143= tr14.insertCell(2); 
  td143.innerHTML="回访时间";
  tr14.appendChild(td143); 
  
  var td144= tr14.insertCell(3); 
  td144.setAttribute("colspan","2");
  tr14.appendChild(td144); 
  
   var td145= tr14.insertCell(4); 
  td145.innerHTML="用户签名";
  tr14.appendChild(td145); 
  
  var td146= tr14.insertCell(5); 
  td146.setAttribute("colspan","2");
  tr14.appendChild(td146); 
  
  div1.appendChild(t1);
  //alert(divId);
  document.getElementById(divId).appendChild(div1);
  
  var br1 =document.createElement("br");
  document.getElementById(divId).appendChild(br1);
  var hr1= document.createElement("hr");
  document.getElementById(divId).appendChild(hr1);
  
  
  var div1 =document.createElement("div");
 div1.setAttribute("id", "bill_detail");
 var h1= document.createElement("h3");
 h1.setAttribute("align", "center");
 h1.innerText ="维  修   单";
 div1.appendChild(h1);
 mydate=new Date();
 var h2= document.createElement("h5");
 h2.setAttribute("align", "center");
 h2.innerText ="单号:"+id+"  时间:"+mydate.getYear()+"-"+(mydate.getMonth()+1)+"-"+mydate.getDate()+" "+mydate.getHours()+":"+mydate.getMinutes();
 div1.appendChild(h2);
  
  var t1= document.createElement("table");
  t1.setAttribute("width","95%");
  t1.setAttribute("border","1");
  t1.setAttribute("align","acenter");
  t1.setAttribute("cellpadding","1");
  t1.setAttribute("cellspacing","0");
  
  //第一行
  var tr1 = t1.insertRow(t1.rows.length);
  
  var td11 = tr1.insertCell(0); 
  td11.setAttribute("width","9%");
  td11.setAttribute("height","25");
  td11.innerHTML="用户名称"; 
  tr1.appendChild(td11);
  
  var td12 = tr1.insertCell(1); 
  td12.setAttribute("colspan","2");
  td12.innerHTML=bz_name; 
  tr1.appendChild(td12);
  
  
  var td13 = tr1.insertCell(2); 
  td13.setAttribute("width","11%");
  td13.setAttribute("height","25");
  td13.innerHTML="用户地址" ;
  tr1.appendChild(td13);
  
  var td14 = tr1.insertCell(3); 
  td14.setAttribute("colspan","2");
  td14.innerHTML=addreass; 
  tr1.appendChild(td14);
  
  var td15 = tr1.insertCell(4); 
  td15.setAttribute("width","11%");
  td15.setAttribute("height","25");
  td15.innerHTML="联系电话"; 
  tr1.appendChild(td15);
  
  var td16 = tr1.insertCell(5); 
  td16.setAttribute("colspan","2");
  td16.innerHTML=phone; 
  tr1.appendChild(td16);
  
 //第二行
 var tr2 = t1.insertRow(t1.rows.length);
  
  var td21 = tr2.insertCell(0); 
  td21.setAttribute("width","9%");
  td21.setAttribute("rowspan","3");
  td21.innerHTML="报修项目"; 
  tr2.appendChild(td21); 
  
  var td22 = tr2.insertCell(1); 
  td22.setAttribute("width","16%");
  td22.setAttribute("rowspan","3");
  td22.innerHTML=project; 
  tr2.appendChild(td22); 
  
   var td23 = tr2.insertCell(2); 
  td23.setAttribute("width","9%");
  td23.setAttribute("height","25");
  td23.innerHTML="预约时间"; 
  tr2.appendChild(td23);
  
  var td24= tr2.insertCell(3); 
  td24.setAttribute("width","11%");
  td24.innerHTML=plan_time; 
  tr2.appendChild(td24); 
  
  var td25 = tr2.insertCell(4); 
  td25.setAttribute("width","12%");
  td25.innerHTML="到达时间"; 
  tr2.appendChild(td25);
  
  var td26= tr2.insertCell(5); 
  td26.setAttribute("width","12%");
  tr2.appendChild(td26); 
  
   var td27 = tr2.insertCell(6); 
  td27.setAttribute("width","11%");
  td27.innerHTML="确认人" ;
  tr2.appendChild(td27);
  
  var td28= tr2.insertCell(7); 
  td28.setAttribute("width","25%");
  tr2.appendChild(td28); 
  
  //第三行
  var tr3 = t1.insertRow(t1.rows.length);
  
  var td31 = tr3.insertCell(0); 
  td31.setAttribute("width","9%");
  td31.setAttribute("height","25");
  td31.innerHTML="记录时间"; 
  tr3.appendChild(td31); 
  
  var td32 = tr3.insertCell(1); 
  td32.setAttribute("colspan","2");
  tr3.appendChild(td32);
  
  var td33 = tr3.insertCell(2); 
  td33.setAttribute("width","12%");
  td33.innerHTML="记录人"; 
  tr3.appendChild(td33); 
  
  var td34 = tr3.insertCell(3); 
  td34.setAttribute("colspan","2");
  tr3.appendChild(td34);  
  
  //第四行
  var tr4 = t1.insertRow(t1.rows.length);
  
  var td41 = tr4.insertCell(0); 
  td41.setAttribute("width","9%");
  td41.setAttribute("height","25");
  td41.innerHTML="接单时间"; 
  tr4.appendChild(td41); 
  
  var td42 = tr4.insertCell(1); 
  td42.setAttribute("colspan","2");
  tr4.appendChild(td42);
  
  var td43 = tr4.insertCell(2); 
  td43.setAttribute("width","12%");
  td43.innerHTML="接单人"; 
  tr4.appendChild(td43); 
  
  var td44 = tr4.insertCell(3); 
  td44.setAttribute("colspan","2");
  tr4.appendChild(td44);  
  
  //第五行
  
  
  var tr5 = t1.insertRow(t1.rows.length);
  var td51 = tr5.insertCell(0); 
  td51.setAttribute("width","9%");
  td51.setAttribute("rowspan","2");
  td51.innerHTML="维修项目"; 
  tr5.appendChild(td51); 
  
  var td52 = tr5.insertCell(1); 
  td52.setAttribute("width","16%");
  td52.setAttribute("rowspan","2");
  tr5.appendChild(td52); 
  
  var td53 = tr5.insertCell(2); 
  td53.setAttribute("width","12%");
  td53.setAttribute("height","25");
  td53.innerHTML="开工时间"; 
  tr5.appendChild(td53); 
  
  var td54 = tr5.insertCell(3); 
  td54.setAttribute("colspan","2");
  tr5.appendChild(td54);  
  
  var td55 = tr5.insertCell(4); 
  td55.setAttribute("width","12%");
  td55.innerHTML="维修工时"; 
  tr5.appendChild(td55); 
  
  var td56 = tr5.insertCell(5); 
  td56.setAttribute("colspan","2");
  tr5.appendChild(td56); 
  
  //第6行
  var tr6 = t1.insertRow(t1.rows.length);
  var td63 = tr6.insertCell(0); 
  td63.setAttribute("width","12%");
  td63.setAttribute("height","25");
  td63.innerHTML="完工时间";
  tr6.appendChild(td63); 
  
  var td64 = tr6.insertCell(1); 
  td64.setAttribute("colspan","2");
  tr6.appendChild(td64);  
  
  var td65 = tr6.insertCell(2); 
  td65.setAttribute("width","12%");
  td65.innerHTML="维修人";
  tr6.appendChild(td65); 
  
  var td66 = tr6.insertCell(3); 
  td66.setAttribute("colspan","2");
  tr6.appendChild(td66); 
  
  //第7行
  
   var tr7 = t1.insertRow(t1.rows.length);
  
  var td71= tr7.insertCell(0); 
  td71.setAttribute("height","25");
  td71.innerHTML="材料名称";
  tr7.appendChild(td71); 
   
  var td72= tr7.insertCell(1); 
  td72.innerHTML="材料提供方";
  tr7.appendChild(td72);  
  
  var td73= tr7.insertCell(2); 
  td73.innerHTML="规格";
  tr7.appendChild(td73);  
  
  var td74= tr7.insertCell(3); 
  td74.innerHTML="数量";
  tr7.appendChild(td74);  
  
  var td75= tr7.insertCell(4); 
  td75.innerHTML="单价(元)";
  tr7.appendChild(td75);  
  
  var td76= tr7.insertCell(5); 
  td76.innerHTML="计价(元)";
  tr7.appendChild(td76);
  
  var td77= tr7.insertCell(6); 
  td77.innerHTML="备注";
  td77.setAttribute("colspan","2");
  tr7.appendChild(td77); 
  
  //第8行  
  var tr8 = t1.insertRow(t1.rows.length);
  
  var td81= tr8.insertCell(0); 
  td81.setAttribute("height","25");
  tr8.appendChild(td81); 
   
  var td82= tr8.insertCell(1); 
  tr8.appendChild(td82);  
  
  var td83= tr8.insertCell(2); 
  tr8.appendChild(td83);  
  
  var td84= tr8.insertCell(3); 
  tr8.appendChild(td84);  
  
  var td85= tr8.insertCell(4); 
  tr8.appendChild(td85);  
  
  var td86= tr8.insertCell(5); 
  tr8.appendChild(td86);
  
  var td87= tr8.insertCell(6); 
  td87.setAttribute("colspan","2");
  tr8.appendChild(td87); 
  
  //第9行  
  var tr9 = t1.insertRow(t1.rows.length);
  
  var td91= tr9.insertCell(0); 
  td91.setAttribute("height","25");
  tr9.appendChild(td91); 
   
  var td92= tr9.insertCell(1); 
  tr9.appendChild(td92);  
  
  var td93= tr9.insertCell(2); 
  tr9.appendChild(td93);  
  
  var td94= tr9.insertCell(3); 
  tr9.appendChild(td94);  
  
  var td95= tr9.insertCell(4); 
  tr9.appendChild(td95);  
  
  var td96= tr9.insertCell(5); 
  tr9.appendChild(td96);
  
  var td97= tr9.insertCell(6); 
  td97.setAttribute("colspan","2");
  tr9.appendChild(td97); 
  
  //第10行  
  var tr10 = t1.insertRow(t1.rows.length);
  
  var td101= tr10.insertCell(0); 
  td101.setAttribute("height","25");
  tr10.appendChild(td101); 
   
  var td102= tr10.insertCell(1); 
  tr10.appendChild(td102);  
  
  var td103= tr10.insertCell(2); 
  tr10.appendChild(td103);  
  
  var td104= tr10.insertCell(3); 
  tr10.appendChild(td104);  
  
  var td105= tr10.insertCell(4); 
  tr10.appendChild(td105);  
  
  var td106= tr10.insertCell(5); 
  tr10.appendChild(td106);
  
  var td107= tr10.insertCell(6); 
  td107.setAttribute("colspan","2");
  tr10.appendChild(td107); 
  
  //第11行  
  var tr11 = t1.insertRow(t1.rows.length);
  
  var td111= tr11.insertCell(0); 
  td111.setAttribute("height","25");
  tr11.appendChild(td111); 
   
  var td112= tr11.insertCell(1); 
  tr11.appendChild(td112);  
  
  var td113= tr11.insertCell(2); 
  tr11.appendChild(td113);  
  
  var td114= tr11.insertCell(3); 
  tr11.appendChild(td114);  
  
  var td115= tr11.insertCell(4); 
  tr11.appendChild(td115);  
  
  var td116= tr11.insertCell(5); 
  tr11.appendChild(td116);
  
  var td117= tr11.insertCell(6); 
  td117.setAttribute("colspan","2");
  tr11.appendChild(td117); 
  
  
  //第12行  
  var tr12 = t1.insertRow(t1.rows.length);
  
  var td121= tr12.insertCell(0); 
  td121.setAttribute("height","25");
  tr12.appendChild(td121); 
   
  var td122= tr12.insertCell(1); 
  tr12.appendChild(td122);  
  
  var td123= tr12.insertCell(2); 
  tr12.appendChild(td123);  
  
  var td124= tr12.insertCell(3); 
  tr12.appendChild(td124);  
  
  var td125= tr12.insertCell(4); 
  tr12.appendChild(td125);  
  
  var td126= tr12.insertCell(5); 
  tr12.appendChild(td126);
  
  var td127= tr12.insertCell(6); 
  td127.setAttribute("colspan","2");
  tr12.appendChild(td127); 
  
  //第13行  
  var tr13 = t1.insertRow(t1.rows.length);
  
  var td131= tr13.insertCell(0);
  td131.setAttribute("height","25"); 
  td131.innerHTML="工程主管";
  tr13.appendChild(td131); 
  
  var td132= tr13.insertCell(1); 
  td132.setAttribute("colspan","7");
  tr13.appendChild(td132); 
  
  
  //第14行  
  var tr14 = t1.insertRow(t1.rows.length);
  
  var td141= tr14.insertCell(0); 
  td141.innerHTML="用户意见";
  td141.setAttribute("height","25");
  tr14.appendChild(td141); 
  
  var td142= tr14.insertCell(1); 
  td142.setAttribute("colspan","2");
  tr14.appendChild(td142); 
  
  
  var td143= tr14.insertCell(2); 
  td143.innerHTML="回访时间";
  tr14.appendChild(td143); 
  
  var td144= tr14.insertCell(3); 
  td144.setAttribute("colspan","2");
  tr14.appendChild(td144); 
  
   var td145= tr14.insertCell(4); 
  td145.innerHTML="用户签名";
  tr14.appendChild(td145); 
  
  var td146= tr14.insertCell(5); 
  td146.setAttribute("colspan","2");
  tr14.appendChild(td146); 
  
  div1.appendChild(t1);
  //alert(divId);
  document.getElementById(divId).appendChild(div1);
  
  
 
  
}