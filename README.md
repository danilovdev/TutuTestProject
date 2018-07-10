# TutuTestProject

## Contents:
1. Description in Russian

2. Description in English

## Description in Russian

### Что необходимо сделать

Приложение, имеющее стандартный тулбар с двумя разделами: "Расписание" и "О приложении"

#### 1. "Расписание"

Первый экран раздел должен позволять выбрать:

 - Станцию «отправления»
 - Станцию «прибытия».
 - Дату отправления.

Экран выбора станции необходимо строить на основе `UITableView` и он должен:  

- Содержать общий перечень станций (см. вложенный файл), сгруппированный по значению «Страна, Город». Полный перечень групп и элементов должен быть представлен на одном экране, с возможностью пролистывания всего содержимого.
- Предоставлять возможность поиска по части имени (как начальной, так и входящей, независимо от регистра). Поиск необходимо осуществлять на том же экране, где представлен список станций, с использованием `UISearchController`.
- Предоставлять возможность просмотра детальной информации о конкретной станции (именование и ее полный адрес, включая город, регион и страну).

#### 2. "О приложении"

В данном разделе необходимо разместить информацию о:

 - Копирайте
 - Версии приложения

### Описание файла с данными

Входные данные предоставлены в формате JSON
```javascript
{
  "citiesFrom" : [  ], //массив пунктов отправления
  "citiesTo" : [  ] //массив пунктов назначения
}
```
Элемент массива представляет собой описание города
```javascript
{
	"countryTitle" : "Россия", //название страны
	"point" : { //координаты города
		"longitude" : 50.64357376098633,
		"latitude" : 55.37233352661133
	},
	"districtTitle" : "Чистопольский район", //название района
	"cityId" : 4454, //идентификатор города
	"cityTitle" : "Чистополь", //название города
	"regionTitle" : "Республика Татарстан", //название региона
	"stations" : [...] //массив станций
}
```

Станция описывается объектом
```javascript
{
	"countryTitle" : "Россия", //название страны (денормализация данных, дубль из города)
	"point" : { //координаты станции (в общем случае отличаются от координат города)
		"longitude" : 50.64357376098633,
	    "latitude" : 55.37233352661133
	},
	
	"districtTitle" : "Чистопольский район", //название района
	"cityId" : 4454, //идентификатор города
	"cityTitle" : "город Чистополь", //название города
	"regionTitle" : "Республика Татарстан", //название региона
	
	"stationId" : 9362, //идентификатор станции
	"stationTitle" : "Чистополь" //полное название станции
}
```
## Description in English

### What need to be done

Application should have TabBar with two tabs: Schedule ("Расписание") and About ("О приложении")

#### 1. Schedule Screen ("Расписание")
The screen should allow you to select:
Departure station(Станция "отправления")
Arrival station(Станция "прибытия")
Date of departure(Дату отправления)

#### 2. Station List Screen ("Экран выбора станции")
The station selection screen must be built on the basis of UITableView and it should:
Contain the general list of stations (see the attached file), grouped by the value of "Country, City". A complete list of groups and elements should be presented on one screen, with the ability to scroll through the entire content.

Provide the ability to search for part of the name (both initial and incoming, regardless of the register). Search must be performed on the same screen, where the list of stations is presented, using the UISearchController.

#### 3. Station Detail Screen ("Детальной информация о конкретной станции")
Display detailed information about a particular station (naming and its full address, including city, region and country).

#### 4. About Screen ("О приложении")
In this section you need to post information about: Author, Application Version

### JSON file description

Input data in JSON
```javascript
{
  "citiesFrom" : [  ], //массив пунктов отправления
  "citiesTo" : [  ] //массив пунктов назначения
}
```
Element of array is City object
```javascript
{
	"countryTitle" : "Россия", //название страны
	"point" : { //координаты города
		"longitude" : 50.64357376098633,
		"latitude" : 55.37233352661133
	},
	"districtTitle" : "Чистопольский район", //название района
	"cityId" : 4454, //идентификатор города
	"cityTitle" : "Чистополь", //название города
	"regionTitle" : "Республика Татарстан", //название региона
	"stations" : [...] //массив станций
}
```

Station object
```javascript
{
	"countryTitle" : "Россия", //название страны (денормализация данных, дубль из города)
	"point" : { //координаты станции (в общем случае отличаются от координат города)
		"longitude" : 50.64357376098633,
	    "latitude" : 55.37233352661133
	},
	
	"districtTitle" : "Чистопольский район", //название района
	"cityId" : 4454, //идентификатор города
	"cityTitle" : "город Чистополь", //название города
	"regionTitle" : "Республика Татарстан", //название региона
	
	"stationId" : 9362, //идентификатор станции
	"stationTitle" : "Чистополь" //полное название станции
}
```
