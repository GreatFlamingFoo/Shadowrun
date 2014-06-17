///////////////////////////////// Page Setup //////////////////////////////////
$( document ).ready(function(){
	$(".init").dblclick(function(){
		$(this).val( parseInt($(this).val()) - 10 );
	});
});


///////////////////////////// Condition Monitors //////////////////////////////

function setDmg() {
	var dmg;
	var elems;
	if($(this).hasClass("pBox")) {
		dmg = $("#PhysicalDmg");
		elems = $(".pBox");
	} else if($(this).hasClass("sBox")) {
		dmg = $("#StunDmg");
		elems = $(".sBox");
	}
	
	var value = parseInt(dmg.val());
	if(!isNaN(value) && value>0) {
		removeClearHandler(elems[value - 1]);
	}
	
	dmg.val(this.value);
	addClearHandler(this);
	displayDmg();
}

///////////////////////////////// Dice Roller /////////////////////////////////
$( document ).ready(function(){
	$(".dice").click(loadDice);
});

function roll() {
	var dice = parseInt($("#dice").val());
	var results = $("#results");
	var imgs = $("#dice_img");
	
	if(isNaN(dice)) { dice = 0; }
	results.empty();
	
	for(var i=0; i<dice; i++) {
		var num = Math.floor(Math.random() * imgs.children().length);
		results.append(imgs.children()[num].cloneNode());
	}
}

function edgeBefore() {
	
}

function edgeAfter() {
	var results = $("#results");
	var imgs = $("#dice_img");
	var dice = results.children().length;
	$("#results > .failure").remove();
	dice = dice - results.children().length;
	
	results.append("&nbsp;&nbsp;");
	
	for(var i=0; i<dice; i++) {
		var num = Math.floor(Math.random() * imgs.children().length);
		results.append(imgs.children()[num].cloneNode());
	}
}

function loadDice() {
	var num = parseInt($(this).text());
	if(isNaN(num)) { num = ""; }
	$("#dice").val(num);
}

function addDice(num) {
	num = parseInt(num);
	if(isNaN(num)) { return; }
	if(!isNaN(parseInt($("#dice").val()))) {
		$("#dice").val(parseInt($("#dice").val()) + num);
	}
}

///////////////////////////////// LEGACY CODE /////////////////////////////////

// function setDmg() {
// 	var dmg;
// 	var elems;
// 	if(this.classList.contains("pBox")) {
// 		dmg = document.getElementById("PhysicalDmg");
// 		elems = document.getElementsByClassName("pBox");
// 	} else if(this.classList.contains("sBox")){
// 		dmg = document.getElementById("StunDmg");
// 		elems = document.getElementsByClassName("sBox");
// 	}
// 	
// 	var value = parseInt(dmg.value);
// 	if(!isNaN(value) && value>0) {
// 		removeClearHandler(elems[dmg.value-1]);
// 	}
// 	
// 	dmg.value = this.value;
// 	
// 	addClearHandler(this);
// 	displayDmg();
// }

function removeClearHandler(elem) {
	elem.onmouseover = null;
	elem.onmouseout  = null;
}

function addClearHandler(elem) {
	var timer;
	elem.onmouseover = function() {
		timer = setTimeout(function() {
			elem.innerHTML = "X";
			elem.onclick = function () {
				
				var dmg;
				if(this.classList.contains("pBox")) {
					dmg = document.getElementById("PhysicalDmg")
				} else if(this.classList.contains("sBox")){
					dmg = document.getElementById("StunDmg")
				} 
				dmg.value = 0;
				
				displayDmg();
				elem.innerHTML = "";
				elem.onclick = setDmg;
				removeClearHandler(this);
			}
		}, 300);
	}
	
	elem.onmouseout = function() {
		clearTimeout(timer);
		elem.innerHTML = "";
		elem.onclick = setDmg;
	}
}

function displayDmg() {
	var elems = document.getElementsByClassName("pBox");
	var num = parseInt(document.getElementById("PhysicalDmg").value);
	if(isNaN(num)) { num = 0; }
	
	for(i=0; i<elems.length; i++) {
		if(i<num) {
			if(!elems[i].classList.contains("pFilled")) {
				elems[i].classList.add("pFilled");
			}
			
			if((i+1) == num) {
				addClearHandler(elems[i]);
			}
		} else {
			elems[i].classList.remove("pFilled");
		}
	}
	
	elems = document.getElementsByClassName("sBox");
	var num = parseInt(document.getElementById("StunDmg").value);
	if(isNaN(num)) { num = 0; }
	
	for(i=0; i<elems.length; i++) {
		if(i<num) {
			if(!elems[i].classList.contains("sFilled")) {
				elems[i].classList.add("sFilled");
			}
			
			if((i+1) == num) {
				addClearHandler(elems[i]);
			}
		} else {
			elems[i].classList.remove("sFilled");
		}
	}
}

function setup() {
	var elems; // = document.getElementsByClassName("dice");
	var i;
	// for(i=0; i<elems.length; i++) {
	// 	elems[i].onclick = loadDice;
	// }
	
	elems = document.getElementsByClassName("pBox");
	var num = parseInt(document.getElementById("PhysicalBoxes").value);
	if(isNaN(num)) { num = elems.length; }
	
	for(i=0; i<elems.length; i++) {
		if(i<num) {
			elems[i].value = i+1;
			elems[i].onclick = setDmg;
		} else {
			elems[i].classList.add("unused");
		}
	}
	
	elems = document.getElementsByClassName("sBox");
	var num = parseInt(document.getElementById("StunBoxes").value);
	if(isNaN(num)) { num = elems.length; }
	
	for(i=0; i<elems.length; i++) {
		if(i<num) {
			elems[i].value = i+1;
			elems[i].onclick = setDmg;
		} else {
			elems[i].classList.add("unused");
		}
	}
	
	// elems = document.getElementsByName("init");
	// for(i=0; i<elems.length; i++) {
	// 	elems[i].ondblclick = decInit;
	// }
}