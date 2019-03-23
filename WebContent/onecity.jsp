<!DOCTYPE html>
<%@page import="weather.ReadFile"%>
<%@ page import ="java.util.ArrayList"%>

<html>
<head>
	<title></title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
<script>

</script>
<style>
	body, html {
  height: 100%;
}

@font-face {
font-family: 'Savoye LET';
src:url(Assignment3Images/Avenir Next/AvenirNext-Regular.ttf);
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
  position: absolute;
  top: 0;
  left: 0;
  z-index: 2;
  width: 100%;
}
/* Position text in the middle of the page/image */
.header {
  width: 100%;
  background-color: black; /* Fallback color */
  z-index: 20;  
  color: white;

}
.meister{
  font-size: 35px;
  font-family: 'Savoye LET';
  font-weight: bold;
  padding-left: 15px;
}
.row {
	padding: 0;
	margin:0;
	display: flex;
	justify-content:center;
	flex-direction: row;
	width: 100%;
}
.searchButton{
 width: 60px;
 height:60px;
 position: relative;
 background-color: rgba(255,255,255,0);

}

.button-img{
  width: 70%;
}
#div1{
 width: 40%;
 display: block;
 background-color: blue;
 font-family: Avenir Next;
 position:relative;
}
#div1 button{
position:absolute;
right:0;
top:0;
margin-top:-10px;
}
#search-by-city{
width:100%;
}
#div1 input{
width:100%;
}

#div2{
  display: none;
  font-family: Avenir Next;
  width: 60%;
  position:relative;
}
#div2 button{
position:absolute;
top:0;
right:170px;
margin-top:-10px;
}

#div2 .search-bar{
  width: 80%;
  margin-left: 2%;
  margin-right: 2%;
  padding: 0;
}
#div2 .search-bar input{
  width: 47%;
  margin-left:0%;
  margin-right:2%;
}

