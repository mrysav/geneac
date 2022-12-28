---
layout: default
title: Quickstart
nav_order: 1
parent: Development
---

Although you can run all of the components for Geneac natively, by far the easiest
way to get up and running to make a change is to leverage [Visual Studio Code devcontainers](https://code.visualstudio.com/docs/remote/containers). As long as you have Visual Studio Code and Docker Desktop (or, on Linux, just Docker) installed, you can open the Geneac repository as a container and the setup flow will be triggered.

After the container is set up, you can run:

```bash
# using foreman
foreman start

# or using overmind, which does fancy tmux stuff
overmind start
```

and then visit http://localhost:5000/ and log in with the test credentials that the setup procedure prints.

An alternative to having all of this done locally is to use [GitHub Codespaces](https://github.com/features/codespaces). This is a browser-based way to create a developer environment using the devcontainer setup described above. If you don't like the idea of using a browser, you can also use VS Code natively to connect to your codespace. Keep in mind though, this is not free.

## Updating the documentation

The documentation is generated with [just-the-docs](https://just-the-docs.github.io/just-the-docs/). If you are using the devcontainer, these are installed automatically for you. You can start a development server with:

```bash
cd docs/ ; bundle exec jekyll serve
```
