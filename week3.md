# Week 3 Questions

### Task 1: Identify a few redundant tests that can be removed
- Removed `not_null` checks from all columns in `dim_users` that are already checked in `stg_bingeflix__users`.

### Task 2: Write a custom generic test to replace a redundant singular test
- Created a generic test named "assert_valid_event_name":
- Applied the test to `stg_bingeflix__events.sql`.

### Task 3: Write a unit test to verify the logic of a transformation
- Created a unit test named `test_age_at_acquisition` and ran
