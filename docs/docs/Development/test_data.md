# Creating Test Data

While developing locally, you might want to seed the database with a bunch of data
so you can test various pages without having to create data yourself.

You can use these rake tasks to generate a lot of realistic-looking data to test with.

## `generate:test:accounts`

Creates 2 test user accounts. You can find the credentials [in the source of the task itself](https://github.com/mrysav/geneac/blob/fa75ad9715f75424ab36fe24505a49eae9f0a7d2/lib/tasks/generate_test.rake#L13-L14).

Running this task more than once will **not** create more accounts.

## `generate:test:people`

Generates 100 people and adds various relationships between them to create large groups of families.

## `generate:test:photos`

Generates 20 photos and tags them with random text tags and people from the database.

## `generate:test:notes`

Generates 20 notes and tags them with random text tags and people from the database.

## `generate:all`

Runs all of the commands listed above to generate all the data at once.

## `generate:reset`

**Deletes** all data from the database except for user accounts and snapshots.
**Be careful with this one! You should not run it in any production environment.**
