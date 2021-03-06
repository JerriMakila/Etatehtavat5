<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="css\main.css">
<title>Asiakkaat</title>
</head>
<body>
<table id="listaus">
	<thead>
		<tr>
			<th colspan="5" id="uusiAsiakas"><span class="siirto">Lis�� uusi asiakas<span class="right-arrow"></span></span></th>
		</tr>
		<tr>
			<th>Hakusana:</th>
			<th colspan="3"><input type="text" id="hakusana"></th>
			<th><input type="button" value="Hae" id="hakunappi"></th>
		</tr>			
		<tr>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelinnumero</th>
			<th>S�hk�posti</th>	
			<th></th>						
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){
	haeAsiakkaat();
	
	$(".siirto").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	$("#hakunappi").click(function(){		
		haeAsiakkaat();
	});
	
	$(document.body).on("keypress", function(event){
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
        		"<td><span class='poista' onclick=poista('"+field.id+"','"+field.etunimi+"','"+field.sukunimi+"')>Poista</span></td>" +
        		"</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
}

function poista(id, etunimi, sukunimi){
	if(confirm("Haluatko varmasti poistaa asiakkaan " + etunimi + " " + sukunimi + "?")){
		$.ajax({url:"asiakkaat/" + id, type:"DELETE", dataType:"json", success:function(result) {
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto ep�onnistui.");
	        }else if(result.response==1){
	        	alert("Asiakkaan " + etunimi + " " + sukunimi + " poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}

</script>
</body>
</html>