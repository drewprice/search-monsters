function playPause(){
    var audio = document.getElementById("player");
    if (audio.paused){
      audio.play();
    }
    else {
      audio.pause();
    }
}

function playPause2(){
    var audio = document.getElementById("player2");
    if (audio.paused){
      audio.play();
    }
    else {
      audio.pause();
    }
}
