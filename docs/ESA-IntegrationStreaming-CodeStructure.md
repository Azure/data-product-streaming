# Code Structure

| File/folder                   | Description                                |
| ----------------------------- | ------------------------------------------ |
| `.ado/workflows`              | Folder for ADO workflows. The `dataIntegrationDeployment.yml` workflow shows the steps for an end-to-end deployment of the architecture. |
| `.github/workflows`           | Folder for GitHub workflows. The `dataIntegrationDeployment.yml` workflow shows the steps for an end-to-end deployment of the architecture. |
| `code`                        | Sample password generation script that will be run in the deployment workflow for resources that require a password during the deployment. |
| `docs`                        | Resources for this README.                 |
| `infra`                       | Folder containing all the ARM templates for each of the resources that will be deployed (`deploy.{resource}.json`) together with their parameter files (`params.{resource}.json`). |
| `CODE_OF_CONDUCT.md`          | Microsoft Open Source Code of Conduct.     |
| `LICENSE`                     | The license for the sample.                |
| `README.md`                   | This README file.                          |
| `SECURITY.md`                 | Microsoft Security README.                 |

<div style="text-align: right">  Next: <a href="./ESA-IntegrationStreaming-KnownIssues.md">Known Issues</a> > </div>

< Previous: [Deploy Reference implementation using Azure Devops](./ESA-IntegrationStreaming-DeployUsingAzureDevops.md)\
[Deploy Reference implementation using Github Actions](./ESA-IntegrationStreaming-DeployUsingGithubActions.md)
