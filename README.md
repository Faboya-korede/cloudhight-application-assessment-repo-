# Deploy to Production Workflow

This GitHub Actions workflow automates the deployment process to production environment, triggered on pushes to the main branch and pull requests targeting main. The workflow involves building a Docker image, tagging it, and then deploying it to an AWS Auto Scaling Group (ASG) in the production environment.

## Workflow Details

## Triggers

- Push to Main Branch: Whenever changes are pushed to the main branch.
- Pull Request to Main Branch: When pull requests are opened or updated targeting the main branch.

### Jobs
1. Build

- Runs On: Ubuntu Latest
    - Steps:
        - Checkout Repository: Clones the repository into  the runner machine.
        - Login to Docker Hub: Authenticates with Docker Hub using provided credentials stored in GitHub 
        secrets.
        - Build Docker Image: Builds a Docker image tagged as test.
        - Tag Docker Image: Tags the built Docker image with the latest version and pushes it to the Docker Hub repository.

2. Deploy-to-ASG-prod

- Runs On: Ubuntu Latest
    - Dependencies: Depends on the completion of the build job.
    - Steps:
       - Checkout Repository: Clones the repository into the runner machine.
       - Configure AWS Credentials: Sets up AWS credentials required for deploying to AWS.
       - Deploy Launch Template: Initiates a new instance refresh for the Auto Scaling Group (ASG) specified in the secrets, triggering the deployment of the latest Docker image.

### Usage

1. Secrets Setup:
   - Ensure the following secrets are properly configured in your GitHub repository settings:
        - DOCKER_USERNAME: Your Docker Hub username.
        - DOCKER_PASSWORD: Your Docker Hub password or access token.
        - AWS_ACCESS_KEY_ID: AWS access key ID with appropriate permissions.
        - AWS_SECRET_ACCESS_KEY: AWS secret access key corresponding to the access key ID.
        - AWS_REGION: AWS region where the ASG is located.
        - ASG_NAME: Name of the Auto Scaling Group to deploy the new instance.

2. Workflow Integration:
    - Copy the provided workflow YAML into a .github/workflows directory in your repository as deploy-to-production.yml.

3. Run Workflow:
    - Push changes to the main branch or open/modify pull requests targeting main to trigger the workflow.

4. Monitor Deployment:
    - Monitor the workflow runs in the Actions tab of your GitHub repository to ensure successful execution and deployment.

This workflow streamlines the deployment process to production, ensuring seamless updates of your application.
