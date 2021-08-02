In this lesson,
you will restructure and modify the existing *Timesheets* code to reduce
coupling and minimize the chance of integration conflicts going forward.

You will use the *Refactoring* technique.
It is the process of improving the structure of a codebase without
changing its functionality.

The *Refactorings* done in this lesson will set up for the next lesson
where implementing the new *Backlog* feature.

## What you will learn

By the end of this lesson,
you will be able to:

-   Identify two of the software design principles that help keep loose
    coupling and easier maintainability of your code.

-   Demonstrate a *move* and *rename* refactoring.

## Getting started

Make sure you start in the codebase directory:

```terminal:execute-all
command: cd ~/exercises && clear
```

## Prepare to Work on a Local Private Branch

There will multiple steps for you to implement the *Backlog* feature.
You will track each step as a commit in your private branch.
Once you have completed all the work to implement the feature,
you will *curate* the summation of your work into a single commit and
integrate your work to the *trunk* in the last lesson.

1.  Integrate the current *trunk* to you local development workspace:

    ```terminal:execute
    command: git pull origin main -r
    ```

    This will *rebase* any changes in the remote on top of the `main`
    branch in you local workspace.
    This is important,
    as you want your local codebase to be as close to the latest state
    of the remote at any time.

1.  Create a private branch:

    ```terminal:execute
    command: git checkout -b wip-backlog-api
    ```

    This is a *work-in-progress*,
    or temporary branch.
    It must live no longer than it takes to implement the *Backlog*
    feature.

Note:
You are provided solutions to each step in the process,
run the following:

```terminal:execute
command: git log --oneline --all --graph
```

Review the tags associated with each commit in the
`wip-backlog-api-solution` branch.
The commits are ordered bottom to top.

## Refactor-Move

Refactor the *Timesheets* classes as follows:

1.  Create new packages `com.vmware.education.tracker.timesheets` in
    both the `main` and `test` source directory structures.
    You can do this manually by create new folders.
    Some IDE's will have context for Java to explicitly create packages.

    Main:

    ```terminal:execute
    command: mkdir ~/exercises/src/main/java/com/vmware/education/tracker/timesheets
    ```

    Test:

    ```terminal:execute
    command: mkdir ~/exercises/src/test/java/com/vmware/education/tracker/timesheets
    ```

1.  Move the *Timesheets* test and implementation classes to the
    appropriate packages:

    Move implementation classes:

    ```terminal:execute
    command: mv ~/exercises/src/main/java/com/vmware/education/tracker/Timesheet*.java ~/exercises/src/main/java/com/vmware/education/tracker/timesheets/
    ```

    Move Tests:

    ```terminal:execute
    command: mv ~/exercises/src/test/java/com/vmware/education/tracker/*Tests.java ~/exercises/src/test/java/com/vmware/education/tracker/timesheets/
    ```

1.  The `TrackerApplicationIntegration` tests are now really for only
    the `Timesheets` feature.
    Rename the file accordingly:

    ```terminal:execute
    command: mv ~/exercises/src/test/java/com/vmware/education/tracker/timesheets/TrackerApplicationTests.java ~/exercises/src/test/java/com/vmware/education/tracker/timesheets/TimesheetIntegrationTests.java
    ```

    And the name:

    ```terminal:execute
    command: sed -i 's/TrackerApplicationTests/TimesheetIntegrationTests/g' ~/exercises/src/test/java/com/vmware/education/tracker/timesheets/TimesheetIntegrationTests.java
    ```

1.  Because you are doing a manual refactoring using file system
    commands,
    you will encounter `package` compile errors on the files you just
    moved.

    Fix that now for implementation classes:

    ```terminal:execute
    command: sed -i 's/tracker;/tracker.timesheets;/g' ~/exercises/src/main/java/com/vmware/education/tracker/timesheets/Timesheet*.java
    ```

    And for test classes:

    ```terminal:execute
    command: sed -i 's/tracker;/tracker.timesheets;/g' ~/exercises/src/test/java/com/vmware/education/tracker/timesheets/Timesheet*.java
    ```

1.  Run your local build and tests to make sure you did not break the
    code:

    ```terminal:execute
    command: ./gradlew test
    ```

## Limit Timesheets classes to package-private visibility

Next you will limit the Timesheets implementation and test classes
to *package-level visibility*.

That means removing the `public` keyboard at the class and method
levels.
Unfortunately the `Timesheet` class is a JPA *Entity* class,
and the visibility is required to be public.
This is an example of a *Technical Debt* you will have to pay later on.

Change visibility for the remainder of the implementation and test
classes:

1.  `TimesheetController`:

    ```terminal:execute
    command: sed -i 's/public\s//g' ~/exercises/src/main/java/com/vmware/education/tracker/timesheets/TimesheetController.java
    ```

1.  `TimesheetRepository`:

    ```terminal:execute
    command: sed -i 's/public\s//g' ~/exercises/src/main/java/com/vmware/education/tracker/timesheets/TimesheetRepository.java
    ```

1.  `TimesheetControllerTests`:

    ```terminal:execute
    command: sed -i 's/public\s//g' ~/exercises/src/test/java/com/vmware/education/tracker/timesheets/TimesheetControllerTests.java
    ```

1.  `TimesheetIntegrationTests`:

    ```terminal:execute
    command: sed -i 's/public\s//g' ~/exercises/src/test/java/com/vmware/education/tracker/timesheets/TimesheetIntegrationTests.java
    ```

1.  Run your local build and tests to make sure you did not break the
    code:

    ```terminal:execute
    command: ./gradlew clean build
    ```

## If You Get Stuck

If you get stuck on either refactoring,
you can clear your work and fast-forward to the
`backlog-refactor-solution` solution instead:

```terminal:execute
command: |
    git stash --include-untracked
    git stash clear
    git cherry-pick backlog-refactor-solution
```

**Note:**
**If you fast-forward,**
**skip the next section.**

## Create a Private Branch Commit to Save Your Work

Save your work in a private branch,
so that you can come back to it later,
or revert it if you need to when implementing the *Backlog* story.

```terminal:execute
command: |
    git add src
    git commit -m'backlog-refactor'
```

## Wrap

The refactorings are guided by the *Single Responsibility*
and *Open-Closed* principles:

-   The *Tracker* application will be used to run two different
    domain concerns,
    but it is necessary to isolate the *Timesheets* functionality
    separate from the *Backlog* functionality that will be
    introduced after the refactoring.

-   Making the *Timesheet* code package-private will hide
    implementation from other packages,
    making less likely to introduce circular dependencies or
    development integration conflicts.

There are still some potential issues with this code:

-   The JPA Entity `Timesheets` class is still open.
    It might be tempting for developers building related features to
    use database integration that may tightly couple domain classes,
    as well as introduce circular dependency chains that make brittle
    monoliths that may become hard to break apart.

-   The `Timesheets` class is used for three concerns:
    -   *Data transfer object*:
        The API specification *Timesheet* resource maps to the
        *Timesheet* class specification.
    -   *Domain object*:
        The domain specification also maps to the *Timesheet* class
        specification.
    -   *Entity* or *Record object*:
        The relational database storage specification also maps to the
        *Timesheet* class specification.

    The use of the `Timesheets` class in this way breaks the
    *Single Responsibility Principle*.

-   The use of single package per feature works for now,
    but when addressing the above issues,
    it is like single package isolation will not be an option.
    When introducing multiple packages,
    the associated collaborators in separate packages must relax from
    package-private visibility to public.

These are all examples of *tradeoffs* and potential *technical debt* for
making the feature easy to implement.
