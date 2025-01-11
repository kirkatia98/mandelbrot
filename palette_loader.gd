@tool
extends EditorScript

@export var folder : String = "res://palettes/"

@export var res_path : String = "res://palette_manager.tres"
@export var script_path : String = "res://palette.gd"

# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	var manager : PaletteManager = update_resource()
	update_code(manager)


func update_resource() -> PaletteManager:
	# load palatte manager
	var manager : PaletteManager = load(res_path)
	manager.textures.clear()

	# Open the palette folder and begin scaning
	var dir = DirAccess.open(folder)
	dir.list_dir_begin()

	while true:

		# get the next palette
		var file_name : String = dir.get_next()
		if(file_name == ""):
			break

		# load as a texture
		var txt : Texture2D = load(folder + file_name)
		var name : String = file_name

		name = name.trim_suffix("-1x.png")
		name = name.replace("-", "_")
		name = name.to_upper()

		manager.textures[name] = txt

		# skip .import
		dir.get_next()

	# Save
	manager.num = manager.textures.size()

	# overwrite the old palette manager resource
	var _err : Error = ResourceSaver.save(manager, res_path)

	return manager


var content = """
class_name Palette extends RefCounted

enum Enum {
	EMPTY"""

func update_code(manager : PaletteManager):

	var script : GDScript = GDScript.new()

	for k : String in manager.textures.keys():
		content += ",\n\t%s" % k

	content += "\n}"

	script.source_code = content

	var _err : Error = ResourceSaver.save(script, script_path)

	script.emit_changed()
