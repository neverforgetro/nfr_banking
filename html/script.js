var open = false
$("#exit").click(function() {
    open = false
    openclose(false)
    openclose2(false)
    openclose3(false)
    $.post("http://nfr_banking/exit", JSON.stringify({}))
    return
})
$("#open-withdraw").click(function() {
    if (open == false) {
        open = true
        openclose(true)
    }
    return
})
$("#open-deposit").click(function() {
    if (open == false) {
        open = true
        openclose2(true)
    }
    return
})
$("#open-transfer").click(function() {
    if (open == false) {
        open = true
        openclose3(true)
    }
    return
})
$("#back").click(function() {
    open = false
    openclose(false)
    return
})
$("#back2").click(function() {
    open = false
    openclose2(false)
    return
})
$("#back3").click(function() {
    open = false
    openclose3(false)
    return
})
$("#withdraw").click(function(e) {
    let inputValue = $("#amount1").val()

    if (inputValue.length >= 11) {
        $.post("http://nfr_banking/error", JSON.stringify({
            error: "Nu poti folosii mai mult de 11 cifre!"
        }))
        open = false
        openclose(false)
        return
    } else if (!inputValue) {

        $.post("http://nfr_banking/error", JSON.stringify({
            error: "Introdu o valoare valida!"
        }))
        open = false
        openclose(false)
        return
    }
    if (open == true) {
        e.preventDefault();
        $.post("http://nfr_banking/withdraw", JSON.stringify({
            amount: inputValue
        }));
    }
    open = false
    openclose(false)
    return;
})
$("#deposit").click(function(e) {
    let inputValue = $("#amount2").val()

    if (inputValue.length >= 11) {
        $.post("http://nfr_banking/error", JSON.stringify({
            error: "Nu poti folosii mai mult de 11 cifre!"
        }))
        open = false
        openclose2(false)
        return
    } else if (!inputValue) {

        $.post("http://nfr_banking/error", JSON.stringify({
            error: "Introdu o valoare valida!"
        }))
        open = false
        openclose2(false)
        return
    }
    if (open == true) {
        e.preventDefault();
        $.post("http://nfr_banking/deposit", JSON.stringify({
            amount: inputValue
        }));
    }
    open = false
    openclose2(false)
    return;
})
$("#transfer").click(function(e) {
    let inputValue = $("#amount3").val()
    let inputValue2 = $("#userid").val()
    if (inputValue.length >= 11) {
        $.post("http://nfr_banking/error", JSON.stringify({
            error: "Nu poti folosii mai mult de 11 cifre!"
        }))
        open = false
        openclose3(false)
        return
    } else if (!inputValue) {

        $.post("http://nfr_banking/error", JSON.stringify({
            error: "Introdu o valoare valida!"
        }))
        open = false
        openclose3(false)
        return
    }
    if (open == true) {
        e.preventDefault();
        $.post("http://nfr_banking/transfer", JSON.stringify({
            amount: inputValue,
            userid: inputValue2
        }));
    }
    open = false
    openclose3(false)
    return;
})

function openclose(bool) {
    var div = $(".popup1");
    var button1 = $(".border-withdraw");
    var button2 = $(".border-transfer");
    var button3 = $(".border-deposit");
    var back = $(".back");
    var exit = $(".exit");
    if (bool) {
        div.css('z-index', 1)
        back.css('z-index', 1)
        exit.css('z-index', -1)
        button1.css('z-index', -1)
        button2.css('z-index', -1)
        button3.css('z-index', -1)
        div.animate({
            opacity: '1'
        }, 200);
    } else {
        $(".input1").val("")
        div.css('z-index', -1)
        back.css('z-index', -1)
        exit.css('z-index', 1)
        button1.css('z-index', 1)
        button2.css('z-index', 1)
        button3.css('z-index', 1)
        div.animate({
            opacity: '0'
        }, 200);
    }
}

function openclose2(bool) {
    var div = $(".popup2");
    var button1 = $(".border-withdraw");
    var button2 = $(".border-transfer");
    var button3 = $(".border-deposit");
    var back = $(".back2");
    var exit = $(".exit");
    if (bool) {
        div.css('z-index', 1)
        back.css('z-index', 1)
        exit.css('z-index', -1)
        button1.css('z-index', -1)
        button2.css('z-index', -1)
        button3.css('z-index', -1)
        div.animate({
            opacity: '1'
        }, 200);
    } else {
        $(".input2").val("")
        div.css('z-index', -1)
        back.css('z-index', -1)
        exit.css('z-index', 1)
        button1.css('z-index', 1)
        button2.css('z-index', 1)
        button3.css('z-index', 1)
        div.animate({
            opacity: '0'
        }, 200);
    }
}

function openclose3(bool) {
    var div = $(".popup3");
    var button1 = $(".border-withdraw");
    var button2 = $(".border-transfer");
    var button3 = $(".border-deposit");
    var back = $(".back3");
    var exit = $(".exit");
    if (bool) {
        div.css('z-index', 1)
        back.css('z-index', 1)
        exit.css('z-index', -1)
        button1.css('z-index', -1)
        button2.css('z-index', -1)
        button3.css('z-index', -1)
        div.animate({
            opacity: '1'
        }, 200);
    } else {
        $(".input3").val("")
        div.css('z-index', -1)
        back.css('z-index', -1)
        exit.css('z-index', 1)
        button1.css('z-index', 1)
        button2.css('z-index', 1)
        button3.css('z-index', 1)
        div.animate({
            opacity: '0'
        }, 200);
    }
}

function display(bool) {
    if (bool) {
        $(".all").fadeIn(200);

    } else {
        $(".all").fadeOut(200);
        openclose(false)
        openclose2(false)
        // openclose3(false)
    }
}

window.addEventListener('message', function(event) {
    var item = event.data;
    if (item.type === "ui") {
        if (item.status == true) {
            display(true)
        } else {
            display(false)
        }
    } else if (item.type === "bankBalance") {

        var money = Intl.NumberFormat('de-DE').format(event.data.balance)
        $('#amount').html(money + "$");
        $('#playerid').html(event.data.userid);
    }
})
document.onkeyup = function(data) {
    if (data.which == 27) {
        $.post("http://nfr_banking/exit", JSON.stringify({}));
        open = false
        return
    }
};