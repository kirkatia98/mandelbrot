@tool
extends EditorScript

@export var folder : String = "res://palettes/"
@export var path : String = "res://palette_manager.tres"

# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	# load palatte manager
	var manager : PaletteManager = load(path)
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
		var name = file_name.trim_suffix("-1x.png")

		# save to the resource
		manager.textures.append(txt)
		manager.names.append(name)

		# skip .import
		dir.get_next()

	# Save
	manager.num = manager.names.size()


	# overwrite the old palette manager resource
	var err : Error = ResourceSaver.save(manager, path)
