<!DOCTYPE html>
<%@page import="weather.database"%>
<%@ page import ="java.util.ArrayList"%>

<%
database _database = (database)session.getAttribute("my_database");
if(_database == null){
	_database = new database();
	session.setAttribute("my_database", _database);
}
String username = (String)session.getAttribute("_username");
System.out.println("username: " + username);
%>
<html>
<head>
	<title></title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css" integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS" crossorigin="anonymous">
 <%
 boolean display = true;
 String city = request.getParameter("city");
 String lat = request.getParameter("lat");
 String lon = request.getParameter("long");

	if(city != null && city.trim().length() != 0) {
		if (username != null){
			_database.increment(city.trim(), username.trim());
		}
	}

	else if(lat != null && lat.trim().length() != 0 && lon != null && lon.trim().length() != 0) {
		double latD = Double.parseDouble(lat);
		double lonD = Double.parseDouble(lon);

		latD =  Math.round(latD*100)/100;
		lonD =  Math.round(lonD*100)/100;

		lat = Double.toString(latD);
		lon = Double.toString(lonD);
		
		String searchTerm = "("+lat.trim()+","+lon.trim()+")";
		System.out.print("username: "+username);
		System.out.print("searchTerm: "+searchTerm);

		_database.increment(searchTerm, username.trim());
	}
	else{
		display = false;
	}
 
  %>
  <script type="text/javascript" src="city.list.json"></script>
  <script>
  let idArray = [];
  
  //used for sorting
  let cityNameCollect = [];
  let DayHighCollect = [];
  let DayLowCollect = [];
  
  let endpoint = "";
  let oneCityName = "";
  let oneCityLat = "";
  let oneCityLon = "";
  let oneCountryCode = "";
  let oneCityDayHigh = 0;
  let oneCityDayLow = 0;
  
  <%
  if(city != null && city.trim()!=null){
	%>  oneCityName = "<%=city.trim()%>";
 <% }
  else if(lat != null && lat.trim().length() != 0 && lon != null && lon.trim().length() != 0){
  %>
  		oneCityLat = "<%=lat.trim()%>";
  		oneCityLon = "<%=lon.trim()%>";
  		endpoint = "https://api.openweathermap.org/data/2.5/weather?lat="+oneCityLat+"&lon="+oneCityLon+"&appid=638481b3287db2ea6a8390b8a109de12";
  <%}
  else{
  	display = false;
  }
  %>
  
  function loadJSON(callback) {
	  var xobj = new XMLHttpRequest();
	  xobj.overrideMimeType("application/json");
	  xobj.open('GET', 'city.list.json', true);
	  xobj.onreadystatechange = function () {
		  if (xobj.readyState == 4 && xobj.status == "200") {
			  callback(xobj.responseText);
		  }
		  }
		  xobj.send(null);
		  }


  function ajax(endpoint){
	  	console.log("endpoint here: ");
	  	console.log(endpoint);
		let responseObjects = null;
		let xhr = new XMLHttpRequest();
		xhr.open("GET",endpoint);
		xhr.send();
		xhr.onreadystatechange = function(){
			if(this.readyState == this.DONE){
				if(xhr.status == 200){
					responseObjects = JSON.parse(xhr.responseText);
					console.log(responseObjects);
					addRows(responseObjects);	
				}
				else{
					document.querySelector("#displayError").style.display = "block";
				}
			}
		}  
	  }
 
	var dataSet = [];
  function addRows(results){
	 let count = 1;
	//if there's only one city, not to display the sorting div
	if (idArray.length <= 1 || idArray == null){
	document.querySelector("#selection").style.display = "none";
	document.querySelector("#allcities").style.visibility = "hidden";
	}

	if(idArray.length > 0){
	count = results.cnt;
	}
	else{
		oneCityName = results.name;
		oneCityDayHigh = (parseFloat(results.main.temp_max,10) - 273.15)* 1.8000 + 32.00;
		oneCityDayHigh = Math.round(oneCityDayHigh * 100) / 100;
		oneCityDayLow = (parseFloat(results.main.temp_min,10) - 273.15)* 1.8000 + 32.00;
		oneCityDayLow = Math.round(oneCityDayLow * 100) / 100;
		oneCountryCode = results.sys.country;
		
		//store all the data into a variable, and send to detail page later
		let arr = [];
		arr.push(oneCityName);
		arr.push(oneCountryCode);
		arr.push(results.main.temp_min);
		arr.push(results.main.temp_max);
		arr.push(results.wind.speed);
		arr.push(results.main.humidity);
		arr.push(results.coord.lat);
		arr.push(results.coord.lon);
		arr.push(results.main.temp);
		arr.push(results.sys.sunrise);
		arr.push(results.sys.sunset);
		dataSet.push(arr); 
	}
	
	for (let i = 0; i < count; i++){
		if (idArray.length > 0){
			oneCityName = results.list[i].name;
			oneCityDayHigh = (parseFloat(results.list[i].main.temp_max,10)- 273.15)* 1.8000 + 32.00;
			oneCityDayLow = (parseFloat(results.list[i].main.temp_min,10)- 273.15)* 1.8000 + 32.00;
			oneCityDayLow = Math.round(oneCityDayLow * 100) / 100;
			oneCityDayHigh = Math.round(oneCityDayHigh * 100) / 100;
			oneCountryCode =  results.list[i].sys.country;
			
			let arr = [];
			arr.push(oneCityName);
			arr.push(oneCountryCode);
			arr.push(results.list[i].main.temp_min);
			arr.push(results.list[i].main.temp_max);
			arr.push(results.list[i].wind.speed);
			arr.push(results.list[i].main.humidity);
			arr.push(results.list[i].coord.lat);
			arr.push(results.list[i].coord.lon);
			arr.push(results.list[i].main.temp);
			arr.push(results.list[i].sys.sunrise);
			arr.push(results.list[i].sys.sunset);
			dataSet.push(arr); 
		}
		
	cityNameCollect.push( oneCityName+", "+oneCountryCode);
	DayHighCollect.push(oneCityDayHigh);
	DayLowCollect.push(oneCityDayLow);
	let trElement = document.createElement("tr");
	trElement.classList.add("row2");
	document.querySelector("tbody").appendChild(trElement);
	
	let nameElement = document.createElement("td");
	nameElement.innerHTML = oneCityName+", "+oneCountryCode;
	nameElement.id = "name_"+i;	
	
	let highElement = document.createElement("td");
	highElement.innerHTML = oneCityDayHigh;
	highElement.id = "high_"+i;
	let lowElement = document.createElement("td");
	lowElement.innerHTML = oneCityDayLow;
	lowElement.id = "low_"+i;
	nameElement.classList.add("changeLink");
	nameElement.onclick = function(){
		let index = -1;
		for (let j = 0; j < dataSet.length; j++){
			//if ()
		}
		
		
		
		
		var form = document.getElementById('myform');
		let myarr = dataSet[i];
		console.log(myarr[0]);

		form.action="onecity.jsp?city="+myarr[0]+"&country="+myarr[1]+"&tmplow="+myarr[2]+"&tmphigh="+myarr[3]+"&wind="+myarr[4]+"&humidity="+myarr[5]+"&lat="+myarr[6]+"&lon="+myarr[7]+"&temp="+myarr[8]+"&sunrise="+myarr[9]+"&sunset="+myarr[10];
		console.log("onecity.jsp?city="+myarr[0]+"&country="+myarr[1]+"&tmplow="+myarr[2]+"&tmphigh="+myarr[3]+"&wind="+myarr[4]+"&humidity="+myarr[5]+"&lat="+myarr[6]+"&lon="+myarr[7]+"&temp="+myarr[8]+"&sunrise="+myarr[9]+"&sunset="+myarr[10]);
		form.method = "post";
		form.submit();

	}

	
	trElement.appendChild(nameElement);
	trElement.appendChild(lowElement);
	trElement.appendChild(highElement);
	}
	
  }
 
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
  z-index: 20;
  width: 100%;
}
/* Position text in the middle of the page/image */
.header {
  width: 100%;
  background-color: black; /* Fallback color */
  z-index: 2;  
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
 border-width: 0px;
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
  padding: 0;
}
#div2 .search-bar input{
  width: 45%;
  margin-left:2%;
  margin-right:2%;
}

