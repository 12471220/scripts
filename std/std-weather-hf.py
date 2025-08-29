import requests
import urllib.parse
import sys

config = {
    'apiFree': 'https://devapi.qweather.com/v7/weather/now',
    'apiPro': 'https://api.qweather.com/v7/weather/now',
    'apiGeo': 'https://geoapi.qweather.com/v2/city/lookup',
    'KEY': '4b419e6478ef4f97a4fbf4435647c4a7',
    'lang': 'en',
    'dataFileName': 'weather.json',
    'saveFileLocation': '$HOME/.cache/qweather',

    'icon_map': {
        '100': '',
        '101': '',
        '102': '',
        '103': '',
        '104': '',
        '150': '',
        '151': '',
        '152': '',
        '153': '',
        '300': '',
        '301': '',
        '302': '󰙾',
        '303': '',
        '304': '',
        '305': '',
        '306': '',
        '307': '',
        '308': '',
        '309': '',
        '310': '',
        '311': '',
        '312': '',
        '313': '󰙿',
        '314': '',
        '315': '',
        '316': '',
        '317': '',
        '318': '',
        '350': '',
        '351': '',
        '399': '',
        '400': '',
        '401': '󰖘',
        '402': '󰼶',
        '403': '󰼶',
        '404': '󰙿',
        '405': '󰙿',
        '406': '󰙿',
        '407': '🌨️',
        '408': '',
        '409': '',
        '410': '',
        '456': '󰙿',
        '457': '🌨️',
        '499': '',
        '500': '',
        '501': '',
        '502': '',
        '503': '',
        '504': '',
        '507': '',
        '508': '',
        '509': '',
        '510': '',
        '511': '',
        '512': '',
        '513': '',
        '514': '',
        '515': '',
        '900': '',
        '901': ''
    }

}

def search_city(location: str, number:int = 3, lang: str = 'en', range_scope: str = 'cn') -> str:
    """
    根据城市名称模糊查询，返回城市信息列表（最多 number 个结果）

    :param location: 城市名或关键词，例如 '新吴', '北京'
    :param number: 返回结果数量，默认 3
    :param lang: 返回语言，默认中文 'zh'
    :param range_scope: 范围限制，默认 'cn' 限制为中国城市
    :return: 匹配城市信息的列表，每个元素是 dict，包含 name、adm1、adm2 和 id 等字段

    mock data:
    {
        "code":"200",
        "location":[
            {
                "name":"北京",
                "id":"101010100",
                "lat":"39.90499",
                "lon":"116.40529",
                "adm2":"北京",
                "adm1":"北京市",
                "country":"中国",
                "tz":"Asia/Shanghai",
                "utcOffset":"+08:00",
                "isDst":"0",
                "type":"city",
                "rank":"10",
                "fxLink":"https://www.qweather.com/weather/beijing-101010100.html"
            },
            ...
        ],
        "refer":{
            "sources":[
                "QWeather"
            ],
            "license":[
                "QWeather Developers License"
            ]
        }
    }

    """
    params = {
        'location': location,
        'number': number,
        'range': range_scope,
        'lang': lang,
        'key': config['KEY']
    }

    url = f"{config['apiGeo']}?{urllib.parse.urlencode(params, safe=',')}"
    try:
        response = requests.get(url, timeout=5)
        response.raise_for_status()
        data = response.json()

        if data.get('code') == '200':
            return data.get('location', [])
        else:
            print("geo api return code error: ", data.get('code'))
            exit(1)
    except requests.RequestException:
        print("Request geo data error")
        exit(2)

def fetch_weather_data_free(city_id: str, lang: str = 'en') -> dict:
    """
    根据城市 ID 获取天气数据

    :param city_id: 城市 ID，例如 '101190208'
    :param lang: 返回语言，默认英文 'en'
    :return: 天气数据字典

    mock data:
    {
        "code": "200",
        "updateTime": "2025-07-13T10:13+08:00",
        "now": {
            "obsTime": "2025-07-13T10:10+08:00",
            "temp": "30",
            ...
        },
        ...
    }
    """
    params = {
        'location': city_id,
        'lang': lang,
        'key': config['KEY']
    }

    url = f"{config['apiFree']}?{urllib.parse.urlencode(params, safe=',')}"
    try:
        response = requests.get(url, timeout=5)
        response.raise_for_status()
        data = response.json()

        if data.get('code') == '200':
            return data
        else:
            print("weather api return code error: ", data.get('code'))
            exit(3)
    except requests.RequestException:
        print("Request weather error")
        exit(4)

    pass

def decode_weather(weather_data: dict) -> None:
    """
    mock data:
    {
        "code": "200",
        "updateTime": "2025-07-13T10:13+08:00",
        "fxLink": "https://www.qweather.com/en/weather/xinwu-101190208.html",
        "now": {
            "obsTime": "2025-07-13T10:10+08:00",
            "temp": "30",
            "feelsLike": "32",
            "icon": "101",
            "text": "Cloudy",
            "wind360": "315",
            "windDir": "NW",
            "windScale": "2",
            "windSpeed": "9",
            "humidity": "64",
            "precip": "0.0",
            "pressure": "1005",
            "vis": "28",
            "cloud": "9",
            "dew": "24"
        },
        "refer": {
            "sources": [
                "QWeather"
            ],
            "license": [
                "QWeather Developers License"
            ]
        }
    }
    """
    update_time = weather_data['now']['obsTime']
    temperature = weather_data['now']['temp']
    weather = weather_data['now']['text']
    humidity = weather_data['now']['humidity']
    wind_speed = weather_data['now']['windSpeed']
    wind_direction = weather_data['now']['windDir']
    wind_scale = weather_data['now']['windScale']
    icon_code = weather_data['now']['icon']

    if (config['icon_map'][icon_code]!= ''):
        info = config['icon_map'][icon_code]
    else:
        info = weather
    print(f"{info} {temperature}°C  {update_time}")


if __name__ == "__main__":

    # input: #   1. location name, e.g. "anhui,wuhu"
        location = sys.argv[1]
        
        cities = search_city(location, number=1, lang='zh')
        city_id = cities[0]['id']
        weather_data = fetch_weather_data_free(city_id)
        decode_weather(weather_data)

