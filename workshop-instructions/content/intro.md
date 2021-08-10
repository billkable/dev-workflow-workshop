# Intro

Welcome to the *Development Workflow Workshop*.

In this workshop you will see the different building blocks of a modern
application development workflow,
and how principles guide their use.

## What you will learn

By the end of this workshop,
you will be able to:

-   List and describe the principles applicable for implementing your
    new feature.
-   List and describe the practices,
    tools and techniques you used to implement the new feature.
-   List some of the trade-offs and technical debt you might encounter
    in the design of the new feature.

## Problem Domain

It is necessary to set the context for the feature you will implement in
this workshop.

The *domain* is project management.

The application name is *Tracker*.
While it is a fictitious application,
it is loosely based from an early version of the
[*Pivotal Tracker*](https://www.pivotaltracker.com/) product.

The *Tracker* application you will modify already has a release version
`v1` hypothetically deployed in production environment with a feature
for time tracking for users.

You will add a new feature for tracking stories in a backlog.

## House keeping

To run the workshop, you need a modern browser,
with custom shortcut plugins (like `Vimium`) turned off.

You also need a personal [Github](https://github.com) account to
demonstrate an automated Continuous Integration build.

That is it.

The workshop will provide a simulated "local" development environment
that runs on a public cloud that you can access over the internet.

Follow the instructions precisely.
You can use the action links to handle the navigation for you.

### Code Editor

Verify you have the code editor available to you by clicking on the
*quick action* below:

```dashboard:open-dashboard
name: Editor
```

You should see the code editor in the details pane.
This is where you will review the code,
and perform some code edits.

### Terminal

Switch back to the Terminal window:

```dashboard:open-dashboard
name: Terminal
```

This is a Linux terminal with the `bash` shell.

Find out your user name by clicking on the following *quick action*
below:

```terminal:execute
command: whoami
```

These are examples of how you will interact with your terminal and
editors throughout this workshop.