.form-check{
  margin-left: 0;
  padding-left: 5px;
  font-family: Avenir Next;

}
.form-check-input{
  margin-top:0;
}
h1{
  color: white;
  margin-top:50px;
  margin-left: 5%;
  margin-bottom: 30px;
  font-size: 60px;
  font-family: Avenir Next;
}

#main-content {
  font-family:Avenir Next;
  width: 100%;
  display: flex;

}
#tableinfo {
    width: 60%;
    color: white;
    border-style: solid;
    border-width: 1px;
    border-color: white;
    border-top-right-radius: 6px;
    background-color: rgba(97,97,97,0.6);
 
    margin-left: 5%;
    margin-right: 5%;
    text-align: center;
    font-weight: normal;
    border-radius: 17px;
}
#thetable {
	
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

.row2 {
  font-weight: normal;
  font-family:Avenir Next;
  border-bottom-style: solid;
  border-bottom-color: white;
  border-bottom-width: 1px;
}
#cities-info{
  font-weight: normal;
  font-family:Avenir Next;
  border-top-style: solid;
  border-top-color: white;
  border-top-width: 1px;
}

h2 {
  color: white;
  font-size: 50px;
}
#selection {
  width: 20%;
  text-align: center;
  position: relative;
}

select {
  width: 100%;
  font-size: 35px;
}
.navbar-light .navbar-brand{
color:white;
}
#allcities {
display:block;
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
  <!-- the navbar -->
  	<div id="overlay">
		<div id="black-background"></div>
		<div id="map"> </div>
	</div>
    <nav class="navbar navbar-light header">
        <a class="navbar-brand meister" href="display.jsp" >WeatherMeister</a>
      <!-- the search bar -->
     <div id="div1" class="hide">
      <div class="row">
        <div class="search-bar" id="search-by-city">
          <form method="post" action="allcity.jsp" id="cityForm">
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
  </nav>
	

