<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%	
	int ika = Calendar.getInstance().get(Calendar.YEAR) - Integer.parseInt(request.getParameter("svuosi"));

	if(ika < 18){
		out.print("Alaikäinen");
		response.setHeader("Refresh", "5; URL=kysy.jsp");
	} else {
		out.print("Nimi: " + request.getParameter("etunimi") + " " + request.getParameter("sukunimi") +
				"<br>Sähköposti: " + request.getParameter("sposti") +
				"<br>Puhelinnumero: " + request.getParameter("puhnro") +
				"<br>Ikä: " + ika);
	}
%>   
</body>
</html>