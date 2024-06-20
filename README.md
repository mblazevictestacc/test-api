# Hello World Api

This is Hello world api with /hello route deployed to Azure Container Apps and developed with Go language and Fiber web framework.


## Layout

* `.github/workflows`
    * `cicd.yml` - this is where we define steps for building image and deploying infrastructure by using Github Actions
* `app/`
    * `src`
        * `main.go` - Go application
    * `Dockerfile`
* `infrastructure/`
    * `main.tf`
    * `variables.tf`
    * `outputs.tf`


## Deploying

We have cicd set up. You just need to open pull request and merge to main branch.