<!-- above is the header -->
<!-- before is the form -->

<h1 id="allcities">All Cities</h1>
  

  
  <%if(display){ %>
<div id="main-content">
<div id="tableinfo"  style="overflow:auto;height:500px;">
  <table id="thetable" style="width:100%;">
    <tr class="row1">
      <th>City Name</th>
      <th>Temp. Low</th>
      <th>Temp. High</th>
    </tr>
  </table>
   <script>
   
  
   if (oneCityName.length > 0){
   loadJSON(function(response) {
		  // Do Something with the response e.g.
	jsonresponse = JSON.parse(response);
	let idString = "";
	for (let i = 0; i < jsonresponse.length;i++){
		if(jsonresponse[i].name.toLowerCase() == oneCityName.toLowerCase()){
			if(idArray.length != 0){
			idString += ",";
			}
			idString += jsonresponse[i].id;
			idArray.push(jsonresponse[i].id);
		}
	}
	endpoint = "http://api.openweathermap.org/data/2.5/group?id="+idString+"&appid=638481b3287db2ea6a8390b8a109de12";
	ajax(endpoint);
	});
   }
   else{
	ajax(endpoint);
   } 
   
   </script>
  <%} %>
  

  <div style="width:100%;">
  <h1 id="displayError" style="text-align:center;display:none; ">error: incorrect input</h1>
  </div>
  
  <div style="width:100%;">
  <h1 id="noInputError" style="text-align:center;display:none; ">error: empty input</h1>
  </div>
  
  
  
</div>;
<!-- the select bar -->
  <div id="selection">
    <h2>Sort by:</h2>
    <select name="sorting" id="sorting-bar">
      <option selected="true" value="" disabled="disabled">Choose order</option>
      <option value="name">City Name A-Z</option>
      <option value="name-rev">City Name Z-A</option>
      <option value="low-asc">Temp. Low ASC</option>
      <option value="low-desc">Temp. Low DESC</option>
      <option value="high-asc">Temp. High ASC</option>
      <option value="high-desc">Temp. High DESC</option>
  </select> <br />
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
  
<%if(!display){%>
	document.querySelector("#allcities").style.display = "none";
	document.querySelector("#selection").style.display = "none";
	document.querySelector("#noInputError").style.display = "block";


<%}%>

   function show1(){
  document.getElementById('div1').style.display ='block';
  document.getElementById('div2').style.display = 'none';
}
   
