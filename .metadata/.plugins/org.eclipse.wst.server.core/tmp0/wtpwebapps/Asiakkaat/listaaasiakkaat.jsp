<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title>Insert title here</title>
<style>
	input[type=button] {
		background-color: white;
	}

	table {
		border-collapse: collapse;
		margin: auto;
	}

	th,
	td {
		border: 1px solid black;
		padding: 5px 10px;
	}
	
	thead tr {
		background-color: purple;
		color: white;
	}
	
	thead th {
		border: 1px solid white;
	}
	
	.asiakasrivi:nth-of-type(even){
		background-color: #E8E8E8;
	}
</style>
</head>
<body>
<table id="listaus">
	<thead>	
		<tr>
			<th>Hakusana:</th>
			<th colspan="2"><input type="text" id="hakusana"></th>
			<th><input type="button" value="Hae" id="hakunappi"></th>
		</tr>			
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelinnumero</th>
			<th>Sähköposti</th>							
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){
	haeAsiakkaat();
	
	$("#hakunappi").click(function(){		
		haeAsiakkaat();
	});
	
	$(document.body).on("keydown", function(event){
		  if(event.which==13){
			  haeAsiakkaat();
		  }
	});
	
	$("#hakusana").focus();
});	

function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/"+$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){	
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr = "<tr class='asiakasrivi'>" +
        		"<td>"+field.etunimi+"</td>" +
        		"<td>"+field.sukunimi+"</td>" +
        		"<td>"+field.puhelin+"</td>" +
        		"<td>"+field.sposti+"</td>" +  
        		"</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
}

</script>
</body>
</html>