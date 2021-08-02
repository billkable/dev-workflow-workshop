Before you start the workshop exercises,
you must be familiar with the git repository structure.

You will also need to decide between running only the local exercises,
or if you want the full experience of integrating with a remote
repository.

If you want to execute all parts of the exercises in the workshops,
you will need a personal
[Github account](https://github.com/).

## Getting Started

Make sure you start in the codebase directory:

```terminal:execute-all
command: cd ~/exercises && clear
```

## Review the Local Git Repository

You are already supplied with a local copy of a git repository that
includes the start point for the workshop.
It also includes solution checkpoints that will be used to fast-forward
through some of the steps,
and also give you a way peek at the solutions if you get stuck.

### The Trunk

Run the following command:

```terminal:execute
command: |
    clear
    git log --oneline
```

This shows you the *trunk* of your codebase which is the `main`
branch in git.

You should see that you have one tagged commit similar to the following:

```git
ae4b986 (HEAD -> main, tag: v0) accelerator-start
```

You can see the commit message is `accelerator-start`,
and it is tagged `v0`.

This is the start point for the next exercise in this workshop.

### Solution Commits

Run the following command:

```terminal:execute
command: |
    clear
    git log --oneline --all --graph
```

This shows you the complete current and "future history" of your
codebase.
You will "fast-forward" through some of it,
as well as implement some of it.

The history should look like this:

```git
* b878539 (backlog-api-solution) [TRACKER-2] implement backlog REST api
| * 9ee2e29 (tag: backlog-delete-solution, wip-backlog-api-solution) backlog-delete
| * eb189ec (tag: backlog-update-not-found-solution) backlog-update-not-found
| * 00d2fde (tag: backlog-update-solution) backlog-update
| * 0c854d5 (tag: backlog-read-not-found-solution) backlog-read-not-found
| * b563fd2 (tag: backlog-read-solution) backlog-read
| * 46fc73b (tag: backlog-create-solution) backlog-create
| * 6fac968 (tag: backlog-refactor-solution) introduce package level visibility for timesheets functionality
|/
* c5a7dc5 (tag: timesheets-api-solution) [TRACKER-1] implement timesheets REST api
* ae4b986 (HEAD -> main, tag: v0) accelerator-start
```

The `wip-backlog-api-solution` branch is a private branch that you
will use to iterate on your work as you implement the solution.

The end state solution is depicted at the top as the
`backlog-api-solution` branch which you will curate from the
`wip-backlog-api-solution` branch,
and integrate that with the `main` branch in the final exercise.

## Setup Your Git Author

Before you commit to a git repository you need to set your git author
user name and email address:

1.  Copy or type the author user name:

    ```workshop:copy-and-edit
    text: git config user.name "<replace with your name>"
    ```

    Paste into a terminal window,
    replace the `<replace with your name>` placeholder with your name
    and hit enter key.

1.  Copy or type the author email address:

    ```workshop:copy-and-edit
    text: git config user.email "<replace with your email>"
    ```

    Paste into a terminal window,
    replace the `<replace with your email>` placeholder with your email
    address and hit enter key.

## Setup Github Repository (Optional)

After setting up a Github account,
you will need to set up a personal access token for authentication,
as well as creation of a remote repository you will use to run
*Continuous Integration* exercises in the workshop.

### Personal Access Token

Follow
[these instructions for setting up a personal access token](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token).

Name the token `tracker-ci`.
After you are done with the workshop,
delete it.

You will need to select both the full `repo` scopes,
and the `workflow` scopes.

Make sure to copy and save your token immediately after generating it
for later when authenticating.
If you dismiss the output page you cannot view the token again,
and would have to delete and regenerate it.

### Set Up Remote Repository

1.  Navigate to the [new repository option](https://github.com/new).

1.  Do *not* select a template.

1.  You can name it whatever you want.

1.  You can choose whatever visibility your want (public or private).

1.  ***Do not initialize the repository** with either README,
    `.gitignore` or license options.
    The local repository is already initialized.

1.  Click on the *Create Repository* button.

1.  In the *Quick setup* box,
    click on the `HTTPS` option.
    To the right you will see the URL for your git repository.
    You will use that in the next step.

### Push the Local Git Repo to Your Remote

Do the following to set up your remote:

1.  Set the remote:

    Copy or type the following,
    while replacing the `<github url from previous step>` placeholder
    with your Github repository url:

    ```workshop:copy-and-edit
    text: git remote add origin <github url from previous step>
    ```

    Run this in either terminal window.

1.  Push the main branch to the remote repository:

    ```terminal:execute
    command: git push origin main
    ```

    You will be prompted for your Github user name and password.

    Copy the personal access token you created in the previous step,
    and past for your password.

1.  Push the v0 tag:

    ```terminal:execute
    command: git push origin refs/tags/v0
    ```

## Wrap

You should be ready to go with your local and (optionally) remote
repositories for the upcoming exercises.
