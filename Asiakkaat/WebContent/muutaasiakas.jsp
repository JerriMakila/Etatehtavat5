<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/jquery.validate.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.2/additional-methods.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>Asiakastietojen muuttaminen</title>
</head>
<body>
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="5" id="takaisin"><span class="siirto"><span class="left-arrow"></span>Takaisin listaukseen</span></th>
			</tr>
			<tr>
				<th colspan="5" id="ohje">Syötä uudet tiedot niihin kenttiin, joita haluat muuttaa<br>Voit jättää tyhjiksi ne kentät, joita ei muuteta</th>
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
	<input type="hidden" name="id" id="id">
</form>
<div id="ilmo"></div>
</body>
<script>
$(document).ready(function(){
	$(".siirto").click(function(){
		document.location="listaaasiakkaat.jsp";
	});
	var id = requestURLParam("id");
	$.ajax({url:"asiakkaat/haeyksi/"+id, type:"GET", dataType:"json", success:function(result){
		$("#id").val(result.id);
		$("#etunimi").attr("placeholder", result.etunimi);
		$("#sukunimi").attr("placeholder", result.sukunimi);
		$("#puhelin").attr("placeholder", result.puhelin);
		$("#sposti").attr("placeholder", result.sposti);	
    }});
	
	$("#tiedot").validate({						
		rules: {
			etunimi: {
				required: true,
				maxlength: 50,
				normalizer: function(value) {
			        if(value == ""){
			        	$(this).val($(this).attr("placeholder"));
			        	return $(this).attr("placeholder");
			        } else {
			        	return value;
			        }
			     }
			},	
			sukunimi:  {
				required: true,
				maxlength: 50,
				normalizer: function(value) {
			        if(value == ""){
			        	$(this).val($(this).attr("placeholder"));
			        	return $(this).attr("placeholder");
			        } else {
			        	return value;
			        }
			     }
			},
			puhelin:  {
				required: true,
				pattern: '[+]?[0-9]{2,3}[-]?[0-9]{7,9}',
				normalizer: function(value) {
			        if(value == ""){
			        	$(this).val($(this).attr("placeholder"));
			        	return $(this).attr("placeholder");
			        } else {
			        	return value;
			        }
			     }
			},	
			sposti:  {
				required: true,
				email: true,
				maxlength: 100,
				normalizer: function(value) {
			        if(value == ""){
			        	$(this).val($(this).attr("placeholder"));
			        	return $(this).attr("placeholder");
			        } else {
			        	return value;
			        }
			     }
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
			if(tarkastaKentat()){
				paivitaTiedot();
			} else {
				$("#ilmo").html("Syötä vähintään yksi muutettava tieto");
				tyhjennaKentat();
			}
		}		
	});
});

function paivitaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray());
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"PUT", dataType:"json", success:function(result) {
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan päivittäminen epäonnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan päivittäminen onnistui.");
      	tyhjennaKentat();
	  }
  }});	
}

function tarkastaKentat(){
	var tyhjatKentat = 0;
	
	$(":text").each(function(index){
		if($(this).val() == $(this).attr("placeholder")){
			tyhjatKentat++;
		} else {
			$(this).attr("placeholder", $(this).val());
		}
	});
	
	if(tyhjatKentat < $(":text").length){
		return true;
	}
	
	return false;
}

function tyhjennaKentat(){
	$(":text").each(function(){
  		$(this).val("");
  	});
}
</script>

</body>
</html>