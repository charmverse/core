# core

## How to handle to merging to main

### If you've tested your downstream changes with core installed via git

As in, your `package.json` file has

```
  "dependencies": {
    "@charmverse/core": "git://github.com/charmverse/core/ref/<branchname>",
```

And your CI is all green, and you're ready to merge both repos. Do the following:

- Merge your custom branches in downstream repos into their perspective main
- Cancel the workflow run on the newly pushed main.
- Merge your branch of core into main.

This way, your code is merged into main without making production changes.
And Core workflow will then kick off the Core package update in downstream repos automatically.
No reinstalling of Core package is necessary.

Find out more about CharmVerse at https://www.charmverse.io
