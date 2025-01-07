extends SubViewport

func save_png():
	var texture: Texture2D = get_texture()
	var image : Image = texture.get_image()

	var fmt_str = "res://%s/%s_%d.%d_%d.%d.png"
	var folder = "demo_files"

	var time : Dictionary = Time.get_datetime_dict_from_system()
	var img_name = fmt_str % [folder, name, time["month"], time["day"], time["hour"], time["minute"] ]

	return image.save_png(img_name)
