<!DOCTYPE html>
<html>
<body>
<frame >
<h2 onclick="showCoords(event)">Click this heading to get the x (horizontal) and y (vertical) coordinates of the mouse pointer when it was clicked.</h2>

<p><strong>Tip:</strong> Try to click different places in the heading.</p>

<p id="demo"></p>

<script>
function showCoords(event) {
    var x = event.clientX;
    var y = event.clientY;
    var coords = "X coords: " + x + ", Y coords: " + y;
    document.getElementById("demo").innerHTML = coords;
}
</script>

</body>
</html>
