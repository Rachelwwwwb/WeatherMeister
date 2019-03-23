<!DOCTYPE html>
<%@ page import="weather.database" %>
<%@ page import="java.util.ArrayList" %>


<%
//make sure there is only one database among the websites. There is no need to have more than one database
database _database = (database)session.getAttribute("my_database");
String username = (String)session.getAttribute("_username");
ArrayList<String> data = _database.getData(username);
System.out.println("size: "+data.size());

%>
<html>
<head>
	<title></title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">

<style>
	body, html {
  height: 100%;
}

@font-face { 
font-family: 'Avenir Next';
src:url(Assignment3Images/Avenir Next/ttc/Avenir Next.ttc);
}

* {
  box-sizing: border-box;
}

.bg-image {
  /* The image used */
  background-image: url("Assignment3Images/background-blur.jpg");
  z-index:-2; 

  /* Add the blur effect */
  filter: blur(3px);
  -webkit-filter: blur(3px);

  /* Full height */
  height: 100%; 
  width:100%;

  /* Center and scale the image nicely */
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
.bg-image-black {
  /* The image used */
  background-image: url("Assignment3Images/Black-Vignette.png");
  z-index:1; 
  /* Add the blur effect */
  filter: blur(3px);
  -webkit-filter: blur(3px);
  
  position:absolute;
  top:0;
  left:0;

  /* Full height */
  height: 100%; 
  width:100%;

  /* Center and scale the image nicely */
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}
.content{
  width:100%;
  position: absolute;
  top: 0;
  left: 0;
  z-index: 20;
}
/* Position text in the middle of the page/image */
.header {
  background-color: black; /* Fallback color */
  color: white;
  font-weight: bold;
  position: absolute;
  top: 0;
  left: 0;
  z-index: 2;
  width: 100%;
  padding-top: 30px;
  padding-left: 50px;
  font-size: 35px;
  font-family: 'Savoye LET';
}

a {
  text-decoration : none; 
  color : #FFFFFF;
}
a:hover{
  text-decoration : none; 
  color : #FFFFFF;
  cursor:initial;
}

#black-background {
position:absolute;
height:100%;
width:100%;
top:0;
left:0;
background-color: rgba(97,97,97,0.7);
z-index:6;
}

.inheader {
width:10%;
border-style:none;
background-color:transparent;
color:white;
font-family:Avenir Next;
font-size:25px;
}
#transfer {
margin-left:65%;
display:inline;}

#tableinfo {
    color: white;
    border-style: solid;
    border-width: 1px;
    border-color: white;
    border-top-right-radius: 6px;
    background-color: rgba(97,97,97,0.6);
 
    font-weight: normal;
    border-radius: 17px;
    padding-top: 0%;
    width: 20%;
    margin-right: auto;
    margin-left: auto;
    display: flex;
    justify-content: center;

}
#thetable {
	color:white;
	width: 100%;
	text-align: center;

}
th {
	border-bottom-style: solid;
	width: 100%;
	border-width: 1px;


}
tr {
    font-size: 35px;
    line-height: 70px;
}
.row1 {
  font-weight: normal;
  font-family: Avenir Next;
  border-bottom-style: solid;
  border-bottom-color: white;
  border-bottom-width: 1px;
}
h1 {
	color: white;
	font-family:Avenir Next;
	width: 30%;
	margin-left: auto;
	margin-right: auto;
}
#title {
	margin-top: 10%;
	width: 100%;
}

</style>

</head>
<body>
<div class="bg-image"></div>
<div class="bg-image-black"></div>


<div class="content" id="main">

	<div class="header">
		<a href="display.jsp">
			WeatherMeister
		</a>
		<div id="transfer">
	 		<form action="profile.jsp" id="loginForm" style="display:inline;">
				<input class="inheader" type="submit" value="Profile" name="Login" id="Login"></button>
			</form>
			<form action="signOut.jsp" id="registerForm" style="display:inline;">
				<input class="inheader" type="submit" value="Sign Out" name="Register" id="Register" ></button>
			</form>
		</div>
	</div>
	
<!-- 	<div id="tableinfo"  style="overflow:auto;height:500px;">
 -->
 	<div id="title">
 		<h1><%=username %>'s Search History</h1>
	</div>
	<div id="tableinfo" style="overflow:auto;height:500px;">
  		<table id="thetable">
    		<%for (int i = 0; i < data.size();i++){%>
    			<tr>
					<th><%=data.get(i)%> </th>
    			</tr>
    		<%} %>
  		</table>	
	</div>






	
</div>

	<script>
	


  </script>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>

</body>
</html>