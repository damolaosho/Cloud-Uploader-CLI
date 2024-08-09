#!/usr/bin/env zsh

#searches for file in the current directory
if [ -f "./upload-cv.docx" ]; then
#if file exists return this
    echo "file found, upload starting"
else
#if file does not exist, return this
    echo "404!!! file not found. please check if file is in the same directory"
    exit 2
fi #end of if block

#searches if file already exists in s3 bucket
if aws s3 ls "s3://cloud-upload-bucket-03082024/upload-cv.docx" > /dev/null 2>&1; then
    echo "file already exists!!, file upload canceled!"
    exit 3
    read -p "choose an option [O]verwrite, [S]kip, [R]ename: " action
    action=$(echo"$action" | tr '[:lower]' '[:upper]')

    case $action in
        O)
            echo "Overwriting the bucket in the cloud..."
            aws s3  cp "./upload-cv.docx" "s3://cloud-upload-bucket-03082024/upload-cv.docx"
            ;;
        S)
            echo "Skipping the file upload..."
            ;;
        R)
            read Enter new file name for the cloud:  
            aws s3 cp "./upload-cv.docx" "s3://cloud-upload-bucket-03082024/upload-cv.docx"
            ;;
        *)
            echo "invalid input"
            exit 4
            ;;
    esac
else 
    echo "file not found!!!"

fi 

#upload file to s3 bucket
upload_cmd=$(pv ./upload-cv.docx | aws s3 cp "./upload-cv.docx" "s3://cloud-upload-bucket-03082024/" 2>&1)
upload_status=$?


#if successful return this message
if [ $upload_status -eq 0 ]; then
    echo "file upload successful"

    #generate a presigned url (allows users to view objects stored in buckets)
    presigned_url=$(aws s3 presign s3://cloud-upload-bucket-03082024/upload-cv.docx --expires-in 3600)

    if [ $? -eq 0 ]; then
        echo "shareable link: $presigned_url"
    else
        echo "Failed to generate shareable link"
        exit 6
    fi
else
    echo "upload failed, $upload_cmd"
    exit 5
fi

