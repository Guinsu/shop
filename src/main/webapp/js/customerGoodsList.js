
//DOMContentLoaded 이벤트는 html 문서가 실행 되었을 때 작동한다.
document.addEventListener('DOMContentLoaded', function() {
	document.getElementById("slide1").style.display = "block";
	document.getElementById("slide2").style.display = "none";
});

//dot을 눌렀을 때 작동 
function clickEvent(n){
	
	if(n == 1){
		document.getElementById("slide1").style.display = "block";
		document.getElementById("slide2").style.display = "none";
	}
	
	if(n == 2){
		document.getElementById("slide1").style.display = "none";
		document.getElementById("slide2").style.display = "block";
	}
	
}


