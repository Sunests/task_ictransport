import requests
import pandas as pd

# Функция для получения данных из API 
def get_stations_data():
    url = "https://api.rasp.yandex.net/v3.0/stations_list"
    params = {
        # Ввел свой ключ API
        "apikey": "d8f4fbc1-40b0-469d-8ece-c77d76945a77",
        "format": "json",
        "lang": "ru_RU"
    }
    # Проверка на ошибки
    try:
        response = requests.get(url, params=params)
        response.raise_for_status()
        return response.json()
    except requests.RequestException as e:
        print(f"Ошибка при запросе: {e}")
        return None

# Создание DataFrame из данных
def create_stations_dataframe(data):
    stations = []
    for country in data.get("countries", []):
        for region in country.get("regions", []):
            for settlement in region.get("settlements", []):
                for station in settlement.get("stations", []):
                    stations.append(
                        # Get-ы для безопасного извлечения данных из словарей,
                        # так как некоторых полей данных может не быть
                        {
                            "Страна": country.get("title", ""),
                            "Населенный пункт": settlement.get("title", ""),
                            "Название станции": station.get("title", ""),
                            "Направление": station.get("direction", ""),
                            "Код яндекса": station.get("codes", {}).get("yandex_code", ""),
                            "Тип станции": station.get("station_type", ""),
                            "Тип транспорта": station.get("transport_type", ""),
                            "Долгота": station.get("longitude", ""),
                            "Широта": station.get("latitude", ""),
                        }
                    )
    return pd.DataFrame(stations)

stations_data = get_stations_data()

df = create_stations_dataframe(stations_data)

# Сохранение обработанных данных в CSV и Excel файлы
df.to_csv(r"API_task\stations.csv", index=False, encoding="utf-8-sig") # utf-8-sig, потому что при utf-8 ломается
df.to_excel(r"API_task\stations.xlsx", index=False)

print("Данные успешно сохранены в файлы data.csv и data.xlsx.")