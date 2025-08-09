
import shutil
import os

directory_to_zip = 'salla-theme-package'
output_filename = 'tariq-theme1'

try:
    archive_path = shutil.make_archive(output_filename, 'zip', directory_to_zip)
    print(f"Successfully created zip archive at: {archive_path}")
except FileNotFoundError:
    print(f"Error: The directory '{directory_to_zip}' was not found.")
except Exception as e:
    print(f"An error occurred: {e}")
