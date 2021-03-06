1. Как пропустить сценарий, чтобы он не падал?
	* Можно его закоментировать в тексте фичи (символ #)
	* Можно поставить сценарию тег - и использовать теги фильтры
	* Да пусть падает - тем более если он не реализован - то он будет желтым, а если реализован - тогда почему он падает? 
2. Как запустить фичу из поставки VB у себя в базе?
	* Большинство фич, которые идут в поставке VB, требуют, чтобы их запускали в специальной служебной базе.
	* Надо собрать служебную базу. Для этого надо загрузить CF из (**.\vanessa-behavoir\lib\CF\83**) 
	* Надо руками в базе установить константу **Путь к  Vanessa Behavior** - это полный путь к обработке **vanessa-behavior.epf** включая имя файла
	* Надо открыть в базе VB
	* Надо указать тег исключение **IgnoreOnCIMainBuild** (список исключаемых тегов)
	* Для ОФ надо ещё указать тег **IgnoreOnOFBuilds**
	* После этого можно загружать все фичи из каталога фич и запускать на выполнение.
3. Как мне удалить в транзакции созданные данные?
	* В BDD не обязательно их удалять за собой.
	* Если всё же хотите,  Вы можете гарантированно удалить их в процедуре **ПередОкончаниемСценария()**. Она срабатывает в любом случае, даже если сценарий упал.
	* Если создавались данные из макета **(Данные = Ванесса.СоздатьДанныеПоТабличномуДокументу(Макет))**, то можно использовать метод **Ванесса.УдалитьСозданныеДанные(Данные)**.
	* Лучше стремиться к тому, чтобы сценарий сам обеспечивал себе окружение, чтобы успешно выполниться.
4. Где мне лучше создавать служебные данные для выполнения сценария?
	* В секции Контекст feature файла
	* В процедуре **ПередНачаломСценария()**
5. Если в сценарии возникла ошибка, модальное окно и т.д. - как мне гарантированно закрыть все эти окна, чтобы следующий сценарий не падал?
	* В секции контекст надо добавить шаг **И Я закрыл все окна клиентского приложения**. А ещё лучше создать экспортный сценарий и в него добавить этот шаг. А в секции Контекст вызывать экспортный сценарий.
6. Как проверять поведение системы под разными ролями?
	* Надо запустить несколько TestClient на разных портах и переключаться между ними.
7. На CI сервере скриншот формируется, но вместо изображения чёрный экран. Как настроит сервер CI?
	* Запускать джоб Jenkins в режиме сервиса нельзя. На CI надо настроить автовход под какой либо учётной записью и в автозагрузку надо поместить команду запуска джоба Jenkins.
	* Нельзя использовать для доступа к CI RDP. Вообще. Надо использовать другой софт для удаленного доступа к нему, например TightVNC. RDP полностью гасит видеокарту (виртуальную или настоящую) при отключении.
	* Надо посмотреть схему энерго сбережения в панели управления, там может стоять отключение дисплея через пару минут. Это надо выключить.
8. Почему у меня не работает тэг @tree
	* Для работы тега @tree надо использовать либо только табы, либо только пробелы. В пределах одной  фичи нельзя в отступах строк использовать и пробелы и Табы.
9. Как поставить брейкпоинт во внешней обработке.
	* Надо закрыть сеанс TestManager.
	* Надо открыть сеанс TestManager.
	* Надо открыть через меню файл/открыть обработку, в которой стоит брейкпоинт.
	* Только после пункта 3 надо открыть Vanessa-Behavior.
	* Теперь остановка на брейкпоните во внешнией обработке будет работать. Но до первого изменений кода в ней. Если изменили код, то надо повторить все действия с начала.
10. Я подключаюсь по RDP к серверу. И фича выполняется нормально, но если свернуть окно RPD, то возникает ошибка.
	* Это связано с особенностью платформы 1С. Некоторые методы платформы (кнопконажималки) не работают, когда погашена видеокарта (а RDP клиент её гасит, когда вы его сворачиваете). Поэтому не надо использовать RDP для доступа к CI (или другим) серверам, когда вы хотите использовать кнопконажималку.
11. Я вызвал метод Ванесса.ЗапретитьВыполнениеШагов(), затем я подключаю свой таймер, и мне надо сделать, чтобы шаг упал.
	* в этом случае вместо вызова исключения надо сделать Ванесса.ПродолжитьВыполнениеШагов(Истина)
12. Появляется ошибка, в которой есть текст: "Неизвестный идентификатор формы". Это означает, что есть два или более epf файла, у которых совпадает поле **Имя** (это которое находится около Синонима и Комментария).
13. Если вы используете версию платформы 8.3.9.2033 или новее, тогда может появиться окно **Предупреждение безопасности**. 
	* Подробно этот механизм описан [здесь](http://its.1c.ru/db/v838doc#bookmark:dev:TI000001871).
	* Если хотите выключить этот механизм для всех баз - пропишите в файле conf.cfg строку: **DisableUnsafeActionProtection=.***
14. Как использовать Sikuli-скрипты. 
	* Установите SikuliX согласно инструкции http://sikulix.com/quickstart/;
	* Ознакомьтесь с http://sikulix-2014.readthedocs.io/en/latest/faq/010-command-line.html;
	* Укажите через path путь к каталогу с runsikulix(.cmd);
	* Разрабатывайте свои Sikuli-скрипты с помощью SikuiliX IDE (http://sikulix-2014.readthedocs.io/en/latest/index.html) либо используйте имеющиеся;
	* Выполнение скрипта в реализации шага вызывайте через Ванесса.ВыполнитьSikuliСкрипт().
15. Как получить отчет Allure у себя на компьютере под Windows
	* Надо скачать дистрибутив Allure [отсюда](https://github.com/allure-framework/allure1/releases) 
	* Надо прописать в Path каталог где лежит allure.bat
	* Вызвать команду **call allure generate {каталог где лежат ваши xml в формате Allure}**
	* Вызвать команду **call allure report open**
16. Как при возникновении ошибки на CI получить скриншоты всех окон 1С?
	* Пока эта фича работает только под Windows.
	* Надо в json файле, в котором указываются параметры запуска Vanessa-Behavior, указать строку: "СниматьСкриншотКаждогоОкна1С": "Истина"
	* Надо установить на CI сервер java 8 (если у вас Jenkins - то скорее всего она у вас уже есть)
	* Надо установить SikuliX версии 1.1 или выше. Брать [отсюда](https://launchpad.net/sikuli/sikulix/1.1.1). Там надо скачать sikulixsetup-1.1.1.jar.
	* Надо чтобы файл runsikulix.cmd был прописан в переменной PATH.
	
