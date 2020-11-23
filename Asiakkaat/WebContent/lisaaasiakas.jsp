<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/additional-methods.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakkaan lisäys</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="5" id="takaisin"><span class="siirto"><span class="left-arrow"></span>Takaisin listaukseen</span></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelinnumero</th>
				<th>Sähköposti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td class="data-input"><input type="text" name="etunimi" id="etunimi"></td>
				<td class="data-input"><input type="text" name="sukunimi" id="sukunimi"></td>
				<td class="data-input"><input type="text" name="puhelin" id="puhelin"></td>
				<td class="data-input"><input type="text" name="sposti" id="sposti"></td> 
				<td class="data-input"><input type="submit" id="tallenna" value="Lisää"></td>
			</tr>
		</tbody>
	</table>
</form>
<div id="ilmo"></div>
</body>
<script>
$(document).ready(function(){
	$(".siirto").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	
	$("#tiedot").validate({						
		rules: {
			etunimi:  {
				required: true,
				maxlength: 50
			},	
			sukunimi:  {
				required: true,
				maxlength: 50
			},
			puhelin:  {
				required: true,
				pattern: '[+]?[0-9]{2,3}[-]?[0-9]{7,9}'
			},	
			sposti:  {
				required: true,
				email: true,
				maxlength: 100
			}	
		},
		messages: {
			etunimi: {     
				required: "Pakollinen tieto",
				maxlength: "Liian pitkä",
			},
			sukunimi: {
				required: "Pakollinen tieto",
				minlength: "Liian pitkä"
			},
			puhelin: {
				required: "Pakollinen tieto",
				pattern: "Syötä puhelinnumero"
			},
			sposti: {
				required: "Pakollinen tieto",
				email: "Syötä sähköpostiosoite",
				maxlength: "Liian pitkä"
			}
		},
		
		errorElement : 'div',
		submitHandler: function(form) {	
			lisaaTiedot();
		}		
	});
});

function lisaaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      		$("#ilmo").html("Asiakkaan lisääminen epäonnistui.");
      	}else if(result.response==1){			
      		$("#ilmo").html("Asiakkaan lisääminen onnistui.");
      		$("#tiedot").find("input[type=text]").val("");
	  	}		
  }});	
}
</script>
</html>