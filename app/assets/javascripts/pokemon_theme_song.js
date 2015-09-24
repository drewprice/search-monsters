function playPause(){
    var audio = document.getElementById("player");
    var audio2 = document.getElementById("player2");
    if (audio.paused){
      audio2.pause();
      audio.play();
    }
    else {
      audio.pause();
    }
}

function playPause2(){
  var audio = document.getElementById("player");
  var audio2 = document.getElementById("player2");
    if (audio2.paused){
      audio.pause();
      audio2.play();
    }
    else {
      audio2.pause();
    }
}
