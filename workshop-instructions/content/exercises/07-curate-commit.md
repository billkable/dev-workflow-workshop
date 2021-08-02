Up to now,
You have implemented the *Backlog* feature.

But you need to integrate your work to the *trunk*.
And before you integrate your work,
you need a single commit that will be concise and well documented such
that developers maintaining the code will be able to understand the
commit,
and be able to track it to its originating story.

## What you will learn

By the end of this lesson,
you will be able to:

-   Demonstrate how to build a curated commit that encapsulates your
    local work.

## Getting Started

1.  Make sure you start in the codebase directory:

    ```terminal:execute-all
    command: cd ~/exercises && clear
    ```

## Upgrade the version

Promote your work to version `v2` in your `build.gradle` file:

1.  Select the existing `v1` version:

    ```editor:select-matching-text
    file: ~/exercises/build.gradle
    text: v1
    ```

1.  Replace it with `v2`:

    ```editor:replace-text-selection
    file: ~/exercises/build.gradle
    text: v2
    ```

## Save Your Work

Now that you have completed,
save your work to your private branch:

1.  View the files changed:

    ```terminal:execute
    command: git status
    ```

    You should see the following:

    ```bash
    On branch wip-backlog-api
    Changes not staged for commit:
    (use "git add <file>..." to update what will be committed)
    (use "git restore <file>..." to discard changes in working directory)
            modified:   build.gradle

    no changes added to commit (use "git add" and/or "git commit -a")
    ```

1.  Stage your work,
    and look at the differences in the files:

    ```terminal:execute
    command: git add build.gradle -p
    ```

    You will be presented with the single difference in the
    `build.gradle` file.
    Git will prompt you to accept or reject staging the change.

    ```bash
    diff --git a/build.gradle b/build.gradle
    index 10131f0..e28817c 100644
    --- a/build.gradle
    +++ b/build.gradle
    @@ -6,7 +6,7 @@ plugins {
    }

    group = 'io.pivotal.education'
    -version = 'v1'
    +version = 'v2'
    sourceCompatibility = '11'

    repositories {
    (1/1) Stage this hunk [y,n,q,a,d,e,?]?
    ```

    Type the `y` key to stage the difference presented.

1.  View the workspace status again:

    ```terminal:execute
    command: git status
    ```

    You will see the change you staged.
    It is ready to commit.

    ```bash
    On branch wip-backlog-api
    Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
            modified:   build.gradle
    ```

1.  Commit your changes locally:

    ```terminal:execute
    command: git commit -m'backlog-promote-version'
    ```

## Verify Local Commits

1.  Verify your local commits:

    ```terminal:execute
    command: |
        clear
        git log --oneline
    ```

1.  You will see a history similar to this,
    with eight commits since the *Timesheets* `v1` commit:

    ```bash
    046c040 (HEAD -> wip-backlog-api) backlog-promote-version
    adaf23d backlog-delete
    39e8a3e backlog-update-not-found
    87481a6 backlog-update
    731eaa7 backlog-read-not-found
    49aeb65 backlog-read
    8808201 backlog-create
    1c654a3 backlog-refactor
    191f089 (tag: v1, main) [TRACKER-1] implement timesheets REST api
    535e845 (tag: v0) accelerator-start
    ```

## Git Rebase Feature

You will use the Git Rebase feature to *squash* your local commits into
a single commit that reflects the aggregate work of the *Backlog* story.

1.  Initiate the Git Rebase command from `v1` Timesheets feature:

    ```terminal:execute
    command: git rebase -i v1
    ```

    Git will put you into an interactive session using the *vi* editor.

    You will see the first eight lines in the *vi* editor:

    ```bash
    pick 1c654a3 backlog-refactor
    pick 8808201 backlog-create
    pick 49aeb65 backlog-read
    pick 731eaa7 backlog-read-not-found
    pick 87481a6 backlog-update
    pick 39e8a3e backlog-update-not-found
    pick adaf23d backlog-delete
    pick 046c040 backlog-promote-version
    ```

1.  Type the `:` key to put you into command mode.

    Copy and paste the following into the `vi` editor,
    followed by the `RETURN` key:

    ```workshop:copy
    text: 1s/pick/reword
    ```

    This will set the first commit to revise (reword) the commit message.

1.  Type the `:` key to put you into command mode again.

    Copy and paste the following into the `vi` editor,
    followed by the `RETURN` key:

    ```workshop:copy
    text: 2,8s/pick/fixup
    ```

    This will revise the second to eighth commits for *fixup*,
    or to squash the commits to the first without saving commit message
    history.

1.  Type the `:` key to put you into command mode again,
    and type `wq`
    followed by the `RETURN` key.

    Git will stop at the first commit for you to revise the commit
    message:

    ```bash
    backlog-refactor
    ```

1.  Hit the `d` key twice to delete the line,
    then hit the `i` key once to insert the new commit line.

1.  Copy the following the *curated* commit message including the story
    number,
    and paste into the vi editor,
    and hit the `ESC` key:

    ```workshop:copy
    text: "[TRACKER-2] implement backlog REST api"
    ```

1.  Type the `:` key to put you into command mode again,
    and type `wq`
    followed by the `RETURN` key.

    This will complete the rebase.

## Verify your Curated Commit

Run the following command again:

```terminal:execute
command: |
    clear
    git log --oneline
```

You will see only a single commit since the *Timesheets* `v1` commit:

```bash
ab98b99 (HEAD -> wip-backlog-api) [TRACKER-2] implement backlog REST api
1f59f91 (tag: v1, origin/main, main) [TRACKER-1] implement timesheets REST api
ae4b986 (tag: v0) accelerator-start
```

## Wrap

You have *curated* your work into a single commit that you will
integrate into the trunk in the next exercise.

Notice the single commit is well documented,
concise,
and will be easy for other developers to understand and track your
work against the originating story.
