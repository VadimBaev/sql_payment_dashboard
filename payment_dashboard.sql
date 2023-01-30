WITH payments_by_month AS (SELECT 
    date(date_trunc('month', date)) as time, 
    mode,
    sum(case when status = 'Confirmed' then 1 else 0 end) as successful_payments,
    count(*) as total_payments
  FROM new_payments
  WHERE mode != 'Не определено'
  GROUP BY time, mode
)
SELECT 
  time, 
  mode, 
  (100.0 * successful_payments / total_payments) as percents
FROM payments_by_month
ORDER BY time, mode;