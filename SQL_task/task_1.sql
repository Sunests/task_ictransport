WITH stations_count AS (
    SELECT 
        uid, 
        COUNT(*) FILTER (WHERE start_station IN (50, 161)) +
        COUNT(*) FILTER (WHERE stop_station IN (50, 161)) AS station_count
    FROM wifi_session
    WHERE start_dttm >= NOW() - INTERVAL '3' MONTH
    GROUP BY uid
)
SELECT uid, station_count
FROM stations_count
WHERE station_count > 50
ORDER BY uid;