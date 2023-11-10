function check(){
    var name = document.getElementById("name").value
    var email = document.getElementById("email").value

    if(name.trim()===""){
        alert("이름을 입력해 주세요")
        return false
    }
    if(email.trim()===""){
        alert("이메일을 입력해 주세요")
        return false
    }
}