function changeNoteColor(measure, note, color)
{
    var items = document.body.querySelectorAll("#mn" + measure + "_" + note);
    for (var i = 0; i < items.length; i++)
    {
        if (items[i].getAttribute("fill") != "#ffffff")
            items[i].setAttribute("fill", color);
    }
}
