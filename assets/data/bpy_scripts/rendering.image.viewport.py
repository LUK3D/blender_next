import bpy
bpy.context.scene.camera = [obj for obj in bpy.context.scene.objects if obj.type == "CAMERA"][0] if any(obj.type == "CAMERA" for obj in bpy.context.scene.objects) else (bpy.data.objects.new("Camera", bpy.data.cameras.new("Camera")) if not (camera := bpy.data.objects.new("Camera", bpy.data.cameras.new("Camera"))) else camera)
frame_to_render = {{frame}}
bpy.context.scene.frame_set(frame_to_render)
bpy.context.scene.render.resolution_x = {{width}}
bpy.context.scene.render.resolution_y = {{height}}
bpy.context.scene.render.image_settings.file_format = "PNG"
bpy.context.scene.render.image_settings.color_mode = "RGBA"
bpy.context.scene.render.image_settings.color_depth = "8"
bpy.context.scene.render.image_settings.compression = 15
bpy.context.scene.render.filepath = r"{{out_path}}"
bpy.ops.render.opengl(write_still=True)
bpy.ops.wm.quit_blender()
