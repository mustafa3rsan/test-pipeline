/* @bruin
name: bruin.dummy_users
type: bq.sql
connection: gcp-default
materialization:
  type: table
  strategy: create+replace
  partition_by: signup_date
  cluster_by:
    - country
@bruin */

SELECT
  x AS id,
  CONCAT('User_', x) AS name,
  DATE_ADD(DATE '2024-01-01', INTERVAL CAST(FLOOR(RAND() * 365) AS INT64) DAY) AS signup_date,
  CASE CAST(FLOOR(RAND() * 3) AS INT64)
    WHEN 0 THEN 'US'
    WHEN 1 THEN 'UK'
    ELSE 'TR'
  END AS country
FROM UNNEST(GENERATE_ARRAY(1, 100)) AS x
