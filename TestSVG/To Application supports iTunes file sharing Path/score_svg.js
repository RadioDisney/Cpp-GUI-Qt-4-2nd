(function () {
    "use strict";

    var PopuMusic = function () {
        this.root_element = document.querySelector("svg");
        this.root_element.onclick = this.root_element_onclick.bind(this);

        this.out_message = document.querySelector("#outmessage");

        this.a = 1;
        this.b = 2;
    };

    PopuMusic.prototype = {
        color1: "#ff0000",

        color2: "rgba(0,0,255,0.5)",

        root_element_onclick: function (e) {
            for(var item = e.target;;)
            {
                if (item == undefined)
                {
                    break;
                }
                else if (item.id != undefined
                    && item.id.indexOf("M_")!=-1)
                {
                    var m = item.id.substring(2);
                    this.out_message.innerText += '['+m+']';
                    window.webkit.messageHandlers.onClick.postMessage(m);
                    break;
                }
                else
                {
                    item = item.parentElement;
                }
            }
        },

        changeNoteColor: function(measure, note, color) {
            // var items = document.body.querySelectorAll("#mn" + measure + "_" + note);
            for (var i = 1; ;i++)
            {
                var item = document.getElementById ("MNE_" + measure + "_" + note + "_" + i);
                if (item == undefined)
                    break;
                else if (item.getAttribute("fill") != "#fbe7bf")
                    item.setAttribute("fill", color);
            }

            return 1;
        }

    };


    var pm = new PopuMusic();

    window.popuMusic = pm;
})();

var onClickMeasure = function (e)
{
    for(var key in e.path)
    {
        if (e.path[key].nodeName == "g"
            && e.path[key].id != undefined
            && e.path[key].id.indexOf("M_")!=-1)
        {
            var m = e.path[key].id.substring(2);
            window.webkit.messageHandlers.onClick.postMessage(m);
            break;
        }
    }
};

function changeNoteColor(measure, note, color)
{
    // var items = document.body.querySelectorAll("#mn" + measure + "_" + note);
    for (var i = 1; ;i++)
    {
        var item = document.getElementById ("MNE_" + measure + "_" + note + "_" + i);
        if (item == undefined)
            break;
        else if (item.getAttribute("fill") != "#fbe7bf")
            item.setAttribute("fill", color);
    }
}

function changeMeasureColor(measure, color)
{
    var item = document.getElementById ("M_" + measure);
    item.children[0].setAttribute("fill", color);
    changeMeasureFretBgColor(measure, color);
}

function changeMeasureFretBgColor(measure, color)
{
    for (var n = 1; n <= 4; n++)
    {
        changeNoteFretBgColor(measure, n, color);
    }
}

function changeNoteFretBgColor(measure, note, color)
{
    for (var i = 1; ;i++)
    {
        var item = document.getElementById ("MNE_" + measure + "_" + note + "_" + i);
        if (item == undefined)
            break;
        else if (item.getAttribute("fill") == "#ffffff")
            item.setAttribute("fill", "#fbe7bf");
        else if (item.getAttribute("fill") == "#fbe7bf")
            item.setAttribute("fill", "#ffffff");

    }
}
