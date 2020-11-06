package gdqy.edu.cn.util;

import java.util.regex.*;


public class Tool {
	
	
	public static String get_two_decimal_number(String number){
		
		if(number.indexOf(".")==-1)
			{
			return number;
			}
		else if(number.length()-number.indexOf('.')-1<=2)
			
			{
			return number;
			
			}
		else{
			return number.substring(0, number.indexOf('.'))+number.substring(number.indexOf('.'),number.indexOf('.')+3);
		}
	}
	
	public static boolean isNumeric(String str){ 
		Pattern pattern = Pattern.compile("[0-9,.]*"); 
		return pattern.matcher(str).matches(); 
		} 

}
