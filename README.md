# dbt Labs Take-Home Project

This repository contains a small dbt project for the Customer Solutions Engineer assessment. It uses seeded ecommerce sample data in a hosted PostgreSQL database to build an analytics mart.

## Project objective

The transformation job turns raw ecommerce source tables into analytics-ready models for daily sales reporting and customer analysis.

The project uses three layers:

- `seeds`: raw ecommerce sample data for orders, order items, products, and users
- `models/staging/thelook`: clean source-aligned views for the seeded raw tables
- `models/intermediate`: reusable joined business logic for enriched order items
- `models/marts`: final reporting models, including daily sales and customer dimensions

## Production job

Recommended dbt Cloud production command:

```bash
dbt build --select tag:prod
```

If the production environment is empty, run seeds before the build:

```bash
dbt seed --select tag:prod
dbt build --select tag:prod
```

Configured schedule for the assessment:

- Environment: Production deployment environment
- Frequency: Every 12 hours, which was the least frequent interval available in the dbt Cloud interval scheduler
- Time: After expected upstream data availability

## Models

- `stg_orders`: cleaned order-level source data
- `stg_order_items`: cleaned order line items
- `stg_products`: cleaned product catalog data
- `stg_users`: cleaned customer data
- `int_order_items_enriched`: order items joined to order and product attributes
- `fct_daily_sales`: daily completed-order revenue metrics by category and department
- `dim_customers`: customer attributes with first-order and lifetime order metrics

## Local validation

This project was parsed locally with dbt Core and the Postgres adapter:

```bash
python3 -m venv .venv
.venv/bin/python -m pip install -r requirements.txt
.venv/bin/dbt parse --profiles-dir .dbt --no-partial-parse
```

## dbt Cloud setup notes

1. Create a dbt Cloud developer account.
2. Connect dbt Cloud to GitHub and select this repository.
3. Create a hosted PostgreSQL database.
4. Create a dbt Cloud PostgreSQL connection using the database host, port, database, username, and password.
5. Configure a development schema for personal development.
6. Configure a production deployment schema for scheduled job outputs.
7. Create a production job with `dbt seed --select tag:prod` followed by `dbt build --select tag:prod`.
8. Schedule the job in the production environment. For this assessment, the configured interval was every 12 hours.

## Assessment response

The written interview response is in `assessment_response.md`.
