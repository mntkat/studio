extends App
class_name DesktopApp

func _errord(msg: String, title: String) -> void:
	_show_dialog(msg, title, NativeAcceptDialog.ICON_ERROR)

func _warnd(msg: String, title: String) -> void:
	_show_dialog(msg, title, NativeAcceptDialog.ICON_WARNING)

func _infod(msg: String, title: String) -> void:
	_show_dialog(msg, title, NativeAcceptDialog.ICON_INFO)

func _show_dialog(msg: String, title: String, icon: NativeAcceptDialog.Icon):
	var nativeDialog = NativeAcceptDialog.new()
	nativeDialog.dialog_icon = icon
	nativeDialog.dialog_text = msg
	nativeDialog.title = title
	add_child(nativeDialog)
	nativeDialog.hide()
	nativeDialog.show()
