# Contributor's Guide

This project very much welcomes community contributions to this repository. Whether those are [Issue Reports](#issue-reports) or [Pull Requests](#pull-requests), any form of contribution is very much welome. Please note that by participating in this project, you agree to abide by the [Code of Conduct](/CODE_OF_CONDUCT.md), as well as the terms of the [CLA](#cla).

> If you have a question, think you have discovered an issue or would like to propose a new feature or idea, then find/file an issue report **BEFORE** starting work to fix/implement it.

## Open Development Workflow

The Customer Architecture Team (CAT) is very active in this GitHub repository and carries out all the development work in the public. New issues, ideas or feature requests are filed in the repo and fixes and new implementations are implemented through pull requests that are linked to these issues. Code reviews can be followed as well to learn about the principles of the team and the development work.

All the work of the CAT team is executed in the public to ensure a high degree of transparency for the community. In addition, it allows the community to more easily contribute to the projects because everyone is aware of new features that are commited or issues that are existing within the projects.

Working in the public also ensures a high-quality bar and allows open discussions about the why and how of new developments.

## Issue Reports

We are encouraging you to select between a [Bug Report](#bug-report), a [Feature Request](#feature-request), a [Documentation Issue](#documentation-issue) and a [Vulnerability Report](#vulnerability-report) when opening a new Issue in this repository. Please provide all the required information for the respective issue reports and make sure you accept the [Code of Conduct](/CODE_OF_CONDUCT.md).

Before submitting any of the types mentioned above, please search through the open and closed issues in this repository as well as through the [Known Issues](/docs/EnterpriseScaleAnalytics-KnownIssues.md). If a similar issue already exists, please upvote the existint issue comment(s) or leave a comment instead of opening a new issue. This helps us reduce the number issues and also simplifies the management on our side. Only if no existing item describes your issue report we encourage you to file a new one.

### Bug Report

Submit new bug reports using the "Bug Report" issue template. When submitting a bug report, try to be as specific as possible by including a detailed description of how to reproduce the issue and also share error messages and screenshots if possible. This helps us throubleshoot the bug and apply fixes more quickly.

### Feature Request

New feature requests and ideas should be submitted using the "Feature Request & Ideas" issue template. Please be specific about the "What?" and "Why?" by being specific about what the feature entails and what the benefits of including this feature will be.

### Documentation Issue

Documentation issues should be submitted using the "Documentation Issue" issue template. Please be specific about what document needs to be updated and why.

### Vulnerability Report

Please read through the [security policy](/SECURITY.md) before submitting a vulnerability report. After reading through the guidelines, you can use the "Microsoft Security Response Center" to submit a new vulnerability.

## Pull Requests

We encourage users to not only submit issues but also start contributing to the repository by opening pull requests to fix issues that were submitted previously. Please always submit an issue before opening a pull request to make the team aware of the requested change and to be able to discuss the possible implications of changes. Some issues or features may be quick and simple to describe and understand others may require a spec definiion to agree on changes.

### Getting Started

Before starting to develop, you should fork this repo (see [this forking guide](https://guides.github.com/activities/forking/) for more information). Next, you should checkout the repo locally with `git clone git@github.com:{your_username}/{repo_name}.git`.

### Tooling

To help you contribute to the project more easily, you can find a [development container definition](/.devcontainer) in the `.devcontainer` folder of this repository. The development container has all the necessary tools and VS Code extensions enabled to provide you a curated development environment in which you can start developing without requiring you to install VS Code extensions on your local machine. Dev containers can be used via the [VS Code Remote - Containers](https://aka.ms/vscode-remote/download/containers) extension or [GitHub Codespaces](https://github.com/features/codespaces).

If you would like to work inside your local environment, you should install the following tools locally:

- PowerShell Core
- Azure CLI
- Git
- VS Code

In addition, we recommend you to install the following VS Code extensions:

- Azure Account
- Azure CLI Tools
- Azure Resource Manager (ARM) Tools
- Bicep
- PowerShell`

### Development

When working on the Infrastructure as Code (IaC) definitions in this repository, please be aware that you must always change the bicep code. The ARM templates, which you can also find i this repository, are just auto generated by building the Bicep definitions.

Therefore, you should follow the following development cycle:

1. Make changes to the Bicep code.
2. Build the new Bicep project by running `az bicep build -f main.bicep`.
3. Commit all files to your branch.
4. Submit your pull request.

### Pull Request Information

Before opening a pull request, ensure that an issue has been created to track the feature enhancement or bug that is being fixed. In the PR description, make sure you are linking the issue that this PR is about to close. To avoid multiple contributors working on the same issue, please add a comment to the issue that your are planning to work on.

If the pull request is still work in progress, please open the pull request in draft mode.

### Testing

Testing is a key component in the development workflow. We run automated tests on all pull requests to enforce strict linting rules and also make sure that changes introduced to the IaC are not introducing code degredation.

### Code Review

If you want the team to review the changes, mark the pull request as "Ready for review". The team will get back to you and approve the PR, provide comments or request changes if necessary. The review process may take a few cycles in order to ensure that all content is of high quality and well structured.

### Merge

After the pull request has been reviewed and approved, the feature branch will be merged into the main branch and automatically closed and deleted.

## CLA

This project welcomes contributions and suggestions. Most contributions require you to agree to a Contributor License Agreement (CLA) declaring that you have the right to, and actually do, grant us the rights to use your contribution. For details, visit <https://cla.opensource.microsoft.com>.

When you submit a pull request, a CLA bot will automatically determine whether you need to provide a CLA and decorate the PR appropriately (e.g., status check, comment). Simply follow the instructions provided by the bot. You will only need to do this once across all repositories using our CLA.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/). For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.
