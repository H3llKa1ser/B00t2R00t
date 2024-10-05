import os
import shutil

def convert_dll_to_xll(dll_path, xll_path=None):
    """
    This function renames a DLL file to an XLL file.

    :param dll_path: Path to the original DLL file
    :param xll_path: Path where the XLL file will be saved (optional)
    :return: None
    """
    # If the destination path is not provided, replace the extension of the input DLL
    if xll_path is None:
        xll_path = dll_path.replace(".dll", ".xll")
 
    # Check if the DLL file exists
    if not os.path.isfile(dll_path):
        print(f"Error: {dll_path} does not exist.")
        return

    # Rename (or copy) the file to .xll extension
    try:
        shutil.copy(dll_path, xll_path)
        print(f"Successfully converted {dll_path} to {xll_path}")
    except Exception as e:
        print(f"Error during conversion: {e}")

# Example usage
dll_file = '/PATH/TO/OUR/FILE.DLL'
convert_dll_to_xll(dll_file)
