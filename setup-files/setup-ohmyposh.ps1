Write-Host "Setting up GlazeWM..."

# Move glaze config
# Define the file name you want to check for in the current folder
$fileName = "glaze-wm.yaml"

# Get the current folder path
$currentFolder = Get-Location

# Combine the current folder path with the file name to get the full file path
$filePath = Join-Path -Path $currentFolder -ChildPath $fileName

# Check if the file exists in the current folder
if (Test-Path -Path $filePath -PathType Leaf) {
    # Define the folder name you want to check for in the parent folder
    $folderName = ".glaze-wm"

    # Get the parent folder path
    $parentFolder = (Get-Item $currentFolder).Parent.FullName

    # Combine the parent folder path with the folder name to get the full folder path
    $folderPath = Join-Path -Path $parentFolder -ChildPath $folderName

    # Check if the folder exists in the parent folder, and create it if it doesn't
    if (-not (Test-Path -Path $folderPath -PathType Container)) {
        New-Item -Path $folderPath -ItemType Directory -Force
    }

    # Define the destination file path in the other folder
    $destinationFilePath = Join-Path -Path $folderPath -ChildPath $fileName

    # Copy the original file into the other folder
    Copy-Item -Path $filePath -Destination $destinationFilePath -Force

    Write-Host "File '$fileName' copied to '$folderPath'"
} else {
    Write-Host "File '$fileName' does not exist in the current folder."
}
