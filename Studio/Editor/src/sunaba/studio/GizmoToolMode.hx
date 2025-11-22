package sunaba.studio;

enum abstract GizmoToolMode(Int) from Int to Int {
    var move = 1;
    var rotate = 2;
    var scale = 4;
    var all = 7;
}