function check(){
    var id = document.getElementById("id").value
    var pw = document.getElementById("pw").value
    var email = document.getElementById("email").value
    var name = document.getElementById("name").value
    var birth = document.getElementById("birth").value
    var phone = document.getElementById("phone").value
    var pw_same = document.getElementById("pw_same_check").value

    var count = 0
    for(var i=0;i<7;i++){ // 조건에 맞지 않으면 block이 됨 -> 조건에 맞지 않게 작성한 정보 수 ++
        if(document.getElementsByClassName("check_text")[i].style.display=="block"){
            count++
        }
    }
    
    if(count!=0){ //조건에 맞게 입력하지 않았을 때
        alert("제대로 입력해주세요")
        return false
    }
    if(id===""||pw===""||email===""||name===""||birth===""||phone===""){
        alert("모든 입력칸을 입력해 주십시오")
        return false
    }
    if(pw_same===""){
        alert("비밀번호 확인을 진행해주세요")
        return false
    }
    if(document.getElementById("id_duplication_check_btn").style.display!="none"){
        alert("아이디 중복확인을 진행해주십시오")
        return false
    }
    if(document.getElementById("pw_check_check_text").style.display!="none"){
        alert("비밀번호 확인을 진행해주십시오")
        return false
    }
    if(document.getElementById("email_duplication_check_btn").style.display!="none"){
        alert("이메일 중복확인을 진행해주십시오")
        return false
    }

}

function id_check(){
    var id = document.getElementById("id").value
    var id_pattern = /^[a-zA-Z0-9]{4,20}$/
    if(!id_pattern.test(id)){ // 정규식과 맞지 않으면
        document.getElementById("id_check_text").style.display="block"
    }
    else{
        document.getElementById("id_check_text").style.display="none"
    }
}

function pw_check(){
    var pw = document.getElementById("pw").value
    var pw_pattern = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,30}$/
    if(!pw_pattern.test(pw)){
        document.getElementById("pw_check_text").style.display="block"
    }
    else{
        document.getElementById("pw_check_text").style.display="none"
    }
}

function pw_same(){
    var pw = document.getElementById("pw").value
    var pw_same_check = document.getElementById("pw_same_check").value
    if(pw!=pw_same_check){ // 비밀번호와 일치하지 않을 때
        document.getElementById("pw_check_check_text").style.display="block"
    }
    else if(pw==pw_same_check){
        document.getElementById("pw_check_check_text").style.display="none"
    }
}

function email_check(){
    var email = document.getElementById("email").value
    var email_pattern = /^[0-9a-zA-Z._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/
    if(!email_pattern.test(email)){
        document.getElementById("email_check_text").style.display="block"
    }
    else{
        document.getElementById("email_check_text").style.display="none"
    }
}

function name_check(){
    var name = document.getElementById("name").value
    var name_pattern = /^[가-힣]{2,5}$/
    if(!name_pattern.test(name)){
        document.getElementById("name_check_text").style.display="block"
    }
    else{
        document.getElementById("name_check_text").style.display="none"
    }
}

function birth_check(){
    var birth = document.getElementById("birth").value
    var birth_pattern = /^(19|20)[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/
    if(!birth_pattern.test(birth)){
        document.getElementById("birth_check_text").style.display="block"
    }
    else{
        document.getElementById("birth_check_text").style.display="none"
    }
}

function phone_check(){
    var phone = document.getElementById("phone").value
    var phone_pattern = /^01[0179][0-9]{7,8}$/
    if(!phone_pattern.test(phone)){
        document.getElementById("phone_check_text").style.display="block"
    }
    else{
        document.getElementById("phone_check_text").style.display="none"
    }
}

function id_duplication_check(){
    // 중복확인이 됐으면 버튼을 없애고 싶어 -> 부모 html에 있는 버튼을 건드려야 해
    // -> opener로 가능 -> open으로 창을 새로 열어야 해
    // -> open은 GET 방식임
    // -> form으로는 값을 보낼 수 없음
    // -> url에 뒤에 값이 보이는 게 get 방식 ?id=어쩌구 (id는 name임)
    // -> 내가 직접 보내면 새 창에서 접근할 수 있어!
    var id = document.getElementById("id").value
    if(id==="" || document.getElementsByClassName("check_text")[0].style.display=="block"){
        alert("아이디를 제대로 입력해주세요")
        return false
    }
    window.open("/week06/user/id_duplication_check_action.jsp?id_value="+ id,"width=400","height=350")
}

function email_duplication_check(){
    var email = document.getElementById("email").value
    if(email==="" || document.getElementsByClassName("check_text")[3].style.display=="block"){
        alert("이메일을 제대로 입력해주세요")
        return false
    }
    window.open("/week06/user/email_duplication_check_action.jsp?email_value="+ email,"width=400","height=350")
}