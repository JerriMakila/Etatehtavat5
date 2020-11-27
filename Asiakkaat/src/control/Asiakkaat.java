package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import model.Asiakas;
import model.dao.Dao;


@WebServlet("/asiakkaat/*")
public class Asiakkaat extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public Asiakkaat() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		Dao dao = new Dao();
		ArrayList<Asiakas> asiakkaat;
		String hakusana = "";
		String strJSON;
		
		if(pathInfo != null) {
			hakusana = pathInfo.replace("/", "");
		}
		
		if(hakusana == "" || hakusana == "*") {
			asiakkaat = dao.listaaKaikki();
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();
		} else if(hakusana.indexOf("haeyksi")!=-1) {
			String id = hakusana.replace("haeyksi", "");
			Asiakas asiakas = dao.etsiAsiakas(Integer.parseInt(id));
			JSONObject JSON = new JSONObject();
			JSON.put("id", asiakas.getId());
			JSON.put("etunimi", asiakas.getEtunimi());
			JSON.put("sukunimi", asiakas.getSukunimi());
			JSON.put("puhelin", asiakas.getPuhelin());
			JSON.put("sposti", asiakas.getSposti());	
			strJSON = JSON.toString();
		} else {
			asiakkaat = dao.listaaKaikki(hakusana);
			strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();	
		}
		
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.println(strJSON);	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject jsonObj = new JsonStrToObj().convert(request);		
		Asiakas asiakas = new Asiakas();
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();		
		
		if(dao.lisaaAsiakas(asiakas)){
			out.println("{\"response\":1}");
		}else{
			out.println("{\"response\":0}");
		}		
	}
	
	protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Asiakkaat.doPut()");
		JSONObject jsonObj = new JsonStrToObj().convert(request);
		System.out.println(jsonObj);
		Asiakas asiakas = new Asiakas();
		asiakas.setId(Integer.parseInt(jsonObj.getString("id")));
		System.out.println(asiakas.getId());
		asiakas.setEtunimi(jsonObj.getString("etunimi"));
		asiakas.setSukunimi(jsonObj.getString("sukunimi"));
		asiakas.setPuhelin(jsonObj.getString("puhelin"));
		asiakas.setSposti(jsonObj.getString("sposti"));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();			
		if(dao.muutaAsiakas(asiakas)){
			out.println("{\"response\":1}");
		}else{
			out.println("{\"response\":0}");
		}		
	}
	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		int poistettavaAsiakas = Integer.parseInt(pathInfo.replace("/", ""));
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		Dao dao = new Dao();
		
		if(dao.poistaAsiakas(poistettavaAsiakas)){
			out.println("{\"response\":1}");
		}else{
			out.println("{\"response\":0}");
		}	
	}
}
