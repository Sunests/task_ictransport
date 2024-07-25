WITH wifi AS (
    SELECT uid, start_station, stop_station, start_dttm
    FROM wifi_session
    WHERE start_dttm >= NOW() - INTERVAL '3' MONTH
),
station_usage AS (
    SELECT uid, COUNT(*) AS usage_count
    FROM (
        SELECT uid, start_station AS station
        FROM wifi
        WHERE start_station IN (50, 161)
        
        UNION ALL
        
        SELECT uid, stop_station AS station
        FROM wifi
        WHERE stop_station IN (50, 161)
    ) AS combined_stations
    GROUP BY uid
)
SELECT uid, usage_count
FROM station_usage
WHERE usage_count > 50
ORDER BY uid;