var click_count = 0 // 버튼(숫자) 누른 횟수
var answer = [] // 정답(난수) 배열
var guess = [] // 사용자 답변 배열
var try_count=0 // 시도한 횟수

function game_start_event(){ // 시작 버튼 누름
    var start_btn = document.getElementById("start_btn") // start_btn 가져옴
    var back_music = document.getElementById("back_music") //배경음악 가져옴
    var start_ment = document.getElementById("start_ment") //초기 시작 멘트 가져옴
    var audio = new Audio('play_ball.mp3') //playball이라고 외치는 효과음 가져옴

    start_btn.style.visibility='hidden' // 시작 버튼 사라짐
    back_music.pause() // 배경음악 멈춤
    start_ment.style.display='none' //초기 시작 멘트 없어짐 visibility 쓰면 그 자리 계속 차지
    audio.play() //효과음 재생
    
    while(true){
        answer[0] = Math.floor(Math.random()*9+1) // 100부터 999까지의 숫자가 나와야 하므로 100의 자리는 1부터 9까지 나와야 한다
        answer[1] = Math.floor(Math.random()*9+1) // 1부터 9까지 나온다
        answer[2] = Math.floor(Math.random()*9+1) // 1부터 9까지 나온다
        if(answer[0]!=answer[1]&&answer[0]!=answer[2]&&answer[1]!=answer[2]){ // 각 자리에 있는 수가 서로 중복이 안 되면
            break //while 문 탈출하고 그것이 answer이 됨
        }
    }

    console.log(answer) //콘솔창에 답 보이게
}

function number_click_event(selected){ // 각 숫자버튼 누름 -> 숫자버튼 여러개에 같은 함수 쓰기에 어떤 숫자를 눌렀는지 selected라는 매개변수 사용
    var first_number = document.getElementById("first_number") // 첫번째 자리 div
    var second_number = document.getElementById("second_number") //두번째 자리 div
    var third_number = document.getElementById("third_number") //세번째 자리 div
    var start_btn = document.getElementById("start_btn") //시작 버튼 button

    if(start_btn.style.visibility!='hidden'){ // 시작 버튼이 눈에 보이면 (=시작 버튼을 안 눌렀으면)
        alert("시작을 하고 눌러주세요")
    }
    else{ // 시작 버튼 눌린 상태면
        click_count++ //버튼 누른 횟수 +1
        if(click_count==1){ // 버튼 누른 횟수가 1번이면
            first_number.innerHTML = selected.innerHTML // 첫번째 자리 div의 innerHTML에 선택된 버튼의 innerHTML 넣어줌
            guess[0]=selected.innerHTML // 추측한 수 배열[0]에 innerHTML 넣어줌
            selected.disabled=true // 선택된 버튼 비활성화 (중복해서 선택 못 하게)
        }
        else if(click_count==2){ 
            second_number.innerHTML=selected.innerHTML // 두번째 자리 div의 innerHTML에 선택된 버튼의 innerHTML 넣어줌
            guess[1]=selected.innerHTML
            selected.disabled=true
        }
        else if(click_count==3){
            third_number.innerHTML=selected.innerHTML //세번째 자리 div의 innerHTML에 선택된 버튼의 innerHTML 넣어줌
            guess[2]=selected.innerHTML
            selected.disabled=true
            compare()
        }
        else{ // 버튼 누른 횟수가 4번이면
            alert("숫자를 입력할 수 없습니다")
        }
    }
}

function initialize(){ //게임 자체를 아예 초기화
    try_count=0
    answer=[]
    guess=[]
    var start_ment = document.getElementById("start_ment")
    var result_div = document.getElementsByClassName("result_div")
    var start_btn = document.getElementById("start_btn")
    var back_music = document.getElementById("back_music")

    start_ment.style.display='block' //초기 시작 멘트 보이게
    for(var i=0;i<5;i++){ // 결과 박스 안 보이게
        result_div[i].style.visibility='hidden'
    }
    start_btn.style.visibility='visible' //시작 버튼 보이게
    back_music.play() //배경음악 재생
}

