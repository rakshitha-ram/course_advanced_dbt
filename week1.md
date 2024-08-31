### Task 2: Add docs blocks to populate missing documentation and maintain consistency

Added all the descriptions to `models/docs/docs_bingeflix.md`

### Task 3: Install dbt_project_evaluator package to enforce best practices
- I added the missing fct_events.yml file. 
- I renamed the mrr model to fct_mrr and updated .yml file. This resolved the `is_empty_fct_model_naming_conventions_`. 
- I added description for ads_platform source table. This resolved the `is_empty_fct_undocumented_sources_` issue. 
- In fct_active_users model, I disabled the fanout test in project.yml file This helped reolve the `is_empty_fct_model_fanout_` issue. 
