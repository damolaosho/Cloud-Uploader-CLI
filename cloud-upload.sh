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
        exit 4
    fi
else
    echo "upload failed, $upload_cmd"
    exit 3
fi

