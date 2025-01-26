import bpy
import sys

# Parse positional command-line arguments


def get_command_line_args():
    args = sys.argv[sys.argv.index("--") + 1:]  # Extract arguments after `--`
    if len(args) < 2:
        print("Error: Two arguments required: <name> <type>")
        sys.exit(1)
    addon_name = args[0]
    addon_type = args[1].lower()
    if addon_type not in ["extension", "addon"]:
        print("Error: <type> must be either 'extension' or 'addon'")
        sys.exit(1)
    return addon_name, addon_type

# Main logic


def enable_addon_or_extension(addon_folder_name, addon_type):
    try:
        if addon_type == "extension":
            bpy.ops.preferences.addon_enable(
                module=f"bl_ext.blender_org.{addon_folder_name}")
        else:
            bpy.ops.preferences.addon_enable(module=addon_folder_name)
        # Save preferences after enabling
        bpy.ops.wm.save_userpref()
        print(
            f"Addon/Extension '{addon_folder_name}' enabled and preferences saved successfully.")
    except Exception as e:
        print(f"Failed to enable addon/extension '{addon_folder_name}': {e}")


# Entry point
if __name__ == "__main__":
    addon_name, addon_type = get_command_line_args()
    enable_addon_or_extension(addon_name, addon_type)
