In this lesson,
you will implement the *Backlog* feature.
You demonstrate use of simulated and actual feedback loops using
*Test Driven Development* practices.

You will also track each feedback loop in a local Git branch so that
you can either go to a previous state of your work if needed,
or if you need to tuck away your work during breaks,
and come back to it later.

## What you will learn

By the end of this lesson,
you will be able to:

-   Demonstrate use of the *Test Driven Development* practice using the
    *Red/Green/Refactor* technique.

-   Demonstrate use of Git private branching to keep track of your local
    work.

## Getting Started

Make sure you start in the codebase directory:

```terminal:execute-all
command: cd ~/exercises && clear
```

## Workflow Explained

You will execute the developers workflow that uses the TDD practice
and the *Red/Green/Refactor* with steps that will look like this:

1.  Write a test.
    Do not write the implementation yet.

1.  Get the test to compile.
    You will write a minimal scaffold of the implementation to satisfy
    the test code compilation.

1.  Run the test.
    Watch it fail.
    This is the *Red* part of the TDD feedback loop.

1.  Supply just enough of the implementation to get the test to pass.
    This is the *Green* part of the TDD feedback loop.

1.  You may implement multiple tests that execute different conditional
    branches within a single class or method.
    You may need to *refactor* the code to support the new condition.
    This is the *Refactor* part of the TDD feedback loop.
    Make sure you run the tests again to make sure you did not break
    existing functionality.

You will run this flow twice:

-   You will author a unit test to build the Java functionality,
    and verify the interaction with the repository.

-   You will author an integration test to properly annotate the Spring
    controller handler methods,
    and verify end-to-end test.

## Fast Forward

You have limited time for this workshop.
You will fast forward to a point that has the following CRUD operations:

- Create
- Read for when story exists
- Read for when a story does not exist
- Update for when a story exists
- Update for when a story does not exist

Run the following commands to pull in all the solution commits for the
associated CRUD operations:

```terminal:execute
command: |
    git cherry-pick backlog-create-solution
    git cherry-pick backlog-read-solution
    git cherry-pick backlog-read-not-found-solution
    git cherry-pick backlog-update-solution
    git cherry-pick backlog-update-not-found-solution
```

## Implement the Delete Operation

### Unit Test

1.  Implement a new unit test for the *Delete* operation:

    ```editor:insert-lines-before-line
    file: ~/exercises/src/test/java/com/vmware/education/tracker/backlog/BacklogControllerTest.java
    line: 154
    text: |4

            @Test
            void testDelete() {
                ResponseEntity<Void> timesheetResponseEntity =
                        controller.delete(1L);

                verify(repository)
                        .deleteById(1L);

                assertThat(timesheetResponseEntity.getStatusCode()).isEqualTo(HttpStatus.NO_CONTENT);
            }
    ```

1.  Run the test to watch it fail (*Red*):

    ```terminal:execute
    command: ./gradlew cleanTest test --tests BacklogControllerTest.testDelete
    ```

    You will see the following compilation exception:

    ```bash
    > Task :compileTestJava FAILED
    /home/eduk8s/exercises/src/test/java/com/vmware/education/tracker/backlog/BacklogControllerTest.java:158: error: cannot find symbol
                    controller.delete(1L);
                            ^
    symbol:   method delete(long)
    location: variable controller of type BacklogController
    1 error

    FAILURE: Build failed with an exception.
    ```

1.  Implement the scaffold for the `BacklogController.delete()` method:

    ```editor:insert-lines-before-line
    file: ~/exercises/src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
    line: 48
    text: |4

            ResponseEntity<Void> delete(long id) {
                return null;
            }
    ```

1.  Run the test to watch it fail (*Red*):

    ```terminal:execute
    command: ./gradlew cleanTest test --tests BacklogControllerTest.testDelete
    ```

    You will see the following compilation exception:

    ```bash
    > Task :test FAILED

    BacklogControllerTest > testDelete() FAILED
        org.mockito.exceptions.verification.WantedButNotInvoked at BacklogControllerTest.java:161

    1 test completed, 1 failed

    FAILURE: Build failed with an exception.
    ```

1.  Implement the `BacklogController.delete()` method:

    Select the current `null` return value:

    ```editor:select-matching-text
    file: ~/exercises/src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
    text: return null;
    ```

    Replace with the implementation:

    ```editor:replace-text-selection
    file: ~/exercises/src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
    text: |
        repository.deleteById(id);
                return noContent().build();
    ```

1.  Run the test to watch it pass (*Green*):

    ```terminal:execute
    command: ./gradlew cleanTest test --tests BacklogControllerTest.testDelete
    ```

### Implement Integration Test

