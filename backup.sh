#!/bin/bash

# This checks if the number of arguments is correct
if [[ $# != 2 ]]; then
  echo "Usage: $0 target_directory_name destination_directory_name"
  exit 1
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]; then
  echo "Invalid directory path provided"
  exit 1
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo "Target Directory is: $targetDirectory"
echo "Destination Directory is: $destinationDirectory"

# [TASK 3]
currentTS=$(date +%Y%m%d%H%M%S)

# [TASK 4]
backupFileName="backup-$currentTS.tar.gz"

# We're going to:
# 1: Go into the target directory
# 2: Create the backup file
# 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]
cd "$destinationDirectory" || exit
destDirAbsPath=$(pwd)

# [TASK 7]
cd "$origAbsPath" || exit
cd "$targetDirectory" || exit

# [TASK 8]
yesterdayTS=$(($(date +%s) - 24 * 60 * 60))

declare -a toBackup

# [TASK 9]
for file in *; do
  # [TASK 10]
  file_last_modified_date=$(date -r "$file" +%s)
  if [[ -n $file_last_modified_date && $file_last_modified_date -gt $yesterdayTS ]]; then
    # [TASK 11]
    toBackup+=("$file")
  fi
done

# [TASK 12]
tar -czvf "$backupFileName" "${toBackup[@]}"

# [TASK 13]
mv "$backupFileName" "$destDirAbsPath"
echo "Backup completed successfully! Backup file is located at: $destDirAbsPath/$backupFileName"

# Congratulations! You completed the final project for this course!