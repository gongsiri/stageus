function open_event(e){
    console.log(e.target.id)
    var week = e.target.id
    switch(week){
        case "week02":
            window.location.href = "week02/homework2.html"
            break
        case "week03" :
            window.location.href = "week03/homework3.html"
            break
        case "week04" :
            window.location.href = "week04/homework4.html"
            break
    }
}