.form-check{
  margin-left: 0;
  padding-right: 100px;
  font-family: Avenir Next;

}
.form-check-input{
  margin-top:0;
}
h1{
  color: white;
  margin-top:30px;
  margin-left: 5%;
  margin-bottom: 30px;
  font-size: 60px;
  font-family: Avenir Next;
}
#container {
  font-family:Avenir Next;
  width: 80%;
  margin-left: 10%;
  margin-right: 10%;
  padding-top: 10px;
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
}
.icon {
  width: 12%;
  margin-left: 5%;
  margin-right: 5%;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.icon img{
  width: 100%;
}
.caption{
  color: white;
  text-align: center;
  font-size: 35px;
}

.detail {
  color: white;
  width:100%;
  text-align: center;
  display: none;
  
}
#loc {
  position: relative;
}
#loc .detail{
  position: absolute;
  top:20%;
}
#dayLow {
  position: relative;
}
#dayLow .detail{
  position: absolute;
  top:20%;
  font-size:20px;
}
#dayHigh {
  position: relative;
}
#dayHigh .detail{
  position: absolute;
  top:20%;
  font-size:20px;
}
#drop {
  position: relative;
}
#drop .detail{
  position: absolute;
  top:20%;
  font-size:20px;
}
#wind {
  position: relative;
}
#wind .detail{
  position: absolute;
  top:20%;
  font-size:20px;
}
#sun {
  position: relative;
}
#sun .detail{
  position: absolute;
  top:20%;
  font-size:20px;
}
#coor {
  position: relative;
}
#coor .detail{
  position: absolute;
  top:20%;
  font-size:20px;
}
#temp {
  position: relative;
}
#temp .detail{
  position: absolute;
  top:20%;
  font-size:20px;
}
.navbar-light .navbar-brand{
color:white;
}
:hover {
color:white;
}
h1,h3 {
font-family:Avenir Next;
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
</style>

</head>
<body>
<div class="bg-image"></div>
<div class="bg-image-black"></div>

<!-- the header part -->
<div class="content">
	<div id="overlay">
		<div id="black-background"></div>
		<div id="map"> </div>
	</div>
  <!-- the navbar -->
    <nav class="navbar navbar-light header">
        <a class="navbar-brand meister" href="display.jsp">WeatherMeister</a>
      <!-- the search bar -->
     <div id="div1" class="hide">
      <div class="row">
        <div class="search-bar" id="search-by-city">
          <form method="post" action="allcity.jsp">
            <input type="text" name="city" placeholder="Los Angeles,CA">
            <button type="submit" class="searchButton" style="background-color: transparent; border-style: none; cursor: pointer;"><img class="button-img" src="Assignment3Images/magnifying_glass.jpeg" /></button> 
          </form>
        </div>
   </div>
   </div>


  <div id="div2" class="hide">
  <div class="row">
    <div class="search-bar">
      <form method="post" action="allcity.jsp">
      <input type="text" name="lat" placeholder="Latitude" id="latinput">
      <input type="text" name="long" placeholder="Longitude" id="loninput">
      <button type="submit" class="searchButton" style="background-color: transparent; border-style: none; cursor: pointer;"><img class="button-img" src="Assignment3Images/magnifying_glass.jpeg" /></button> 
      </form>
    </div>
	 <div style="display:inline;">
		<img src="Assignment3Images/MapIcon.png" alt="mapicon" id="mapicon"/>
	</div>

  </div>
</div>

    <!-- the radio button part -->
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

<!--     </form>
 -->
  </nav>

<!-- above is the header -->
  <%        		
 
  String oneCityName = request.getParameter("city");
  String oneCityCountry = request.getParameter("country");
  double oneCityDayHigh = Double.parseDouble(request.getParameter("tmphigh"));
  double oneCityDayLow = Double.parseDouble(request.getParameter("tmphigh"));
  Float oneCityWindSpeed = Float.parseFloat(request.getParameter("wind"));
  int oneCityHumidity = Integer.parseInt(request.getParameter("humidity"));  
  double oneCityLong = Double.parseDouble(request.getParameter("lon"));
  double oneCityLat = Double.parseDouble(request.getParameter("lat"));;
  double oneCityTemp = Double.parseDouble(request.getParameter("temp"));
  String oneCitySunrise = request.getParameter("sunrise");
  String oneCitySunset = request.getParameter("sunset");
  
  oneCityDayHigh = (oneCityDayHigh- 273.15)* 1.8000 + 32.00;
  oneCityDayHigh = Math.round(oneCityDayHigh * 100) / 100;
  oneCityDayLow = (oneCityDayLow- 273.15)* 1.8000 + 32.00;
  oneCityDayLow = Math.round(oneCityDayLow * 100) / 100;
  oneCityTemp = (oneCityTemp- 273.15)* 1.8000 + 32.00;
  oneCityTemp = Math.round(oneCityTemp * 100) / 100;
  /* capitalize the city name */
  //oneCityName = oneCityName.substring(0, 1).toUpperCase() + oneCityName.substring(1);    

  %>

  <!-- should change to a variable later -->
  <h1><%= oneCityName%></h1>
  <div id="container">
  
    <!-- each icon consists of an icon and a title -->
    <div class="icon" id="loc">
      <img style="visibility:visible;" src="Assignment3Images/planet-earth.png" />
      <div class="detail" style="display:none;"> 
      <h3><%= oneCityName%></h3>
      <h3> <%= oneCityCountry%> </h3>
      </div>
      <label class="caption"> Location </label>
    </div>
 

    <div class="icon" id="dayLow">
      <img style="visibility:visible;" src="Assignment3Images/snowflake.png" />
      <div class="detail" style="display:none;"> 
      <h3><%= oneCityDayLow%>  degrees Fahrenheit </h3> 
      </div>
      <label class="caption"> Temp Low </label>
    </div>

    <div class="icon" id="dayHigh">
      <img style="visibility:visible;" src="Assignment3Images/sun.png" />
      <div class="detail" style="display:none;"> 
      <h3><%= oneCityDayHigh%>  degrees Fahrenheit </h3> 
      </div>
      <label class="caption"> Temp High </label>
    </div>

    <div class="icon" id="wind">
      <img style="visibility:visible;" src="Assignment3Images/wind.png" />
      <div class="detail" style="display:none;"> 
      <h3><%= oneCityWindSpeed%> miles/hour </h3> 
      </div>
      <label class="caption"> Wind </label>
    </div>

  </div>
	
	<!-- the second row -->
	  <div id="container">
    <!-- each icon consists of an icon and a title -->
    <div class="icon" id="drop">
      <img style="visibility:visible;" src="Assignment3Images/drop.png" />
      <div class="detail" style="display:none;"> 
      <h3><%= oneCityHumidity%>% </h3> 
      </div>
      <label class="caption"> Humidity </label>
    </div>
 

    <div class="icon" id="coor">
      <img style="visibility:visible;" src="Assignment3Images/LocationIcon.png" />
      <div class="detail" style="display:none;"> 
      <h3><%= oneCityLong%>, <%= oneCityLat%> </h3> 
      </div>
      <label class="caption"> Coordinates </label>
    </div>

    <div class="icon" id="temp">
      <img style="visibility:visible;" src="Assignment3Images/thermometer.png" />
       <div class="detail" style="display:none;"> 
      <h3><%= oneCityTemp%> degrees Fahrenheit</h3> 
      </div>
      <label class="caption"> Current Temp </label>
    </div>

    <div class="icon" id="sun">
      <img style="visibility:visible;" src="Assignment3Images/sunrise-icon.png" />
      <div class="detail" style="display:none;"> 
      <h3><%= oneCitySunrise%> </h3> 
      <h3><%= oneCitySunset%> </h3> 
      </div>
      <label class="caption"> Sunrise/set </label>
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
   
  <script type="text/javascript" charset="utf-8">
  document.querySelector("#mapicon").onclick = function(){
  document.querySelector("#overlay").style.display = "block";
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
  function show1(){
  document.getElementById('div1').style.display ='block';
  document.getElementById('div2').style.display = 'none';

}
function show2(){
  document.getElementById('div1').style.display = 'none';
  document.getElementById('div2').style.display ='block';
}
/* the flipping effect */
let icons = document.querySelectorAll(".icon");
let details = document.querySelectorAll(".detail");
let images = document.querySelectorAll(".icon img");


for (let i = 0; i < icons.length; i++){
	icons[i].onclick = function(){
		if(details[i].style.display == "none"){
			details[i].style.display = "block";
			images[i].style.visibility = "hidden";
		}
		else{
			details[i].style.display = "none";
			images[i].style.visibility = "visible";
		}
	}
}

  </script>
	
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>

</body>
</html>