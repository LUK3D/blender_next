import bpy
import sys
import os


def install_addon(zip_path):
    if not os.path.exists(zip_path):
        print(f"Error: The specified zip file does not exist: {zip_path}")
        sys.exit(1)

    try:
        # Install the addon
        bpy.ops.preferences.addon_install(filepath=zip_path)
        # Enable the addon (assuming it's registered correctly)
        addon_name = os.path.splitext(os.path.basename(zip_path))[
            0]  # Extract name from zip
        bpy.ops.preferences.addon_enable(module=addon_name)
        print(f"Successfully installed and enabled addon: {addon_name}")
    except Exception as e:
        print(f"Error during addon installation: {e}")
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: blender --background --python install_blender_addon.py -- <path_to_addon_zip>")
        sys.exit(1)

    # Extract the addon zip path passed after the double dash (--)
    zip_path = sys.argv[sys.argv.index("--") + 1]
    install_addon(zip_path)
