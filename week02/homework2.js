/*초기 상태는 안 보이는 상태라고 선언*/
                        /*if 안에 hidden_menu.style.left=='-240px'로 했더니 두번 째 클릭에서야 먹힘*/
                        /*var hidden_menu_left = hidden_menu.style.left, if(hidden_menu_left == '-240px')
                        동작 x -> 직접 접근하면 초기에는 브라우저의 기본 스타일 값이 반환될 가능성 */

function show_menu(){
    var hidden_menu = document.getElementById("hidden_menu") /*document는 DOM 트리의 최상위 객체 -> 전체에서 찾겠다는 느낌*/
    var dark_background = document.getElementById("dark_background")
    var section = document.getElementById("section_part")

    if(section.style.overflow!='hidden'){  //초기 상태 -> section의 overflow가 hidden이 아닐 때
        hidden_menu.style.left='0' //hidden_menu의 left를 0으로 줘서 보이게 만듦
        dark_background.style.display='block' // dark_background를 보이게 해서 어둡게 만듦
        section.style.overflow='hidden' // section의 overflow를 hidden으로 바꿈 -> 스크롤 안됨
    }
    else{ /*true일 때(보일때) 누르면*/
        hidden_menu.style.left='-240px'
        dark_background.style.display='none'
        section.style.overflow='auto'
    }
}

function enlarge_thumbnail(selected_div){
    var thumbnail = selected_div.getElementsByClassName("thumbnail") //getElementsByClassName -> 변수에 클래스 이름이 thmbnail인 모든 요소가 저장됨 ->인덱스값을 통해 각 요소 접근 가능
                                                                    // 마우스가 올라간 특정 div 요소가 this로 넘겨짐 -> 그 div에서 찾겠다는 느낌이므로 document 대신 selected_div
    thumbnail[0].style.borderRadius='0'
    //다른 방법
    // var thumbnail = selected.div.querySelector('.thumbnail') 내부에서 thumbnail 클래스를 가진 첫번째 요소를 선택함                                                               
    // thumbnail.style.borderRadius='0'
}

function reduce_thumbnail(selected_div){
    var thumbnail = selected_div.getElementsByClassName("thumbnail") //getElementsByClassName -> 변수에 클래스 이름이 thmbnail인 모든 요소가 저장됨 -> 반복문을 통해(인덱스값을 통해) 각 요소 접근 가능
                                                                     // 마우스가 올라간 특정 div 요소가 this로 넘겨짐 -> 그 div에서 찾겠다는 느낌이므로 document 대신 selected_div
    thumbnail[0].style.borderRadius='20px'
}