function gugudanEvent(){
    var number = parseInt(document.getElementById("number").value)

    for(var index = 0; index < 9;index++){
        var tmp = document.createElement("p") // html 태그를 만드는 명령어 (중복 코드 제거 가능 -> 유지보수 굿)
        tmp.innerHTML =  number*(index+1)

        document.getElementById("parent").appendChild(tmp) // 자식으로 추가하겠다 (화면에 반영)
        // document.getElementById("num" + (index+1)).innerHTML =  number*(index+1)
    }
}

// var numList = [1,2,3]
// for(var i = 0; i<numList.length; i++){ // 3 말고 length (유지보수 좋아짐)
    
// }

// var tmp = []

// tmp.push(1) // 값 넣기

//EVENT 심화
//이벤트라는 것은 사용자가 할 수 있는 행동을 명세한 것

// onclick() : 클릭 이벤트
// onchange() : 값이 바뀌었을 때 이벤트 (input이랑 자주씀)
// onmouseover() : 마우스가 요소에 올라갔을 때
// onmouseleave() : 마우스가 요소에서 내려갔을 때
// onscroll() : 
// ondblclick() : 더블 클릭

// drag & drop (드래그) (총 3가지의 이벤트가 합쳐져서 구동됨)
// ondragstart : 드래그가 시작될 때 이벤트
// ondragover : 드래그가 된 상태에서 요소에 마우스가 올라갈 때 이벤트
// ondrop : 드롭될 때 이벤트

// 드래그가 시작될 요소의 배경색을 저장

var color = null

function dragStartEvent(e){ // event : 모든 요소
    // var tag = e.target // target : 이벤트가 시작된 요소 가져옴(태그 정보)
    // console.log(tag)

    // var color = e.target.style.backgroundColor // inner 스타일 가져온다는 느낌(내부에 style)
    color = window.getComputedStyle(e.target).backgroundColor //계산된 css (내부 말고)
}

function dragOverEvent(e){
    e.preventDefault() // 이 이벤트 외에 다른 이벤트는 무시해 주세요 (동시에 시작될 수 있는 모든 이벤트(onmouseover)를 무시)
}

//저장된 배경색을 요소에 입혀줌
function dropEvent(e){
    e.target.style.backgroundColor = color
}