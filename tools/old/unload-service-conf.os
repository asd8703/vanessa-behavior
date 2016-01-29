#Использовать v8runner
#Использовать logos
#Использовать json

Перем Лог;

Перем массивСервисныхБаз;

//TODO убрать копипаст из кода 3-ех библиотек
Процедура ПрочитьНастройки()

	парсерJSON = Новый ПарсерJSON();

	файлКонфигурацииСервисныхБаз = Новый ЧтениеТекста();
	файлКонфигурацииСервисныхБаз.Открыть(".\tools\service-bases.conf");

	текстНастроек = файлКонфигурацииСервисныхБаз.Прочитать();

	массивСервисныхБаз = парсерJSON.ПрочитатьJSON(текстНастроек);

	файлКонфигурацииСервисныхБаз.Закрыть(); 
	//TODO - кстати надо разобраться - когда oscript закрывает открытые дескрипторы

	//FIXME - определить почему JSON отправляет в файл Структуру, а обратно получает Соответствие
	//FIXME - разобраться почему oscript не позволяет обойти Соответствие как универсальную коллекцию

КонецПроцедуры

Лог = Логирование.ПолучитьЛог("behavior.build.log");

Лог.Информация("Синхронизирую сервисные базы с текущими исходными кодами");

ПрочитьНастройки();

//TODO - разобраться с относительными путями

Лог.Информация("Работаю в контектте запуска " + ТекущийКаталог());


УправлениеКонфигуратором = Новый УправлениеКонфигуратором();
УправлениеКонфигуратором.КаталогСборки(".\distr\");	

Для каждого _сервиснаяБаза из массивСервисныхБаз Цикл
	ПутьКИсходникам = _сервиснаяБаза.Получить("ПутьКИсходникам");
	ВерсияПлатформы = _сервиснаяБаза.Получить("Версия");
	СоздаваемаяБаза = _сервиснаяБаза.Получить("СоздаваемаяБаза");

	Лог.Информация("обрабатываю " + СоздаваемаяБаза);

	путьКПлатформе = УправлениеКонфигуратором.ПолучитьПутьКВерсииПлатформы(ВерсияПлатформы);
	УправлениеКонфигуратором.ПутьКПлатформе1С(путьКПлатформе);

	УправлениеКонфигуратором.УстановитьКонтекст("/F" + СоздаваемаяБаза + "\","","");

	ПараметрыЗапуска = УправлениеКонфигуратором.ПолучитьПараметрыЗапуска();
	ПараметрыЗапуска.Добавить("/DumpConfigFiles""" + ПутьКИсходникам + """"); 


КонецЦикла;


