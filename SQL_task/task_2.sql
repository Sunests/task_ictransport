WITH wifi AS (
    SELECT
	uid,
    	start_dttm,
        stop_dttm,
	LAG(stop_dttm) OVER (PARTITION BY uid ORDER BY start_dttm) AS prev_stop_dttm
    FROM wifi_session
)
SELECT
    uid,
    start_dttm,
    stop_dttm,
    prev_stop_dttm
FROM wifi
WHERE start_dttm < prev_stop_dttm;