You just completed your unit test.
The unit test verified the *Plain old Java object* or POJO behavior.
But that does not complete your Spring Web Controller.
You need to add the appropriate *handler annotations* to wire it to
Spring.

You will use the *Red/Green* approach to implement the integration test:

1.  Implement a new unit test for the *Delete* operation:

    ```editor:insert-lines-before-line
    file: ~/exercises/src/test/java/com/vmware/education/tracker/backlog/BacklogIntegrationTest.java
    line: 130
    text: |4
            @Test
            void testDelete() {
                Story storyCreated = createStory(
                        new Story(
                                22L,
                                LocalDate.of(2019,11,28),
                                "new story"
                        )
                );

                ResponseEntity<Void> responseEntity =
                        restTemplate.exchange(RequestEntity
                                .delete(URI.create("/backlog/" + storyCreated.getId()))
                                .build(),Void.class);

                assertThat(responseEntity.getStatusCode()).isEqualTo(HttpStatus.NO_CONTENT);

                ResponseEntity<Story> storyResponseEntity =
                        restTemplate.getForEntity("/backlog/" + storyCreated.getId(),
                                Story.class);

                assertThat(storyResponseEntity.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
            }

    ```

1.  Run the test to watch it fail (*Red*):

    ```terminal:execute
    command: ./gradlew cleanTest test --tests BacklogIntegrationTest.testDelete
    ```

1.  Annotate the `BacklogController.delete()` handler method:

    ```editor:insert-lines-before-line
    file: ~/exercises/src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
    line: 49
    text: |4
            @DeleteMapping("{id}")
    ```

1.  Annotate the `BacklogController.delete()` handler path variable
    mapping:

    Select the current handler method:

    ```editor:select-matching-text
    file: ~/exercises/src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
    text: ResponseEntity<Void> delete(long id) {
    ```

    Replace with the implementation:

    ```editor:replace-text-selection
    file: ~/exercises/src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
    text: ResponseEntity<Void> delete(@PathVariable long id) {
    ```

1.  Run the test to watch it succeed (*Green*):

    ```terminal:execute
    command: ./gradlew cleanTest test --tests BacklogIntegrationTest.testDelete
    ```

1.  Run the build to verify you did not break anything with your
    changes:

    ```terminal:execute
    command: ./gradlew clean build
    ```

## If You Get Stuck

If you get stuck on either unit or integration testing,
you can clear your work and fast-forward to the
`backlog-delete-solution` instead:

```terminal:execute
command: |
    git stash --include-untracked
    git stash clear
    git cherry-pick backlog-delete-solution
```

**Note:**
**If you fast-forward,**
**skip the next section.**

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
            modified:   src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
            modified:   src/test/java/com/vmware/education/tracker/backlog/BacklogControllerTest.java
            modified:   src/test/java/com/vmware/education/tracker/backlog/BacklogIntegrationTest.java

    no changes added to commit (use "git add" and/or "git commit -a")
    ```

    You changed two of the tests,
    and the `BacklogController` class.

1.  Stage your work,
    and look at the differences in the files:

    ```terminal:execute
    command: git add src -p
    ```

    You will be presented with the three differences across the files
    you changed.
    Git will prompt you to accept or reject staging each change.

    You will see the differences starting with the `BacklogController`
    file:

    ```bash
    diff --git a/src/main/java/com/vmware/education/tracker/backlog/BacklogController.java b/src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
    index 0aeb2a6..63ee5c7 100644
    --- a/src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
    +++ b/src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
    @@ -45,4 +45,10 @@ class BacklogController {
                return notFound().build();
            }
        }
    +
    +    @DeleteMapping("{id}")
    +    ResponseEntity<Void> delete(@PathVariable long id) {
    +        repository.deleteById(id);
    +        return noContent().build();
    +    }
    }
    (1/1) Stage this hunk [y,n,q,a,d,e,?]?
    ```

    Type the `y` key to stage the differences presented.

    Repeat for the two remaining changes git presents to you.

1.  View the workspace status again:

    ```terminal:execute
    command: git status
    ```

    You will see the changes you staged.
    They are ready to commit.

    ```bash
    On branch wip-backlog-api
    Changes to be committed:
    (use "git restore --staged <file>..." to unstage)
            modified:   src/main/java/com/vmware/education/tracker/backlog/BacklogController.java
            modified:   src/test/java/com/vmware/education/tracker/backlog/BacklogControllerTest.java
            modified:   src/test/java/com/vmware/education/tracker/backlog/BacklogIntegrationTest.java
    ```

1.  Commit your changes locally:

    ```terminal:execute
    command: git commit -m'backlog-delete'
    ```

## Wrap

You just implemented the remaining CRUD operation using the TDD
practice,
including the *Red/Green* approach.

In the next exercise you will curate your work for integration
preparation.
