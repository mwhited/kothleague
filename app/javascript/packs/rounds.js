$for.ajax({url : 'edit', dataType: 'script', beforeSend : validateRoundForm()});
$for.ajax({url : 'new', dataType: 'script', beforeSend : validateRoundForm()});

function validateRoundForm(){
    var startelement = document.getElementById('round_started');
    var numgameselement = document.getElementById('round_numgames');
    //if((typeof startelement !== 'undefined') && (typeof numgameselement !== 'undefined')){
    if(true){
        var started = startelement.checked;
        var numgames = parseInt(numgameselement.value);

        if(started && numgames<1){
            document.getElementById("jserrors").innerHTML = "A started game must have at least 1 game.";
            
            return false;
        }
        else if(started && numgames>=1){
            var res = confirm("Are you sure? Once a game is started you cannot change the # of teams.");
            if (res == false){return false};
        }
    }
}