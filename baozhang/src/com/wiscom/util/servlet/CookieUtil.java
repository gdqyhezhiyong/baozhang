/*    */ package com.wiscom.util.servlet;
/*    */ 
/*    */ import javax.servlet.http.Cookie;
/*    */ import javax.servlet.http.HttpServletRequest;
/*    */ import javax.servlet.http.HttpServletResponse;
/*    */ 
/*    */ public class CookieUtil
/*    */ {
/*    */   public static void invalidateCookie(HttpServletResponse response, String cookieName, String domain, String path)
/*    */   {
/* 11 */     setCookie(response, cookieName, null, domain, 0, path);
/*    */   }
/*    */ 
/*    */   public static void invalidateCookie(HttpServletResponse response, String cookieName, String domain) {
/* 15 */     invalidateCookie(response, cookieName, domain, "/");
/*    */   }
/*    */ 
/*    */   public static Cookie getCookie(HttpServletRequest request, String name) {
/* 19 */     Cookie[] cookies = request.getCookies();
/* 20 */     if ((cookies == null) || (name == null) || (name.length() == 0))
/* 21 */       return null;
/* 22 */     for (int i = 0; i < cookies.length; ++i) {
/* 23 */       if (cookies[i].getName().equals(name))
/* 24 */         return cookies[i];
/*    */     }
/* 26 */     return null;
/*    */   }
/*    */ 
/*    */   public static String getCookieValue(HttpServletRequest request, String name) {
/* 30 */     Cookie cookie = getCookie(request, name);
/* 31 */     if (cookie != null) {
/* 32 */       return cookie.getValue();
/*    */     }
/* 34 */     return null;
/*    */   }
/*    */ 
/*    */   public static Cookie setCookie(HttpServletResponse response, String name, String value, String domain, int maxAge, String path)
/*    */   {
/* 39 */     Cookie cookie = new Cookie(name, value);
/* 40 */     cookie.setDomain(domain);
/* 41 */     cookie.setMaxAge(maxAge);
/* 42 */     cookie.setPath(path);
/* 43 */     response.addCookie(cookie);
/* 44 */     return cookie;
/*    */   }
/*    */ 
/*    */   public static String getDefaultCookiePath(HttpServletRequest request) {
/* 48 */     String path = request.getContextPath();
/* 49 */     if ((path == null) || (path.equals("")))
/* 50 */       return "/";
/* 51 */     if (!(path.startsWith("/"))) {
/* 52 */       return "/" + path;
/*    */     }
/* 54 */     return path;
/*    */   }
/*    */ 
/*    */   public static String getDefaultCookieDomain(HttpServletRequest request) {
/* 58 */     String serverName = request.getServerName();
/* 59 */     return serverName.substring(serverName.indexOf(46));
/*    */   }
/*    */ }

/* Location:           E:\exp\baozhang\WEB-INF\classes\
 * Qualified Name:     com.wiscom.util.servlet.CookieUtil
 * JD-Core Version:    0.5.3
 */