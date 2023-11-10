function check(){
    var id = document.getElementById("id").value
    var pw = document.getElementById("pw").value

    if(id.trim()===""){
        alert("아이디를 입력해 주세요")
        return false
    }
    if(pw.trim()===""){
        alert("비밀번호를 입력해 주세요")
        return false
    }
}