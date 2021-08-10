In this lesson you will fast-forward to and review the existing
*Timesheets* feature implementation.

*Note:*
The codebase provided is not production hardened and has no user
interface.
There is just enough code to demonstrate a basic developer flow in a
single workshop without overwhelming you with details.

## What you will learn

By the end of this lesson,
you will be able to:

-   Describe two principles that will guide you to identify the specific
    methods or techniques you will use in subsequent lessons to
    implement the *backlog* feature.

-   Describe two methods or techniques you will use in subsequent
    lessons to implement the *backlog* feature.

## Getting started

You will need to simulate releasing `v1` of the codebase with the
*Timesheets* functionality.

1.  Make sure you start in the codebase directory:

    ```terminal:execute-all
    command: cd ~/tracker && clear
    ```

1.  Fast-forward the codebase:

    ```terminal:execute
    command: git cherry-pick timesheets-api-solution
    ```

    and tag it as `v1`:

    ```terminal:execute
    command: git tag v1
    ```

1.  Push it to your remote
    (if you chose to use your Github account for remote and CI pipeline):

    ```terminal:execute
    command: git push origin main
    ```

    and the associated tag:

    ```terminal:execute
    command: git push origin refs/tags/v1
    ```

1.  Navigate to your Github actions web page and watch for successful
    automated build.

## Review the tracker project

1.  Take a look at the project build file:

    ```editor:open-file
    file: ~/tracker/build.gradle
    ```

    You can see that the project uses spring boot,
    and you can see the current project version is
    `v1`:

    ```editor:select-matching-text
    file: ~/tracker/build.gradle
    text: v1
    ```

## Review the Timesheets Tests and Specifications

*Test Driven Development* practice is used not only for testing,
but also specifying the design during development.

Each test has three major sections with it:

1.  Prepare for the test,
    including set up of test data,
    and/or training of *mock objects*.

1.  Execute the implementation with the test data from the *test setup*.

1.  Assert the implementation is correct according to specification.

This workshop covers two types of tests:

- Unit tests
- Integration tests

### Unit Tests

Review the `TimesheetControllerTest` class:

```editor:open-file
file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
```

This class contains the *unit tests*.
It does not test the full integration with the web protocol and
database.
It using *Mocking* to provide fake implementations of the repository,
and *trains* them as part of the test preparation.

Take a look at some of the highlights of this class:

