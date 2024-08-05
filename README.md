# Cloud-Uploader-CLI
a bash-based CLI tool that allows users to quickly upload files to a specified cloud storage solution, providing a seamless upload experience similar to popular storage services.


## PREREQUISITES

### 1. GITHUB REPO
- Create a github repo.
-  clone the repo to your local machine.
-  open your machine terminal and cd into the repo you cloned.

### 2. AWS ACCOUNT SIGN UP / LOGIN / AWS CLI
  - open an aws account if you do not have one, if you do sign in
  - download the AWS CLI, follow the steps in the AWS docs, depending on the OS of your local machine.

**Now that prerequisites have been met, the following tasks will be accomplished to successfully create a clouduploader CLI**

### IAM SETUP
1. Login to your AWS console.
2. search for IAM service and create an IAM role e.g 'cloud-uploader'.
3. attach policies to the 'cloud-uploader' user, using the principle of least privilege.
4. while in the IAM user page, create an access key for the 'cloud-uploader' and download the credentials.

### TERMINAL SETUP

1. cd into the repo you cloned.
2. run the following in your terminal.
   
````
aws configure
````
     
4. it will prompt for your `ACCESS_KEY_ID`, `ACCESS_SECRET_KEY`,`REGION`, `password` and `default-output`
5. once this is done, you can test the aws connection by running a simple command, such as:

   ````
   aws s3 ls
   ````
   
   this will list all s3 buckets associated with your aws iam account.

6. then export your all prompts so it will remain availabe till end of session


7. then create your aws s3 bucket

   ````
   aws s3 mb s3://[UNIQUE_BUCKET_NAME] --region [YOUR_REGION USED IN THE ACCESS KEY PROMPT]
   ````
### SHELL SCRIPT

1. open your preferred code editor and type in the following code

   ````
   #!/usr/bin/env zsh


if [ -f "./upload-cv.docx" ]; then

    echo "file found, upload starting"
else

    echo "404!!! file not found. please check if file is in the same directory"
    exit 2
fi 



upload_cmd=$(pv ./upload-cv.docx | aws s3 cp "./upload-cv.docx" "s3://cloud-upload-bucket-03082024/" 2>&1)
upload_status=$?



if [ $upload_status -eq 0 ]; then
    echo "file upload successful"


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
````
2. to run this script, return to your terminal specify path/to/script/nameofscript.sh
