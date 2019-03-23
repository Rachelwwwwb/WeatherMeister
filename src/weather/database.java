package weather;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class database {
	//check if the user input exists
	@SuppressWarnings("finally")
	public Boolean checkUser (String _username) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;	
		Boolean correct = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/weather2?user=root&password=root");
			ps = conn.prepareStatement("SELECT * FROM User WHERE username=?");
			ps.setString(1, _username);
			rs = ps.executeQuery();

			if(rs.next()) {
				//the username exists
				correct = true;
			}
		}
		catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
				return correct;
			}
			catch(SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
				return correct;
			}
		}
	}
	
	
	
	
	//validate the user inputs
	@SuppressWarnings("finally")
	public Boolean Validation(String _username, String _password) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;	
		Boolean correct = false;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/weather2?user=root&password=root");
			ps = conn.prepareStatement("SELECT * FROM User WHERE username=?");
			ps.setString(1, _username);
			rs = ps.executeQuery();

			if(rs.next()) {
				//then check password
				String userPassword = rs.getString("userPassword");
				if(userPassword.contentEquals(_password)) {
					correct = true;
				}
			}
		}
		catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}
		catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}
		finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
				return correct;
			}
			catch(SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
				return correct;
			}
		}		
	}
	
	@SuppressWarnings("resource")
	public void Register(String _username, String _password) {
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;	

			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/weather2?user=root&password=root");
				

				//checking whether the username already exists in the User table 
				ps = conn.prepareStatement("SELECT * FROM User WHERE username=?");
				ps.setString(1, _username);
				rs = ps.executeQuery();
				//if the username does not exist in the User table, insert into the User table 
				if(!rs.next()) {
					ps = conn.prepareStatement("INSERT INTO User (username, userpassword) VALUES (?, ?)");
					ps.setString(1, _username);
					ps.setString(2, _password);
					ps.executeUpdate();
				}
			}catch(SQLException sqle) {
				System.out.println("my too long username: "+_username);
				System.out.println("my too long password "+_password);

				System.out.println("sqle: " + sqle.getMessage());
			}catch(ClassNotFoundException cnfe) {
				System.out.println("cnfe: " + cnfe.getMessage());
			}finally {
				try {
					if(rs != null) {
						rs.close();
					}
					if(ps != null) {
						ps.close();
					}
					if(conn != null) {
						conn.close();
					}

				}catch(SQLException sqle) {
					System.out.println("sqle closing stuff: " + sqle.getMessage());
				}
			}
		
	}
	
	
	
	
	
	
	
	
	@SuppressWarnings("resource")
	public void increment(String _searchTerm, String _username) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;	
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/weather2?user=root&password=root");
					
			ps = conn.prepareStatement("INSERT INTO History (userName, searchHistory) VALUES (?,?)");
			ps.setString(1, _username);
			ps.setString(2, _searchTerm);
			ps.executeUpdate();


		}catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}

			}catch(SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
			}
		}
	}
	
	@SuppressWarnings("finally")
	public ArrayList<String> getData(String _username) {
		ArrayList<String> data = new ArrayList<String>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;	
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/weather2?user=root&password=root");
			ps = conn.prepareStatement("SELECT * FROM History WHERE userName=? ORDER BY historyID DESC");
			ps.setString(1, _username);
			rs = ps.executeQuery();
			
			while(rs.next()) {
				String search = rs.getString("searchHistory");
				data.add(search);
			}		
		}catch(SQLException sqle) {
			System.out.println("sqle: " + sqle.getMessage());
		}catch(ClassNotFoundException cnfe) {
			System.out.println("cnfe: " + cnfe.getMessage());
		}finally {
			try {
				if(rs != null) {
					rs.close();
				}
				if(ps != null) {
					ps.close();
				}
				if(conn != null) {
					conn.close();
				}
				if (data == null) {
					System.out.println("it is null");
				}
				return data;
			}catch(SQLException sqle) {
				System.out.println("sqle closing stuff: " + sqle.getMessage());
				return data;
			}
		}
	}
	
	
	
	
	
	
	
	

	
	
	
	
	
	
}