1.  Common unit tests setup:

    ```editor:select-matching-text
    file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
    text: "public void setUp()"
    before: 1
    after: 3
    ```

    -   The common set up is executed before every unit test in this
        class:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
        text: "@BeforeEach"
        ```

    -   The repository is a *Mock*.

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
        text: "repository = mock(TimesheetRepository.class)"
        ```

    -   Only Java is used to instantiate the collaborating
        controller:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
        text: "controller = new TimesheetController(repository)"
        ```

1.  In the `testCreateTimesheet()` unit test:

    -   The test setup phase:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
        text: "Timesheet timesheetToCreate ="
        before: 0
        after: 15
        ```

        The training of the repository *Mock* happens here:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
        text: "doReturn(timesheetSaved)"
        before: 0
        after: 2
        ```

    -   The `controller.create()` method under test:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
        text: "ResponseEntity<Timesheet> timesheetResponseEntity ="
        before: 0
        after: 1
        ```

    -   The test assertions:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
        text: "verify(repository)"
        before: 0
        after: 4
        ```

        Where the *Mock* execution assertion that specified the
        controller-repository collaboration specification:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
        text: "verify(repository)"
        before: 0
        after: 1
        ```

        and the remaining assertions:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
        text: "assertThat(timesheetResponseEntity.getStatusCode()).isEqualTo(HttpStatus.CREATED);"
        before: 0
        after: 1
        ```

You will see the remainder of the unit tests follow a similar pattern as
`testCreateTimesheet()`.

### Integration Tests

Review the `TrackerApplicationTests` class:

```editor:open-file
file: ~/tracker/src/test/java/com/vmware/education/tracker/TrackerApplicationTests.java
```

This class contains the *integration tests*.
It verifies the full full integration with the web protocol and
database using the `TestRestTemplate` as an HTTP client.

1.  The tests use `SpringBootTest` to bootstrap a Spring Web server and
    testing container within the same process:

    ```editor:select-matching-text
    file: ~/tracker/src/test/java/com/vmware/education/tracker/TrackerApplicationTests.java
    text: "@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)"
    ```

    The web server is started on a random port:

    ```editor:select-matching-text
    file: ~/tracker/src/test/java/com/vmware/education/tracker/TrackerApplicationTests.java
    text: "RANDOM_PORT"
    ```

    that the `TestRestTemplate` HTTP client will automatically be wired
    to:

    ```editor:select-matching-text
    file: ~/tracker/src/test/java/com/vmware/education/tracker/TrackerApplicationTests.java
    text: "private TestRestTemplate restTemplate"
    before: 1
    after: 0
    ```

1.  In the `testCreateTimesheet()` integration test:

    -   The test setup:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TrackerApplicationTests.java
        text: "Timesheet timesheetToCreate ="
        before: 0
        after: 4
        ```

        is merely setting up the `Timesheet` object for creation.

    -   The REST API under test:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TrackerApplicationTests.java
        text: "ResponseEntity<Timesheet> timesheetResponseEntity ="
        before: 0
        after: 2
        ```

    -   The assertion section:

        ```editor:select-matching-text
        file: ~/tracker/src/test/java/com/vmware/education/tracker/TrackerApplicationTests.java
        text: "assertThat(timesheetResponseEntity.getStatusCode()).isEqualTo(HttpStatus.CREATED)"
        before: 0
        after: 9
        ```

You will see the remainder of the unit tests follow a similar pattern as
`testCreateTimesheet()`.

## Review the Timesheets Implementation

### Timesheet class

Review the `Timesheet` class:

```editor:open-file
file: ~/tracker/src/main/java/com/vmware/education/tracker/Timesheet.java
```

1.  It is a data class.
    It has no behavior,
    only fields:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/Timesheet.java
    text: "private long id;"
    before: 0
    after: 4
    ```

    Notice that the fields are not marked as `final`.
    The `Timesheet` objects are *mutable*.

1.  It is a JPA *Entity*:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/Timesheet.java
    text: "@Entity"
    ```

    You can see it models a table named `TIMESHEET`:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/Timesheet.java
    text: "public class Timesheet"
    ```

    with a numeric primary key of name `ID`:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/Timesheet.java
    text: "private long id;"
    before: 1
    after: 0
    ```

1.  The `Timesheet` class is also used for *marshalling* data from an
    HTTP web request to the `TimesheetController` *handler methods*.

    The HTTP content and accept types of the web requests are
    `application/json`.
    Spring Web by default will use the `jackson` parser,
    which requires a default constructor on the associated data classes:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/Timesheet.java
    text: "public Timesheet()"
    ```

    Also notice the other two constructors:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/Timesheet.java
    text: "public Timesheet(long projectId, long userId, LocalDate date, int hours)"
    before: 0
    after: 13
    ```

    This is an indicator that the `Timesheet` class may be used for
    different reasons.

Given that the Timesheet class is used for multiple reasons,
and that it is mutable can introduce problems as the application evolves.

You will see more discussion later on the topic of design issues later
in the workshop.

### TimesheetController class

Review the `TimesheetController` class:

```editor:open-file
file: ~/tracker/src/main/java/com/vmware/education/tracker/TimesheetController.java
```

Notice the controller is a minimal Java class.
You do not see any plumbing that handles the web request,
including parsing of data,
or routing.

The annotations provide instructions to Spring,
such that Spring will build the plumbing to route the specific
URL requests to the appropriate controller *handler method*.

1.  Wiring the `TimesheetController` class to the Spring provided web
    server:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/TimesheetController.java
    text: "@RestController"
    before: 0
    after: 1
    ```

    When the Spring application starts up,
    it will process the `@RestController` and `@RequestMapping`
    annotations to set up the wiring from the Spring supplied web
    server such that it will route requests originating from the
    `/timesheets` path to *handler methods* within this class.

