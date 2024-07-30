WITH last_trips_per_day AS (
    SELECT
        uid,
        stop_station,
        stop_dttm
    FROM wifi_session wf1
    WHERE stop_dttm = (
        SELECT MAX(stop_dttm)
        FROM wifi_session wf2
        WHERE wf1.uid = wf2.uid AND wf1.stop_dttm::date = wf2.stop_dttm::date
    )
    ORDER BY uid, stop_dttm
),
stations_count AS (
    SELECT
        uid,
        stop_station,
        COUNT(*) AS station_count
    FROM last_trips_per_day
    GROUP BY uid, stop_station
)
SELECT
    uid,
    stop_station,
    MAX(station_count)
FROM stations_count AS sc1
WHERE station_count = (
    SELECT MAX(station_count)
    FROM stations_count AS sc2
    WHERE sc1.uid = sc2.uid
)
GROUP BY uid, stop_station
ORDER BY uid, stop_station;