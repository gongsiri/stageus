var puzzle_imges=[] //퍼즐 이미지를 담을 배열
var count_time

function restart(e){
    document.getElementById("puzzle_1").style.visibility="hidden" //1번 버튼 안 보이게
    document.getElementById("puzzle_2").style.visibility="hidden"
    document.getElementById("puzzle_1_img").style.display="none"
    document.getElementById("puzzle_2_img").style.display="none"
    document.getElementById("shuffle_btn").style.display="block"
    document.getElementById("submit_btn").style.display="block"
    document.getElementsByTagName("h1")[0].style.display="none"
    puzzle_imges.length=0 
    for(var i=0; i<18; i++){
        document.getElementsByClassName("puzzle_tmp_div")[i].style.display="block"
    }
    var puzzle_id = e.target.id
    
    for(var i=1; i<10; i++){
        puzzle_imges.push(puzzle_id + "_"+i+".jpg")
    }
    make_random() //퍼즐을 랜덤으로 배치해주는 함수 호출
    timer()
}

function start_event(e){ //1,2번 버튼 눌렀을 시(=시작)
    make_div() //퍼즐 div들을 만드는 함수 호출
    document.getElementById("puzzle_1").style.visibility="hidden" //1번 버튼 안 보이게
    document.getElementById("puzzle_2").style.visibility="hidden"
    document.getElementById("puzzle_1_img").style.display="none"
    document.getElementById("puzzle_2_img").style.display="none"
    document.getElementById("shuffle_btn").style.display="block"
    document.getElementById("submit_btn").style.display="block"
    document.getElementsByTagName("h1")[0].style.display="none"
    //여기 고쳐보자!!!!
    var puzzle_id = e.target.id
    for(var i=1; i<10; i++){
        puzzle_imges.push(puzzle_id + "_"+i+".jpg")
    }
    make_random() //퍼즐을 랜덤으로 배치해주는 함수 호출
    timer()
}

function make_div(){ //퍼즐 div들을 만드는 함수
    for(var i=0; i<18; i++){
        var div_tmp = document.createElement("div")
        div_tmp.draggable = "true"
        div_tmp.ondragstart = drag_start_event
        div_tmp.ondragover = drag_over_event
        div_tmp.ondrop = drop_event
        div_tmp.className = "puzzle_tmp_div"

        if(i<9){
            document.getElementById("random_puzzle_div").appendChild(div_tmp)
        }
        else{
            document.getElementById("answer_puzzle_div").appendChild(div_tmp)
        }
        // var random_tmp = document.createElement("div")
        // var answer_tmp = document.createElement("div")

        // 
        // random_tmp.draggable = "true"
        // random_tmp.ondragstart = drag_start_event
        // random_tmp.ondragover = drag_over_event
        // random_tmp.ondrop = drop_event

        // answer_tmp.className = "answer_puzzle"
        // answer_tmp.draggable = "true"
        // answer_tmp.ondragstart = drag_start_event
        // answer_tmp.ondragover = drag_over_event
        // answer_tmp.ondrop = drop_event

        // 
        // 
    }
}

function make_random(){ //퍼즐을 랜덤으로 배치해주는 함수
    var finish_imges = [] //중복을 막기 위해 배치된 이미지들 넣는 배열

    for(var i=0; i<9; i++){
        do{ //random_index를 puzzle_imges에서 랜덤으로 인덱스 뽑음
           var random_index = Math.floor(Math.random()*puzzle_imges.length)
        }
        while (finish_imges.includes(random_index)) //finish_imges에 random_index가 포함되어 있으면 종료 -> 중복 안됨

        finish_imges.push(random_index) //이때 random_index는 finish_imges에 없는 것으로 중복되지 않은 index
        var random_img = document.createElement("img")
        random_img.src = puzzle_imges[random_index] //랜덤으로 뽑힌 이미지를 src로 넣어줌
        random_img.id="random_img"+[random_index] //아이디 : random_img1,2,3...
        random_img.className="random_img"
        document.getElementsByClassName("puzzle_tmp_div")[i].appendChild(random_img) // random_puzzle의 각 div에 랜덤으로 뽑힌 이미지들 자식으로 넣어줌
    }
}

function timer(){
    document.getElementById("time_left").style.display="inline"
    document.getElementById("timer").style.display="inline"
    var timer = document.getElementById("timer")
    var time=30// 제한 시간을 30초로 정함 1000->1초
    timer.innerHTML=time

    count_time = setInterval(function(){ // 지정된 시간 간격마다 지정된 기능을 반복하고자
        time-- //1초마다 time에서 1씩 감소
        timer.innerHTML=time //감소된 값을 업데이트 해줌
        if(time==0){ //0초가 되면
            stop_timer() // setInterval() 함수의 실행 중지시킴 count_time : 함수 이름
            setTimeout(function(){
                var audio = new Audio("defeat.mp3")
                audio.play()
                alert("시간 초과되었습니다.\n" + "메인 화면으로 돌아갑니다.")
                game_main()
            },1000)
        }
    },1000)
}

