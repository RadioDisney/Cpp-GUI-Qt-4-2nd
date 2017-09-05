function onClick(e)
{
    for(var key in e.path)
    {
        if (e.path[key].nodeName == "g"
            && e.path[key].id != undefined
            && e.path[key].id.indexOf("M_")!=-1)
        {
            var m = e.path[key].id.substring(2);
        }
    }
}

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
