WITH end_station_counts AS (
    SELECT
	uid,
        stop_station AS end_station,
        COUNT(*) AS count
    FROM wifi_session
    GROUP BY uid, stop_station
),
max_counts AS (
    SELECT
        uid,
        MAX(count) AS max_count
    FROM end_station_counts
    GROUP BY uid
)
SELECT
    e.uid,
    e.end_station AS most_frequent_end_station
FROM end_station_counts e
JOIN max_counts m
ON e.uid = m.uid AND e.count = m.max_count
ORDER BY e.uid;