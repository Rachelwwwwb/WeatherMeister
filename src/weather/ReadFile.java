package weather;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


//AIzaSyBkHhaq2BaoRBGY8p-bkHa0TiIY93lzkoc
//google map api key
@WebServlet("/ReadFile")
public class ReadFile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String city = request.getParameter("city");
		String lat = request.getParameter("lat");
		String lon = request.getParameter("long");
		
		
		String endpoint = "";
		//if search by city name
		if(city != null && city.trim().length() != 0) {
			endpoint = "https://api.openweathermap.org/data/2.5/weather?q="+city.trim()+"&appid=638481b3287db2ea6a8390b8a109de12";
		}
		
		//if search by location
		else if(lat != null && lat.trim().length() != 0 && lon != null && lon.trim().length() != 0) {
			Double dblat = Double.parseDouble(lat);
			Double dblon = Double.parseDouble(lon);
			endpoint = "https://api.openweathermap.org/data/2.5/weather?lat="+dblat+"&lon="+dblon+"&appid=638481b3287db2ea6a8390b8a109de12";
		}
		else {
			//stay on the page
		}
		
		
		boolean correct = true;
		if (endpoint.trim().length() <= 0) {
			request.setAttribute("error", "The input is incorrect");
			RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/allcity.jsp");
			dispatch.forward(request,response);
		}
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/display.jsp");
		dispatch.forward(request,response);
		
		
		//it is display everything


//		else {
//			request.setAttribute("errorMessage", "does not exist!!!!");
//			RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/display.jsp");
//			dispatch.forward(request,response);
//		}
		
	
	}
	


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
