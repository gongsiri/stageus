function check(){
    var id = document.getElementById("id").value
    var email = document.getElementById("email").value

    if(id.trim()===""){
        alert("아이디를 입력해 주세요")
        return false
    }
    if(email.trim()===""){
        alert("이메일을 입력해 주세요")
        return false
    }
}