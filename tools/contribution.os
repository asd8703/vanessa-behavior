﻿#Использовать v8runner
#Использовать logos
#Использовать json
#Использовать cmdline


Функция ПолучитьПарсерАргументов()

	Парсер = Новый ПарсерАргументовКоманднойСтроки();
	
	Парсер.ДобавитьКоманду(Парсер.ОписаниеКоманды("update-conf","создать и обновить сервисные конфигурации"));
	Парсер.ДобавитьКоманду(Парсер.ОписаниеКоманды("check-my-build","проверить свою сборку в режиме самопроверки"));
	Парсер.ДобавитьКоманду(Парсер.ОписаниеКоманды("sync-conf-src","обновить исходные коды сервисных конфигураций"));
	Парсер.ДобавитьКоманду(Парсер.ОписаниеКоманды("install-precommit","установить git перехватчик для внешних обработок"));
	
	Возврат Парсер;
	
КонецФункции

Функция РазобратьАргументыКоманднойСтроки()

	Если АргументыКоманднойСтроки.Количество() = 0 Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Парсер = ПолучитьПарсерАргументов();
	
	Параметры = Парсер.Разобрать(АргументыКоманднойСтроки);

	Возврат Параметры;
	
КонецФункции


Процедура ПоказатьПомощьПоЗапуску()

	Парсер = ПолучитьПарсерАргументов();

	ВозможныеКоманды = Парсер.СправкаВозможныеКоманды();
	
	Сообщить("
		|Скрипт помощшник настройки окружения разработки Vanessa Stack");
	Сообщить("Иcпользование:
		|   oscript contribution.os <имя команды>
		|");
	Сообщить("Возможные команды:
		|");

	Для Каждого Команда Из ВозможныеКоманды Цикл
		Сообщить(" " + Команда.Команда +  " - " + Команда.Пояснение);
	КонецЦикла;
	
КонецПроцедуры


Процедура ВыполнитьЗадание(ПараметрыЗапуска)

	ВызватьИсключение "Не реализовно"

КонецПроцедуры

/////////////////////////////////////////////


Лог = Логирование.ПолучитьЛог("vanessa.behavior.contrib");

Попытка
	Параметры = РазобратьАргументыКоманднойСтроки();
	Если Параметры <> Неопределено Тогда
		ВыполнитьЗадание(Параметры);
	Иначе
		ПоказатьПомощьПоЗапуску();
	КонецЕсли;
	Лог.Закрыть();	
Исключение
	Лог.Ошибка(ОписаниеОшибки());
КонецПопытки;	
