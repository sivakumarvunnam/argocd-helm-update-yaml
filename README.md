# argocd-helm-update-yaml

argocd-helm-update-yaml is a github action used to update image tag in helm values file

Action has to be invoked with below parameters

- git_user
- git_password
- image_tag
- app_name
- env
- git_repo
- git_branch

Example
      - name: github action
        uses: actions/checkout@v2
        with:
          repository: sivakumarvunnam/argocd-helm-update-yaml
          path: .github/actions/argocd-helm-update-yaml
          
      - name: Update image tag in helm chart
        uses: ./.github/actions/argocd-helm-update-yaml # Uses an action in the root directory
        id: deployment-update
        with:
          git_user: username
          git_password: password 
          image_tag: tag
          app_name: appName
          environment: dev
          git_repo: sivakumarvunnam/reponame
          git_branch: main