function show2(){
  document.getElementById('div1').style.display = 'none';
  document.getElementById('div2').style.display ='block';
}

document.getElementById("cityForm").onsubmit = function(){
	request.setAttribute("nextPage", "/allcity.jsp");
}

document.getElementById('sorting-bar').onchange = function(){
	
	console.log(this.value);
	let item1 = "";
	let item2 = "";
	/* return -1 if item1 < item2 */
	/* return 0 if item1 = item 2*/
	/* return 1 if item 1 > item2 */
	/* this is javascript */
	if (this.value == "name"){
		for (let i = 0; i < cityNameCollect.length-1;i++){
		let smallest = i; 
		for(let j = i+1; j < cityNameCollect.length;j++){
				if(cityNameCollect[j] < cityNameCollect[smallest]){
					smallest =  j;
				}
		}
		
		let name_tmp = cityNameCollect[smallest];
		cityNameCollect[smallest] = cityNameCollect[i];
		cityNameCollect[i] = name_tmp;
		
		let low_tmp = DayLowCollect[smallest];
		DayLowCollect[smallest] = DayLowCollect[i];
		DayLowCollect[i] = low_tmp;
		
		let high_tmp = DayHighCollect[smallest];
		DayHighCollect[smallest] = DayHighCollect[i];
		DayHighCollect[i] = high_tmp;
	
		}
		//use javascript to switch the innerHTML
		for (let index = 0; index < cityNameCollect.length;index++){
			let name_id = "name_"+index;
			let low_id = "low_"+index;
			let high_id = "high_"+index;
			document.getElementById(name_id).innerHTML = cityNameCollect[index];
			document.getElementById(low_id).innerHTML = DayLowCollect[index];
			document.getElementById(high_id).innerHTML = DayHighCollect[index];
		}
	}
	else if (this.value == "name-rev"){

		for (let i = 0; i < cityNameCollect.length-1;i++){
		let largest = i; 
		for(let j = i+1; j < cityNameCollect.length;j++){
				if(cityNameCollect[j] > cityNameCollect[largest] > 0){
					largest =  j;
				}
		}
		
		let name_tmp = cityNameCollect[largest];
		cityNameCollect[largest] = cityNameCollect[i];
		cityNameCollect[i] = name_tmp;
		
		let low_tmp = DayLowCollect[largest];
		DayLowCollect[largest] = DayLowCollect[i];
		DayLowCollect[i] = low_tmp;
		
		let high_tmp = DayHighCollect[largest];
		DayHighCollect[largest] = DayHighCollect[i];
		DayHighCollect[i] = high_tmp;
	
		}
		//use javascript to switch the innerHTML
		for (let index = 0; index < cityNameCollect.length;index++){
			let name_id = "name_"+index;
			let low_id = "low_"+index;
			let high_id = "high_"+index;
		
			document.getElementById(name_id).innerHTML = cityNameCollect[index];
			document.getElementById(low_id).innerHTML = DayLowCollect[index];
			document.getElementById(high_id).innerHTML = DayHighCollect[index];
		}
	}
	else if (this.value == "low-asc"){
		for (let i = 0; i < DayLowCollect.length-1;i++){
		let smallest = i; 
		for(let j = i+1; j < DayLowCollect.length;j++){
				if(DayLowCollect[j] < DayLowCollect[smallest]){
					smallest =  j;
				}
		}
		
		let name_tmp = cityNameCollect[smallest];
		cityNameCollect[smallest] = cityNameCollect[i];
		cityNameCollect[i] = name_tmp;
		
		let low_tmp = DayLowCollect[smallest];
		DayLowCollect[smallest] = DayLowCollect[i];
		DayLowCollect[i] = low_tmp;
		
		let high_tmp = DayHighCollect[smallest];
		DayHighCollect[smallest] = DayHighCollect[i];
		DayHighCollect[i] = high_tmp;
		}
		//use javascript to switch the innerHTML
		for (let index = 0; index < cityNameCollect.length;index++){
			let name_id = "name_"+index;
			let low_id = "low_"+index;
			let high_id = "high_"+index;
			document.getElementById(name_id).innerHTML = cityNameCollect[index];
			document.getElementById(low_id).innerHTML = DayLowCollect[index];
			document.getElementById(high_id).innerHTML = DayHighCollect[index];
		}
	}

	else if (this.value == "low-desc"){
		for (let i = 0; i < DayLowCollect.length-1;i++){
		let largest = i; 
		for(let j = i+1; j < DayLowCollect.length;j++){
				if(DayLowCollect[j]>DayLowCollect[largest]){
					largest =  j;
				}
		}
		
		let name_tmp = cityNameCollect[largest];
		cityNameCollect[largest] = cityNameCollect[i];
		cityNameCollect[i] = name_tmp;
		
		let low_tmp = DayLowCollect[largest];
		DayLowCollect[largest] = DayLowCollect[i];
		DayLowCollect[i] = low_tmp;
		
		let high_tmp = DayHighCollect[largest];
		DayHighCollect[largest] = DayHighCollect[i];
		DayHighCollect[i] = high_tmp;
	
		}
		//use javascript to switch the innerHTML
		for (let index = 0; index < cityNameCollect.length;index++){
			let name_id = "name_"+index;
			let low_id = "low_"+index;
			let high_id = "high_"+index;
			document.getElementById(name_id).innerHTML = cityNameCollect.get(index);
			document.getElementById(low_id ).innerHTML = DayLowCollect.get(index);
			document.getElementById(high_id).innerHTML = DayHighCollect.get(index);
		}
	}
	

	else if (this.value == "high-asc"){
		for (let i = 0; i < DayHighCollect.length-1;i++){
		let smallest = i; 
		for(let j = i+1; j < DayHighCollect.length;j++){
				if(DayHighCollect[j] < DayHighCollect[smallest]){
					smallest =  j;
				}
		}
		
		let name_tmp = cityNameCollect[smallest];
		cityNameCollect[smallest] = cityNameCollect[i];
		cityNameCollect[i] = name_tmp;
		
		let low_tmp = DayLowCollect[smallest];
		DayLowCollect[smallest] = DayLowCollect[i];
		DayLowCollect[i] = low_tmp;
		
		let high_tmp = DayHighCollect[smallest];
		DayHighCollect[smallest] = DayHighCollect[i];
		DayHighCollect[i] = high_tmp;
		}
		//use javascript to switch the innerHTML
		for (let index = 0; index < cityNameCollect.length;index++){
			let name_id = "name_"+index;
			let low_id = "low_"+index;
			let high_id = "high_"+index;
			
			document.getElementById(name_id).innerHTML = cityNameCollect[index];
			document.getElementById(low_id).innerHTML = DayLowCollect[index];
			document.getElementById(high_id).innerHTML = DayHighCollect[index];
		}
	}

	else if (this.value == "high-desc"){
		for (let i = 0; i < DayHighCollect.length-1;i++){
		let largest = i; 
		for(let j = i+1; j < DayHighCollect.length;j++){
				if(DayHighCollect[j] > DayHighCollect[largest]){
					largest =  j;
				}
		}
		
		let name_tmp = cityNameCollect[largest];
		cityNameCollect[largest] = cityNameCollect[i];
		cityNameCollect[i] = name_tmp;
		
		let low_tmp = DayLowCollect[largest];
		DayLowCollect[largest] = DayLowCollect[i];
		DayLowCollect[i] = low_tmp;
		
		let high_tmp = DayHighCollect[largest];
		DayHighCollect[largest] = DayHighCollect[i];
		DayHighCollect[i] = high_tmp;
	
		}
		//use javascript to switch the innerHTML
		for (let index = 0; index < cityNameCollect.length;index++){
			let name_id = "name_"+index;
			let low_id = "low_"+index;
			let high_id = "high_"+index;
			document.getElementById(name_id).innerHTML = cityNameCollect[index];
			document.getElementById(low_id).innerHTML = DayLowCollect[index];
			document.getElementById(high_id).innerHTML = DayHighCollect[index];
		}
	}	
	
}



  </script>
	
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>

<form id = "myform"></form>

</body>
</html>