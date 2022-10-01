var isInMenu = false

function Display(bool) {
    if (bool) {
        $("#container").fadeIn(750);
        closeSecondaryMenu()
        isInMenu = true
    } else {
        $("#container").fadeOut(750);
        closeSecondaryMenu()
        $.post('http://${GetParentResourceName()}/exit', JSON.stringify({}));
        isInMenu = false
    }
}

function openSecondaryMenu(menuName) {
    $("#secondaryMenu").fadeIn(250)
    $("#withdrawMenu").hide()
    $("#depositMenu").hide()
    $("#transferMenu").hide()
    switch (menuName) {
        case "withdraw":
            $("#withdrawMenu").show()
            break;
        case "deposit":
            $("#depositMenu").show()
            break;
        case "transfer":
            $("#transferMenu").show()
            break;
        default:
            break;
    }
}

function closeSecondaryMenu() {
    $("#secondaryMenu").fadeOut(250)
}

function handleAction(data) {
    console.log(data)
    $.post('http://${GetParentResourceName()}/action', JSON.stringify({
        data
    }));
}

$(document).click(function(event) {
    if (!isInMenu) return
    switch (event.target.id) {
        case "backButtonSecondaryMenu":
            closeSecondaryMenu()
            break;
        case "exit":
            Display(false)
            break;
        case "buttonWithdraw":
            openSecondaryMenu("withdraw")
            break;
        case "buttonDeposit":
            openSecondaryMenu("deposit")
            break;
        case "buttonTransfer":
            openSecondaryMenu("transfer")
            break;
        case "withdraw":
            var data = {}
            data.amount = $("#amount1").val()
            data.action = "withdraw"
            handleAction(data)
            Display(false)
            break;
        case "deposit":
            var data = {}
            data.amount = $("#amount2").val()
            data.action = "deposit"
            handleAction(data)
            Display(false)
            break;
        case "transfer":
            var data = {}
            data.userid = $("#userID").val()
            data.amount = $("#amount2").val()
            data.action = "transfer"
            handleAction(data)
            Display(false)
            break;
        default:
            break;
    }
})

window.addEventListener('message', (event) => {
    var data = event.data
    if (data.type === 'ui') {
        Display(data.status)
    }
    if (data.type === 'updateBankBalance') {
        $("#amount").html("$ "+data.balance)
        $("#playerid").html(data.userID)
    }
});