$(document).ready(function(){
    startingDefaultForPokeball();
    switchToBadPokeball();
    switchToGoodPokeball();

    function startingDefaultForPokeball(){
         $('.badPlayer').hide();
    }

    function switchToBadPokeball(){
       $('#bad').on("click", function(){
         $('.goodPlayer').hide();
         $('.badPlayer').show();
       });
    }

    function switchToGoodPokeball(){
       $('#good').on("click", function(){
         $('.badPlayer').hide();
         $('.goodPlayer').show();
       });
    }
});