1.  Wiring the *create handler method*:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/TimesheetController.java
    text: "@PostMapping"
    before: 0
    after: 1
    ```

    The `@PostMapping` annotation is a specialization of a
    `@RequestMapping` annotation.
    It tells Spring during the application startup to set up routing of
    any `POST` requests to the `/timesheets` endpoint to execute on the
    `create()` handler method.

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/TimesheetController.java
    text: "@RequestBody Timesheet timesheetToCreate"
    ```

    The `@RequestBody` annotation tells Spring to set up the
    *marshalling* of the timesheet request data coming from the `POST`
    request,
    and convert it to a `Timesheet` object.

1.  The return `ResponseEntity<Timesheet>` types tell Spring that
    the type in the *response body* of will be `Timesheet`.

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/TimesheetController.java
    text: "ResponseEntity<Timesheet>"
    ```

1.  It is subtle but important to note that the create and update
    handler method `Timesheet` arguments are different conceptual types
    than than those passed back in the response bodies.

    Looking at the unit test will show the difference:

    ```editor:select-matching-text
    file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
    text: "Timesheet timesheetToCreate ="
    before: 0
    after: 15
    ```

    Notice the `timesheetToCreate` object is set up with the constructor
    *without* an id.
    This is an example of a *Value Object*,
    or a collection of arbitrary data that will be passed to the
    repository for saving to a record in a database.

    ```editor:select-matching-text
    file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
    text: "Timesheet timesheetToCreate ="
    before: 0
    after: 4
    ```

    The `timesheetSaved` object reflects a persisted record or *Entity*
    in a database,
    which has a primary key of `id`,
    that maps to a timesheet resource.

   ```editor:select-matching-text
    file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
    text: "Timesheet timesheetToSave ="
    before: 0
    after: 5
    ```

    The repository takes the *Value Object* as the argument,
    and returns the *Record* or *Entity*.

    ```editor:select-matching-text
    file: ~/tracker/src/test/java/com/vmware/education/tracker/TimesheetControllerTests.java
    text: "doReturn(timesheetSaved)"
    before: 0
    after: 2
    ```

    This is an example where the `Timesheet` class is used for multiple
    purposes,
    which breaks the *Single Responsibility Principle*,
    and is *technical debt*.

    The developers that authored the code made a concious decision to
    break it here for the ability to move fast with a minimal codebase.
    But as the code evolves,
    the developers will need to improve the design by introducing
    multiple data classes to represent the `Timesheet` REST data and
    the database representation separately.

    You will see more discussion on the topic in the next exercise.

1.  Handling REST resource identifiers in requests:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/TimesheetController.java
    text: "/{id}"
    ```

    After REST resources are created,
    they must be referenced as *resources*.

    The design of the *Timesheets* resource includes use of a numeric
    identifier,
    which is the `Timesheet` class `id` field.

    Spring has to know how to extract the resource id from the request.
    It does so by specifying a *predicate* in the `@RequestMapping`
    annotations preceding each handler method.

    The handler method arguments must also be annotated to tell Spring
    how to set up the mapping of the URL predicate to the associated
    argument.
    It does so by use of the `@PathVariable` annotation:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/TimesheetController.java
    text: "@PathVariable"
    ```

### TimesheetRepository interface

Review the `TimesheetRepository` interface:

```editor:open-file
file: ~/tracker/src/main/java/com/vmware/education/tracker/TimesheetRepository.java
```

Notice that there is no implementation class that generates the SQL
for interaction with the database.
*Spring Data JPA* provides all the plumbing to hide the details of
database interaction:

1.  CRUD application:

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/TimesheetRepository.java
    text: "CrudRepository"
    ```

1.  The CRUD application is for a `Timesheets` entity with a primary key
    of type `Long`;

    ```editor:select-matching-text
    file: ~/tracker/src/main/java/com/vmware/education/tracker/TimesheetRepository.java
    text: "<Timesheet, Long>"
    ```

In this workshop,
the database runs locally,
and you will not have to configure the database coordinates or
credentials.

## Test and Build Locally

Test and build it it locally:

```terminal:execute
command: ./gradlew clean build
```

## Wrap

You should now have an idea about the construction of a minimal Spring
Boot Web Application backed by a relational database.

You can use the same testing and implementation patterns when adding
a new REST API.
