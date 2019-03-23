<!DOCTYPE html>
<%@ page import="weather.database" %>

<%
//make sure there is only one database among the websites. There is no need to have more than one database
database _database = (database)session.getAttribute("my_database");
if(_database == null){
	_database = new database();
	session.setAttribute("my_database", _database);
	if (_database == null){
		System.out.println("here");
	}
}

//although the following code will always be "Anonymous" according to the instruction of this lab, this is safer
String username = (String)session.getAttribute("username");
if(username == null){
	//database.increment("login.jsp","Anony1mous");
}
else{
	//database.increment("login.jsp",username);
}

%>
<html>
<head>
	<title>Login Page</title>
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
}
.header h1 {
  display: inline;
    font-size: 45px;
  font-family: 'Savoye LET';
  padding-right: 65%;
}
.link {
  font-family:Avenir Next;
  margin-right: 5%;
  font-weight: normal;
}

.row {
	padding: 0;
	margin:0;
	display: flex;
	justify-content:center;
	flex-direction: row;
	width: 100%;
}

.textinput {
align-self:center;
width: 100%;
height: calc(2.5rem + 2px);
padding: .375rem .75rem;
font-size: 1rem;
font-weight: 400;
line-height: 1.5;
font-family:Avenir Next;
color: #ced4da;
background-color: #fff;
background-clip: padding-box;
border: 1px solid #ced4da;
transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
background-color: white;
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
#mainbody {
	display:flex;
	justify-content:center;
	width:100%;
	padding-top:10%;
}
#center {
width:40%;
/* display:flex;
justify-content:center; */
padding-top: 0%;
position: relative;
}
#keychain {
position: absolute;
top: -10%;
left:35%;
width:30%;
margin-left: auto;
margin-right: auto;
}
#keychain img{
width:100%;}

#inputdiv {
width:100%;
background-color: rgba(255,255,255,0.3);
padding-top: 10%;
padding-bottom: 10%;
padding-left: 10%;
padding-right: 10%;
border-radius: 30px;
}
#inputdiv p{
  font-family:Avenir Next;
  color: white;
  font-size: 30px;
}
#loginbutton {
    border-radius: 40px;
    width: 30%;
    background-color: rgb(235,128,0);
    margin-right: 35%;
    margin-left: 35%;
    margin-top: 30px;
    text-align: center;
    font-size: 30px;
    font-family:Avenir Next;
    color:white;

}

input {
width:10%;
border-style:none;
background-color:transparent;
color:white;
font-family:Avenir Next;
font-size:25px;

}

</style>

</head>
<body>

<div class="bg-image"></div>
<div class="bg-image-black"></div>

<div class="content">
	<div class="header">
    <a href="display.jsp">
		  <h1>WeatherMeister</h1>
	 </a>
	 <form action="login.jsp" style="display:inline;">
	<input type="submit" value="Login" name="Login" ></button>
	</form>
	<form action="register.jsp" style="display:inline;">
	<input type="submit" value="Register" name="Register" ></button>
	</form>
    <!-- <input type="submit" class="link" action="login.jsp">Login</h1>
    <input class="link" action="">Register</h1> -->

</div>

	<div id="mainbody">
		<div id="center">
			<div  id="keychain">
				<img  src="Assignment3Images/Keychain_Locked@2x.png" />
			</div>
			<div id="inputdiv">
				<form method="post" action="authenticate.jsp">
					<p>Username</p><input class="textinput" type="text" name="username"/>
          			<p>Password</p><input class="textinput" type="password" name="password"/>
          			<p id="errorMessage" style="display:none; color:red; font-size:30px;">Error:</p>
          <input id="loginbutton" type="submit" value="Login" />

				</form>
			</div>
		</div>
	</div>
	
	


</div>

  <script src="http://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>

  <script type="text/javascript" charset="utf-8">
  	<%
	String error = request.getParameter("error");
	if(error != null && error.equalsIgnoreCase("noUserName")){
	%>
	document.querySelector("#errorMessage").style.display = "block";
	document.querySelector("#errorMessage").innerHTML = "This user does not exist.";
	<%
	}
	
	if(error != null && error.equalsIgnoreCase("doesnotMatch")){
	%>
	document.querySelector("#errorMessage").style.display = "block";
	document.querySelector("#errorMessage").innerHTML = " Incorrect password.";
	<%
	}
	%>
  </script>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>

</body>
</html>