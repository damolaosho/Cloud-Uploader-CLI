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
     
4. it will prompt for your `ACCESS_KEY_ID`, `ACCESS_SECRET_KEY`, `password` and `default-output`
5. once this is done, you can test the aws connection by running a simple command, such as:
   ````
   aws s3 ls
   ````
   this will list all s3 buckets associated with your aws iam account. 


