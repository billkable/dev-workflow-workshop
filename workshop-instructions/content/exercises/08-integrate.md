Up to now,
You have implemented the *Backlog* feature,
and prepared a single commit that is fit to integrate with the *trunk*.

But you need to integrate your work to the *trunk*.

## What you will learn

By the end of this lesson,
you will be able to:

- Demonstrate how to integrated a curated commit to the *trunk*.

## Getting Started

1.  Make sure you start in the codebase directory:

    ```terminal:execute-all
    command: cd ~/exercises && clear
    ```

1.  Verify your local commits:

    ```terminal:execute
    command: git log --oneline
    ```

    You will see a history similar to this,
    with a single commit since the *Timesheets* `v1` commit:

    ```bash
    ab98b99 (HEAD -> wip-backlog-api) [TRACKER-2] implement backlog REST api
    1f59f91 (tag: v1, origin/main, main) [TRACKER-1] implement timesheets REST api
    ae4b986 (tag: v0) accelerator-start
    ```

    You will notice that you are still on the WIP branch you created at
    the beginning of your work.

    You will need to integrated to the *trunk*,
    which is the `main` branch in Git.

## Integrate the Trunk Locally

Before you merge and push your WIP branch to the `main` branch,
you need to pull any changes on the remote down to your workspace first:

1.  Checkout to `main` branch:

    ```terminal:execute
    command: git checkout main
    ```

1.  Merge any changes on `main` to your local `main` branch:

    ```terminal:execute
    command: git pull origin main -r
    ```

    You will see a message similar to this:

    ```bash
    From https://github.com/<your git user>/<your git repo>
    * branch            main       -> FETCH_HEAD
    Already up to date.
    Current branch main is up to date.
    ```

1.  Merge your WIP branch to your local `main` branch:

    ```terminal:execute
    command: git rebase wip-backlog-api
    ```

1.  Check out your Git log:

    ```terminal:execute
    command: |
        clear
        git log --oneline
    ```

    You will notice that main and wip-backlog-api are converged and
    at the same commit:

    ```bash
    * fdacc6e (HEAD -> main, wip-backlog-api) [TRACKER-2] implement backlog REST api
    ```

1.  Notice that you did not get merge conflicts during this exercise.
    That is because this is your personal Github repository without
    others working on it.

    On real projects you may encounter merge conflicts.

    One reason why you refactored for package isolation is to reduce
    the chance of merge conflicts across the *Backlog* and *Timesheets*
    features.

## Clean Up and Tagging

1.  You no longer need the WIP branch,
    delete it:

    ```terminal:execute
    command: git branch -D wip-backlog-api
    ```

1.  Tag the *Backlog* feature commit as `v2`:

    ```terminal:execute
    command: git tag v2
    ```

## Integrate to Trunk and Verify

1.  Integrate to the remote `main` branch:

    ```terminal:execute
    command: git push origin main
    ```

    ```terminal:execute
    command: git push origin refs/tags/v2
    ```

    Note:
    You manually generated `v2` version in this exercise.
    In real projects your automation pipelines will do that for you.

1.  Navigate to Github Actions for your Tracker repository.
    Watch for its successful completion.

## Wrap

You successfully integrated a curated commit into the trunk,
or the remote Git `main` branch.
