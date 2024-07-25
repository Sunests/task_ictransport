SELECT station, COUNT(*) AS visit_count
FROM (
    SELECT start_station AS station
    FROM wifi_session

    UNION ALL
    
    SELECT stop_station AS station
    FROM wifi_session
) AS combined_stations
GROUP BY station
ORDER BY visit_count DESC
LIMIT 10;