@tool
extends EditorScript

@export var folder : String = "res://palette/textures/"

@export var res_path : String = "res://palette/palette_manager.tres"
@export var script_path : String = "res://palette/palette.gd"
@export var scene_path : String = "res://palette/palette_selection.tscn"

# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	var manager : PaletteManager = update_resource()
	var script : Script = update_script(manager)
	var scene : PackedScene = update_scene(manager)


	ResourceSaver.save(manager, res_path)
	ResourceSaver.save(script, script_path)
	ResourceSaver.save(scene, scene_path)

	print("script complete")


func update_resource() -> PaletteManager:
	# load palatte manager
	var manager : PaletteManager = load(res_path)
	manager.textures.clear()
	manager.names.clear()

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

		manager.textures.append(txt)
		manager.names.append(name)

		# skip .import
		dir.get_next()

	manager.num = manager.names.size()

	manager.textures.append(null)
	manager.names.append("EMPTY")


	return manager


var content = """class_name Palette extends RefCounted

enum Enum {"""

func update_script(manager : PaletteManager) -> GDScript:

	var script : GDScript = GDScript.new()

	for i : int in range(manager.num):
		var name : String = manager.names[i]
		content += "\n\t%s," % name

	content += "\n\tEMPTY"
	content += "\n}"

	script.source_code = content

	return script

func update_scene(manager : PaletteManager) -> PackedScene:

	var scene : PackedScene = load(scene_path)
	var button : OptionButton = scene.instantiate()

	button.clear()


	for i : int in range(manager.num):
		var name : String = manager.names[i]
		var txt : Texture2D = manager.textures[i]


		button.add_item(name)
		button.set_item_icon(i, txt)

	# Empty Palette
	button.add_item("EMPTY")

	scene.pack(button)


	return scene
