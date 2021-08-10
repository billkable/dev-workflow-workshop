Before the developer does the work,
the work must be defined,
scoped,
prioritized,
and estimated as a *story*.

The product team maintains a list of stories in a *Backlog*,
and developers will pull the work from it.

In this lesson you will review a new feature story in preparation to
implement it.

## What you will learn

By the end of this lesson,
you will be able to:

-   Identify the characteristics of a properly curated story.

-   Describe two principles that will guide you to identify the specific
    methods or techniques you will use in subsequent lessons to
    implement the *backlog* feature.

-   Describe two methods or techniques you will use in subsequent
    lessons to implement the *backlog* feature.

## Getting started

Make sure you start in the codebase directory:

```terminal:execute-all
command: cd ~/tracker && clear
```

## The Backlog

The
[Backlog](https://www.agilealliance.org/glossary/backlog/#q=~(infinite~false~filters~(postType~(~'page~'post~'aa_book~'aa_event_session~'aa_experience_report~'aa_glossary~'aa_research_paper~'aa_video)~tags~(~'backlog))~searchTerm~'~sort~false~sortDirection~'asc~page~1))
is list of new features,
fixes,
infrastructure changes,
or other activities the application product team needs to implement to
achieve a desired outcome.

Application product teams usually use a tool to maintain and prioritize
the backlog,
such as
[Pivotal Tracker](https://www.pivotaltracker.com/),
[Github Projects](https://docs.github.com/en/issues/organizing-your-work-with-project-boards/managing-project-boards/about-project-boards),
[Atlassian Jira](https://www.atlassian.com/software/jira),
or
[Computer Associates Rally](https://www.broadcom.com/products/software/agile-development/rally-software).

It is beyond the scope of this workshop to interact with these tools,
but you will be provided with the new feature story to implement.

## The Story

The following are the details of the story you will implement in this
workshop:

### Story ID

The story ID is `TRACKER-2`.
The story is the third story implemented,
after the Timesheets feature (`TRACKER-1`),
and the initial accelerator installation (`TRACKER-0`).

### Story Title and Estimation

The title of the story is `Implement backlog REST api`.

Given the feature is a minimal blocking web CRUD application with a
backing relational database,
the solution space is well-known.

The estimate is one story point.

The developers that estimated it are confident the story can be
completed and integrated to the *trunk* in a single day.

### Story Description

The details of the story (specification) are as follows:

As a developer authoring a Single Page Web application,
I need a REST API that represents a Backlog.
The Backlog will have a list of stories.

The REST API specification has basic CRUD operations that manipulate
state of *Story* entities with the following fields:

-   *id* is the resource identifier of the *Timesheet* entity.
-   *projectId* is the resource identifier of the related project.
-   *createDate* is the timestamp when the *Story* entity was created
    or updated.
-   *title* is the title of the story.

The associated CRUD REST API will be implemented as follows:

-   *URI path*:
    `/backlog`

-   *Create*
    -   The request is executed via a `POST` method.
    -   The request includes a body of type `application/json`.
    -   The body includes all fields except for the resource id.
    -   Successful creation results in returned HTTP status CREATED
        (201).

-   *Read*
    -   The request is executed via a `GET` method.
    -   The request includes a single path variable of a *Story*
        resource id.
    -   Successful read (found) results in returned HTTP status OK
        (200).
    -   If resource does not exist,
        return HTTP status NOT FOUND (404).

-   *Update*
    -   The request is executed via a `PUT` method.
    -   Take a single path variable of a *Story* resource id.
    -   The body includes all fields except for the resource id.
    -   If the *Story* associated with the resource id is persisted,
        update it and return the HTTP status NO CONTENT (204).
    -   If resource does not exist,
        return HTTP status NOT FOUND (404).

-   *Delete*
    -   The request is executed via a `DELETE` method.
    -   The request includes a single path variable of a *Story*
        resource id.
    -   Successful deletion results in returned HTTP status NO CONTENT
        (204).

No special handling is required for client or server exceptions,
the default 400 or 500 series exceptions sufficient.

## Assessment of the Story and Codebase

From the description of the story,
there is no overlap or dependency between the *Timesheets* and *Backlog*
functionality.
A developer (or pair of developers) can work on this story with minimal
chance of integration conflicts with other developers that may need to
update the *Timesheets* or other functionality.

But there is a *smell* in the codebase.
The *Tracker Application* and the current *Timesheets* feature is
colocated in the same package.
The new *Backlog* feature is orthogonal to the *Timesheets* feature.
It may be tempting to split into separate applications or
*Microservices*.

But the *Tracker* application domain is not well known at this point.
It makes sense to keep new functionality in this codebase and
the same deployed *Tracker* application.
If there are technical or organizational reasons to split apart,
that can be done later on.

There is another *smell*:
The *Timesheets* implementation classes are currently at a *public*
visibility,
meaning they are *open* to the *Backlog* functionality,
or potentially any new functionality.
This could result in tight coupling and/or circular dependencies in the
code.

The engineering code design decision it so keep a single
Spring Boot Application,
but use package separation to keep *Backlog* separate from
*Timesheets*.
The goal is to reduce coupling and chance of integration
conflicts.

The scoped work will include the following:

-   *Refactor* the existing codebase to better isolate *Timesheets*
    functionality.

-   Implement each of the CRUD operations in the new *Backlog* feature.
    Use the Test-Driven Development practice,
    using the *Red/Green/Refactor* method to implement each operation in
    discrete *feedback loops*.

## Wrap

You have reviewed and assessed the *Backlog* feature story,
and are ready to start the work.
