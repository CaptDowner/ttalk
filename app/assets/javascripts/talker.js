function playSound(f) {
  soundfile = new Audio(f);
  soundfile.play();
  return false; // prevent default click action from happening!
}

window.scrollTo = function( x,y ) {
  return true;
}

function changePic() {
  document["leftpic"].src="images/tom01.gif";
  document["rightpic"].src="images/tom01.gif";
}

function showhide(myid) {
  var div = document.getElementById(myid);
    div.style.display = (div.style.display != 'none' ? 'none' : 'block');
};


