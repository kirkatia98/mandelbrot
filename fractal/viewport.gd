extends SubViewport

@export var f : Fractal

func save_png():
	var texture: Texture2D = get_texture()
	var image : Image = texture.get_image()

	var root : String = "user://"

	var folder : String = "images/"
	var fmt_str = "%s_%d.%d_%d.%d.png"

	# create an images directory if it doesn't already exist
	if(!DirAccess.dir_exists_absolute(root + folder)):
		DirAccess.make_dir_absolute(root + folder)

	var time : Dictionary = Time.get_datetime_dict_from_system()
	var img_name = fmt_str % [f.name, time["month"], time["day"], time["hour"], time["minute"] ]

	if OS.has_feature("web"):
		var buffer = image.save_png_to_buffer()
		JavaScriptBridge.download_buffer(buffer, "%s.png" % img_name, "image/png")
	else:
		image.save_png(root + folder + img_name)