function compare(){ // 입력 버튼 누름 -> 판별
        if(click_count<3){ // 숫자 3개를 모두 입력하지 않았으면
            alert("숫자를 모두 입력해주세요")
        }
        else{
            var audio = new Audio('baseball_sound.mp3') //깡 치는 소리 가져옴
            var ball= 0 // ball 수
            var strike= 0 // strike 수
            var out = 0 // out 수
            var strike_number = document.getElementsByClassName("strike_number") // strike_number div
            var ball_number = document.getElementsByClassName("ball_number") // ball_number div
            var out_number = document.getElementsByClassName("out_number") // out_number div
            var first_number = document.getElementById("first_number")
            var second_number = document.getElementById("second_number")
            var third_number = document.getElementById("third_number")
            var wirte_count = document.getElementsByClassName("count") // count div
            var result_div = document.getElementsByClassName("result_div")
            var input_result = document.getElementsByClassName("input_result")

            audio.play() //효과음 재생
            try_count++ //enter 눌렀으면 시도 한번 한 거기 때문에 +1 해줌
            wirte_count[try_count-1].innerHTML= '#'+try_count  // count div 내부에 try_count(시도 횟수)를 적어줌
            for(var i=0; i<3; i++){ // 답과 추측의 비교 
                for(var j=0; j<3; j++){
                    if(answer[i] == guess[j]){ //우선 숫자 같음
                        ball++ // ball +1
                        if(i==j){ // 숫자 같은데 위치도 같음
                            ball-- // strike니까 ball 다시 줄여줌
                            strike++ // strike +1
                        }
                    }
                }
            }
            if(strike==0 && ball==0){ // 위의 결과로 strike 0개 bal 0개 나옴
                out++ // out +1
            }
            strike_number[try_count-1].innerHTML = strike // strike 수를 strike_number 내부에 적어줌
            ball_number[try_count-1].innerHTML=ball // ball 수를 ball 내부에 적어줌
            out_number[try_count-1].innerHTML=out // out 수를 out_number 내부에 적어줌
            result_div[try_count-1].style.visibility='visible' //result_div를 보이게 함
            input_result[try_count-1].innerHTML = guess[0]+guess[1]+guess[2] //input_result에 추측한 수를 적어줌
            
            //초기화 시켜주는 느낌
            var buttons = document.getElementsByTagName("button") // 숫자 버튼들 가져옴
            for(var i=0; i<buttons.length;i++){ // 모든 버튼에 대해서
                buttons[i].disabled = false // 버튼들을 활성화 시킴 
            }
            first_number.innerHTML = "" // first_number 내부를 공백으로
            second_number.innerHTML=""
            third_number.innerHTML=""
            click_count=0 // 숫자 누른 횟수를 0번으로

            if(strike==3){ // 3 strike 
                setTimeout(function(){ //1초 후 브금 실행
                    var audio = new Audio('victory.mp3')
                    audio.play()},1000)
                
                setTimeout(function(){ //2초 후 알림창
                    alert("정답입니다! \n확인을 누르면 게임이 재시작 됩니다.")
                    initialize()
                },2000)
            }
            else{ // 3 strike가 아닐 때
                if(try_count==5){ //마지막 횟수일 때
                    setTimeout(function(){ 
                        var audio = new Audio('defeat.mp3')
                        audio.play()},1000)

                    setTimeout(function(){
                        alert("틀렸습니다! \n정답은 " +answer[0]+answer[1]+answer[2] + "\n확인을 누르면 게임이 재시작 됩니다.")
                        initialize()
                    },2000)
                }
            }
        }  
    }


function restart_event(){
    initialize()
    game_start_event()
    //숫자를 입력하는 도중에 재시작 버튼을 눌렀을 때를 대비
    var buttons = document.getElementsByTagName("button")
    for(var i=0; i<buttons.length;i++){ // 모든 버튼에 대해서
        buttons[i].disabled = false // 버튼들을 활성화 시킴 
    }
    first_number.innerHTML = "" // first_number 내부를 공백으로
    second_number.innerHTML=""
    third_number.innerHTML=""
    click_count=0 // 숫자 누른 횟수를 0번으로
}

function remove_event(){
    var first_number = document.getElementById("first_number")
    var second_number = document.getElementById("second_number")
    var third_number = document.getElementById("third_number")
    var buttons = document.getElementsByTagName("button")
    first_number.innerHTML = ""
    second_number.innerHTML=""
    third_number.innerHTML=""
    click_count=0
    for(var i=0; i<buttons.length;i++){
        buttons[i].disabled = false
    }
}
  



