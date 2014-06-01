function roll() {
	var dice = parseInt(document.getElementById("dice").value);
	var results = document.getElementById("results");
	var imgs = document.getElementById("dice_img");
	
	while(results.firstChild) {
		results.removeChild(results.firstChild);
	}
	
	if(isNaN(dice)) {
		dice = 0;
	}
	
	for(var i=0; i<dice; i++) {
		var num = Math.floor(Math.random() * imgs.children.length);
		results.appendChild(imgs.children[num].cloneNode());
	}
}

function reroll() {
	var dice = 0;
	var results = document.getElementById("results");
	var imgs = document.getElementById("dice_img");
	var i;
	
	for(i=results.children.length-1; i>=0; i--) {
		if(results.children[i].classList.contains("failure")) {
			results.removeChild(results.children[i]);
			dice++;
		}
	}
	
	for(var i=0; i<dice; i++) {
		var num = Math.floor(Math.random() * imgs.children.length);
		results.appendChild(imgs.children[num].cloneNode());
	}
}

function loadDice() {
	var dice = document.getElementById("dice");
	var num = parseInt(this.innerHTML);
	if(isNaN(num)) { num = "" }
	dice.value = num;
}

function addDice(num) {
	var num = parseInt(num);
	var dice = document.getElementById("dice");
	if(isNaN(num)) { num = 0 }
	if(!isNaN(parseInt(dice.value))) {
		dice.value = parseInt(dice.value) + num ;
	}
}

function setDmg() {
	var dmg;
	var elems;
	if(this.classList.contains("pBox")) {
		dmg = document.getElementById("physicalDmg");
		elems = document.getElementsByClassName("pBox");
	} else if(this.classList.contains("sBox")){
		dmg = document.getElementById("stunDmg");
		elems = document.getElementsByClassName("sBox");
	}
	
	var value = parseInt(dmg.value);
	if(!isNaN(value) && value>0) {
		removeClearHandler(elems[dmg.value-1]);
	}
	
	dmg.value = this.value;
	
	addClearHandler(this);
	displayDmg();
}

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
					dmg = document.getElementById("physicalDmg")
				} else if(this.classList.contains("sBox")){
					dmg = document.getElementById("stunDmg")
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
	var num = parseInt(document.getElementById("physicalDmg").value);
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
	var num = parseInt(document.getElementById("stunDmg").value);
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
	var elems = document.getElementsByClassName("dice");
	var i;
	for(i=0; i<elems.length; i++) {
		elems[i].onclick = loadDice;
	}
	
	elems = document.getElementsByClassName("pBox");
	var num = parseInt(document.getElementById("physicalBoxes").value);
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
	var num = parseInt(document.getElementById("stunBoxes").value);
	if(isNaN(num)) { num = elems.length; }
	
	for(i=0; i<elems.length; i++) {
		if(i<num) {
			elems[i].value = i+1;
			elems[i].onclick = setDmg;
		} else {
			elems[i].classList.add("unused");
		}
	}
}