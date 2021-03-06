# Developer Daily Workflow Workshop Repo

This is a workshop for developers new to modern application
development practices.

In this workshop you will demonstrate the main building blocks of
a modern developers daily workflow.

This README is for the workshop maintainers.


## Requirements

* [Docker Desktop](https://www.docker.com/get-started)
* [Kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl) version `1.21` or greater
* [Kind](https://kind.sigs.k8s.io/)

## Commands
### Build and Run Locally

```
make
```

## Rebuild, and redeploy the workshop and training portal with changes

```
make reload
```

## Refresh the content in existing deployment

```
make refresh
```

After running the refresh, run `update-workshop` in your workshop terminal
window and refresh the browser. The educates documentation has more details on
[live updates to content](https://docs.edukates.io/en/latest/workshop-content/working-on-content.html#live-updates-to-the-content)
as well.

### Stop an existing educates cluster

```
make stop
```

## Start a previously stopped educates cluster

```
make start
```

## Delete local educates cluster

```
make delete
```

## Delete local educates cluster and local registry

```
make clean
```

## Resources

* [Educates](https://docs.edukates.io/)