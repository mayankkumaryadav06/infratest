#Set up Gitlab
Set up envrionment variable in Settings->CI/CD:
   
    a) AWS_ACCESS_KEY_ID
    b) AWS_SECRET_ACCESS_KEY

#Deployment   
1. Once the code is pushed, pipeline will be triggered automatically.

2. Stages of pipeline:
    1. **packer validate**: To check if syntax for packer is correct.
    2. **packer build**: To build the ami containing the latest code and set up build at the right folder.
    3. **terraform fmt**: To lint the terraform code. (Failure is allowed for this but should be fixed promptly)
    4. **terraform validate**: To validate the terraform code.
    5. **terraform build**: To show the changes that will be applied to infrastructure
    5. **terraform deploy**: To deploy the infrastructure changes.
    6. **application check**: To make a quick curl request to check if application is up and running.

#To-Do

###Future changes:

    1. To make stage terraform deploy as manual only or need approval to deploy.
    2. Set up environment variable as prod, dev, uat based on the branch. (For ex: main branch should be deployed to prod, develop to uat)
    3. Make resource name for insfrastructe as unique for ex, launch-configuration, autoscaling groups. Either use random_pet module or use git short sha as suffix.
    4. Set up route53 to curl from outside the internal network and user friendly name.
    5. Describe terraform variable correctly. 

    