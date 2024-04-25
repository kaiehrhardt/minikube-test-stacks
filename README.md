# minikube-test-stacks

A collection of multiple stacks to test new features or try out the technology.

## requirements

- terramate
- terraform

## available modules

- minikube local docker bootstrap (to get a local cluster)

## available stacks

- gitlab
  - `terramate script run deploy gitlab`
  - `terramate script run destroy gitlab`
- gitlab.com runner
  - `terramate script run deploy runner`
  - `terramate script run destroy runner`
<!-- - tekton
  - gitlab webhook / eventlistener usecase -->


