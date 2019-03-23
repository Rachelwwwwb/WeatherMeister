<%@ page import="weather.database" %>
<%
database _database = (database)session.getAttribute("my_database");
if(_database == null){
	_database = new database();
	session.setAttribute("my_database", _database);
}
String username = "";
String username1;
String username2;

username2 = (String)session.getAttribute("_username");
username1 = request.getParameter("username");

if (username1 != null){
	username = username1;
}
else if (username2 != null){
	username = username2;
}
session.setAttribute("_username", username);
System.out.println("username1: " + username);
%>
<!DOCTYPE html>
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
.row {
	padding: 0;
	margin:0;
	display: flex;
	justify-content:center;
	flex-direction: row;
	width: 100%;
}

.logo{
	margin-top: 100px;
	width: 35%;
}
.logo img{
	width: 100%;
}
#search-by-city{
	width: 40%;
}

input {
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
background-color: rgba(97,97,97,0.7);
}

label {
	color: white;
}

.form-check{
	margin-right: 15px;
	font-family:Avenir Next;
	
}
.form-check-input{
	margin-top:0;
}

.row .display{
	width: 15%;
	margin-top: 15px;
}
.row .display button{
	width: 100%;
}

#div1{
	display: block;
}
#div2{
	display: none;
}

#div2 .search-bar{
	margin-left: 10px;
	margin-right: 10px;
	width:40%;
}
#div2 input{
	margin-left:2%;
	margin-right:2%;
	width:45%;
}

.searchButton{
 width: 60px;
 height:60px;
 border-width: 0px;
 background-color:red;

 }
 #div1 form{
position:relative;
}
 #div1 .searchButton{
  position: absolute;
  top:0;
 right:0;
 margin-top:-6px;
 }

#div2 form{
position:relative;
}
 #div2 .searchButton{
  position: absolute;
 top:0;
 right:10px;
 margin-top:-3px;
 }

.button-img{
	width: 80%;
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
#mapicon {
height: 40px;}

#overlay {
display:none;
height:1000px;
width:100%;
position:absolute;
z-index:5;
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
#map{
height:80%;
width:60%;
top:100px;
left:20%;
position:absolute;
z-index:10;
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
</style>

</head>
<body>
<div class="bg-image"></div>
<div class="bg-image-black"></div>


<div class="content" id="main">
	<div id="overlay">
		<div id="black-background"></div>
		<div id="map"> </div>
	</div>

	<div class="header"><a href="display.jsp">
		WeatherMeister
	</a>
	<div id="transfer">
	 <form action="login.jsp" id="loginForm" style="display:inline;">
	<input class="inheader" type="submit" value="Login" name="Login" id="Login"></button>
	</form>
	<form action="register.jsp" id="registerForm" style="display:inline;">
	<input class="inheader" type="submit" value="Register" name="Register" id="Register" ></button>
	</form>
	</div>
	
	</div>
		
	<div class="row">
		<div class="logo">
			<img src="Assignment3Images/logo.png" />
		</div>
	</div>


<div id="div1" class="hide">
	<div class="row">
  		<div class="search-bar" id="search-by-city">
			<form method="post" action="allcity.jsp"  id="cityForm">
				<input type="text" name="city" placeholder="Los Angeles" id="cityinput">
				<button type="submit" class="searchButton" style="background-color: transparent; border-style: none; cursor: pointer;" >
		 		<img class="button-img"  src="Assignment3Images/magnifying_glass.jpeg" /></button> 
			</form>
		</div>
	</div>

</div>


	<div id="div2" class="hide">
 	<div class="row">
 		<div class="search-bar">
			<form method="post" action="allcity.jsp" id="lat-form">
			<input type="text" name="lat" placeholder="Latitude" id="latinput">
			<input type="text" name="long" placeholder="Longitude" id="loninput">
			<button type="submit"  class="searchButton" style="background-color: transparent; border-style: none; cursor: pointer;"><img class="button-img" src="Assignment3Images/magnifying_glass.jpeg" /></button> 
			</form>
		</div>
		<div>
		<img src="Assignment3Images/MapIcon.png" alt="mapicon" id="mapicon"/>
		</div>
	</div>
</div>
	
	<!-- the radio button part -->
	<div class="row">
		<div class="form-check">
  			<input class="form-check-input" type="radio" name="exampleRadios" value="city"  onclick="show1();" checked />
  			<label class="form-check-label" for="exampleRadios1">
				City
  		</label>
		</div>
		<div class="form-check">
  			<input class="form-check-input" type="radio" name="exampleRadios" value="location"
  			 onclick="show2();">
  			<label class="form-check-label" for="exampleRadios2">
   		 	Location(Lat./Long.)
  			</label>
		</div>
	</div>
</div>

	<script>
	
	
    function initMap(){
      var options = {
        zoom:4,
        center:{lat:34.052235,lng:-118.243683}
      }
      var map = new google.maps.Map(document.getElementById("map"),options);
      google.maps.event.addListener(map,'click',function(event){
  		placeMarker(map,event.latLng);
  	});
  	
    }
    function placeMarker(map, location) {
		  var marker = new google.maps.Marker({
		    position: location,
		    map: map
		  });
		  var infowindow = new google.maps.InfoWindow({
		    content: 'Latitude: ' + location.lat() +
		    '<br>Longitude: ' + location.lng()
		  });
		  infowindow.open(map,marker);
		  document.querySelector("#overlay").style.display = "none";
		  document.querySelector("#latinput").value = location.lat();
		  document.querySelector("#loninput").value = location.lng();


		}
  	</script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBkHhaq2BaoRBGY8p-bkHa0TiIY93lzkoc&callback=initMap"> </script>
    <script>
	document.querySelector("#mapicon").onclick = function(){
		document.querySelector("#overlay").style.display = "block";
	}

	
 function show1(){
  document.getElementById('div1').style.display ='block';
  document.getElementById('div2').style.display = 'none';
  document.getElementById('lat-form').reset();
}
   
function show2(){
  document.getElementById('div1').style.display = 'none';
  document.getElementById('div2').style.display ='block';
  document.getElementById('cityForm').reset();
}
<%
String error = (String)request.getAttribute("error");
if(error == null || error.trim().length() == 0){
	error = "";
}
else{
	
	%>
	alert("Invalid input!");
<%
}
%>


<%if (username != null && username.trim().length() != 0){%>
	//change the login and register to profile and sign out
	document.querySelector("#loginForm").action = "profile.jsp";
	document.querySelector("#Login").value = "Profile";
	document.querySelector("#registerForm").action = "signOut.jsp";
	document.querySelector("#Register").value = "Sign Out";
<%}%>

  </script>


<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>

</body>
</html>