function stop_timer(){
    clearInterval(count_time)
    document.getElementById("time_left").style.display="none"
    document.getElementById("timer").style.display="none"
}
function drag_start_event(e){
    drag_img = e.target
}

function drag_over_event(e){
    e.preventDefault()
}

function drop_event(e) {
    var target_space = e.target; //드롭될 공간(div:이미지가 없을 시) or (img : 이미지가 있을 시) -> 개인적으로 공부(왜 이미지임?)
                                // 하위요소에서 상위요소로 이벤트가 전파됨 -> img 있는 경우 img에서 이벤트가 시작되고 div로 전파
    if(target_space.tagName === "IMG") { //div 안에 img가 있음 오른쪽은 자식이 없는 div -> 자식이 있는지 없는지를 체크 -> 서로의 자식을 바꿔줌
        // 이미지가 있는 경우, 드롭한 이미지와 위치,아이디를 교환
        var tmpSrc = target_space.src;
        target_space.src = drag_img.src;
        drag_img.src = tmpSrc;
        var tmpId = target_space.id
        target_space.id = drag_img.id
        drag_img.id = tmpId
    } else {
        // 이미지가 없는 경우, 드롭한 이미지를 해당 DIV의 자식으로 이동
        target_space.appendChild(drag_img);
    }
}

function game_main(){ //게임 메인화면으로 돌아가는 함수
    document.getElementById("shuffle_btn").style.display="none"
    document.getElementById("submit_btn").style.display="none"
    document.getElementById("puzzle_1").style.visibility="visible"
    document.getElementById("puzzle_2").style.visibility="visible"
    document.getElementById("puzzle_1").onclick=restart
    document.getElementById("puzzle_2").onclick=restart
    document.getElementById("puzzle_1_img").style.display="block"
    document.getElementById("puzzle_2_img").style.display="block"
    document.getElementsByTagName("h1")[0].style.display="block"

    var puzzle_tmp_div = document.getElementsByClassName("puzzle_tmp_div");
    
    for (var i = 0; i < 18; i++) {
        if (puzzle_tmp_div[i].firstChild) {
            puzzle_tmp_div[i].innerHTML=""
        }
        puzzle_tmp_div[i].style.display="none"
    }
}


function compare_event(){ //제출 누를 시
    var count = 0
    var puzzle_tmp_div = document.getElementsByClassName("puzzle_tmp_div")
    var compare_imges=[]

    for(var i=9; i<18;i++){
        var img = puzzle_tmp_div[i].getElementsByTagName("img")[0] //answer_puzzle에 놓은 이미지를 가져옴
        if(img){ //이미지가 있으면
            compare_imges.push(img) //compare_imges[0] = answer_puzzle[0]의 이미지가 됨
        }
    }

    if(compare_imges.length!=9){ //이미지를 모두 놓지 않았을 때
        alert("퍼즐을 모두 맞춰 주세요")
    }
    else{ //이미지를 모두 놓았을 때
        for(var i=0; i<compare_imges.length; i++){
            if(compare_imges[i].id == "random_img"+i){  //0번 자리에 맞춘 이미지의 아이디가 random_img1이면 (맞음)
                count++
            }
        }
        if(count==9){ //9개 다 맞으면
            var audio = new Audio("victory.mp3")
            audio.play()
            alert("정답입니다!")
            stop_timer()
            game_main()
        }
        else{
            alert("정답이 아닙니다!\n" + "틀린 갯수 : "+ (9 - count))
        }
    }
}

function shuffle_event(){ //셔플
    var confirm_alret = confirm("랜덤으로 다시 배치되고 맞춘 퍼즐은 모두 초기화 됩니다.\n"+"셔플 하시겠습니까?")
    
    if(confirm_alret){
        var puzzle_tmp_div = document.getElementsByClassName("puzzle_tmp_div")
        
        for(var i=0 ; i<18; i++){
            var puzzle_img = puzzle_tmp_div[i].getElementsByTagName("img")[0]
            
            if(puzzle_img){ //answer_puzzle 부분에 이미지가 놓여 있으면
            puzzle_tmp_div[i].removeChild(puzzle_img) //그 이미지를 자식에서 제외함
            }
        }
        make_random() //랜덤으로 퍼즐을 배열(=셔플)
        document.getElementById("shuffle_btn").style.display="none"
    }
}