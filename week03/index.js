// console.log("스테이지어스") //콘솔에(f12에 있는)출력을 담당


// function printMessage(){
//     console.log("스테이지어스")
// }

// function printMessage2(){
//     console.lof("스테이지어스")
// }

// printMessage()
// printMessage()
// printMessage2()
// printMessage()
// printMessage()

//매개변수, 리턴 값 둘 다 없음
// function power(){
//     console.log(2*2)
// }
// power()

// //매개변수만 있음
// function power(number){
//     console.log(number*number)
// }
// power(2)
// power(5)

// //매개변수, 리턴 값 둘 다 있음, 계산값만 나옴 (하고 싶은 걸 함수 밖에서 해줘야 함)
// function power(number){
//     return number*number
// }
// console.log(power(2))
// console.log(power(4)+power(3))

// var number1 = 10 //integer
// var number2 = "10" //string -> 변수에 넣는 값에 따라 자료형을 알아서 정해줌(오토캐스팅)
// var flag= true
// var number3 = 10.5

// console.log(number1+number1) //->20
// console.log(number2+number2) //-> 1010(문자를 이어주기만 함)
// console.log(parseInt(number2)+parseInt(number2)) //->문자가 숫자로
// console.log(String(number1)+String(number1)) //->숫자가 문자로



function printMessageEvent(){ //다른 곳에서 호출되면 안됨->뒤에 Event를 붙여서 이벤트 함수임을 알려줌
    console.log("스테이지어스")
}

function add(){
    //html에 있는 태그 값을 가져옴
    var num1 = parseInt(document.getElementById("num1").value)//태그 자체를 들고 와서 그 안에 있는 값(value)
    var num2 = parseInt(document.getElementById("num2").value)
    document.getElementById("result_box").innerHTML = num1+num2
    //깔끔해진 코드!!(굿)
}

function sub(){
    //html에 있는 태그 값을 가져옴
    var num1 = document.getElementById("num1").value //태그 자체를 들고 와서 그 안에 있는 값(value)
    var num2 = document.getElementById("num2").value
    //함수에서 중복처럼 보인다고 전역변수로 빼면 안됨 -> 프로그램 시작하자마자 생성되기 때문에 빈값이 담김...ㅠ, 차라리 함수를 하나 더 만들던가 해...(굳이)

    //계산
    var result = parseInt(num1) - parseInt(num2)

    //계산된 값을 화면에 반영
    var resultBox = document.getElementById("result_box")
    resultBox.innerHTML=result
}

function mix(){
    //html에 있는 태그 값을 가져옴
    var num1 = document.getElementById("num1").value //태그 자체를 들고 와서 그 안에 있는 값(value)
    var num2 = document.getElementById("num2").value
    
    //계산
    var result = parseInt(num1) * parseInt(num2)

    //계산된 값을 화면에 반영
    var resultBox = document.getElementById("result_box")
    resultBox.innerHTML=result
}

function divide(){
    //html에 있는 태그 값을 가져옴
    var num1 = document.getElementById("num1").value //태그 자체를 들고 와서 그 안에 있는 값(value)
    var num2 = document.getElementById("num2").value
    
    //계산
    var result = parseInt(num1) / parseInt(num2)

    //계산된 값을 화면에 반영
    var resultBox = document.getElementById("result_box")
    resultBox.innerHTML=result
}


//조건문

function compare(){
    var num1 = parseInt(document.getElementById("num1").value)//태그 자체를 들고 와서 그 안에 있는 값(value)
    var num2 = parseInt(document.getElementById("num2").value)

    var resultBox= document.getElementById("result_box")
    if(num1>num2){
       resultBox.innerHTML="왼쪽이 큼"
    }

    else if(num1<num2){ // else-> 위에가 참이 아니라면 실행
        resultBox.innerHTML="오른쪽이 큼"
    }

    else if(num1==num2){
        resultBox.innerHTML="같음"
    }

    // else if(num1 <=num2){ // 일어날 확률 없어!!!
    //     resultBox.innerHTML = "오른쪽이 크거나 같음"
    // }
    
    else{
        resultBox.innerHTML="잘못 입력함"
    }
    //가장 나올 확률이 높은걸 젤 위로 하는 게 좋음!! (if)
    //확률이 100퍼센트가 넘어가면 안됨
}