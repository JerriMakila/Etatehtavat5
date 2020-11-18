<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
      label {
         display: inline-block;
         width: 105px;
      }

      input {
         border: 1px solid lightgray;
         border-radius: 5px;
         padding: 5px;
      }
      input[type=submit]:focus {
      	outline: none;
      }
      input[type=submit]:active {
      	background-color: darkgrey;
      	color: white;
      }
      input[type=text]:focus {
      	 border: 1px solid black;
         outline: none;
      }

      .row {
         margin-bottom: 10px;
      }
</style>
</head>
<body>
	<form action="nayta.jsp" method="POST">
      <div class="row">
         <label for="etunimi">Etunimi:</label>
         <input type="text" name="etunimi">
      </div>
      <div class="row">
         <label for="sukunimi">Sukunimi:</label>
         <input type="text" name="sukunimi">
      </div>
      <div class="row">
         <label for="sposti">Sähköposti:</label>
         <input type="text" name="sposti">
      </div>
      <div class="row">
         <label for="puhnro">Puhelinnumero:</label>
         <input type="text" name="puhnro">
      </div>
      <div class="row">
         <label for="svuosi">Syntymävuosi:</label>
         <input type="text" name="svuosi">
      </div>
      <input type="submit" value="Lähetä">
   </form>
</body>
</html>