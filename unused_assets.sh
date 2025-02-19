#!/bin/bash

# Define the asset extensions you want to check
extensions=("svg" "png" "jpeg" "jpg" "json")

# Find all asset files in the assets directory
assets=()
for ext in "${extensions[@]}"; do
  while IFS= read -r -d '' file; do
    assets+=("$file")
  done < <(find assets/ -type f -name "*.$ext" -print0)
done

# Function to check if an asset is referenced in the code
is_asset_referenced() {
  local asset="$1"
  # Extract just the file name from the asset path
  asset_name=$(basename "$asset")
  # Check if the file name is referenced in the code
  grep -r -q "$asset_name" lib/
}

# List of unused assets
unused_assets=()

# Check each asset
for asset in "${assets[@]}"; do
  if ! is_asset_referenced "$asset"; then
    unused_assets+=("$asset")
  fi
done

# Print the list of unused assets
if [ ${#unused_assets[@]} -eq 0 ]; then
  echo "No unused assets found."
else
  echo "Unused assets:"
  for unused_asset in "${unused_assets[@]}"; do
    echo "$unused_asset"
  done
fi