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
		String hakusana = "";
		
		if(pathInfo != null) {
			hakusana = pathInfo.replace("/", "");
		}
		
		Dao dao = new Dao();
		ArrayList<Asiakas> asiakkaat;
		
		if(hakusana == "" || hakusana == "*") {
			asiakkaat = dao.listaaKaikki();
		} else {
			asiakkaat = dao.listaaKaikki(hakusana);
		}
		
		String strJSON = new JSONObject().put("asiakkaat", asiakkaat).toString();	
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
	
	protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String pathInfo = request.getPathInfo();
		String poistettavaAsiakas = pathInfo.replace("/", "");
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
