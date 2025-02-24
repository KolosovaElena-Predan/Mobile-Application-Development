# Выполнила Колосова Елена, ВМК-22
# Лабораторная работа №1. Установка Flutter и создание первого приложения.

## Установка Flutter в Visual Studio Code.
1. Устанавливаем Flutter SDK с официального сайта https://docs.flutter.dev/get-started/install/windows/mobile
2. Извлекаем католог в папку. Например, C:/tools/flutter
3. Открываем:    
Этот компьютер --ПКМ--> Свойства --> Дополнительные параметры системы -> Переменные среды
4. В разделе Переменные для пользователя <имя пользователя> выбираем переменную Path и далее кнопку "Изменить"
5. Нужно вписать в переменную Path путь до вашей директории (в примере C:\tools\flutter\bin)
6. Запускаем командную строку и пишем flutter doctor.  
   В случае  удачной установки увидим следующее:  
    [√] Flutter (Channel stable, 3.29.0, on Microsoft Windows [Version 10.0.19045.5371], locale ru-RU)  
    [√] Windows Version (Њ ©Єа®б®дв Windows 10 „®¬ и­пп 64-а §ап¤­ п, 22H2, 2009)  
    [√] Chrome - develop for the web  
    [√] Visual Studio - develop Windows apps (Visual Studio Community 2022 17.11.2)  
    [√] Android Studio (version 2024.2)  
    [√] VS Code (version 1.97.2)  
    [√] Connected device (3 available)  
    [√] Network resources  
7. Открываем VS Code. Нажимаем Ctrl+Shift+X. В поиске пишем Flutter выбираем верхний результат запроса и нажиамаем "Install"
8. Для настройки пути к Flutter SDK в VS Code открываем настройки VS Code, нажав на значок шестеренки в левом нижнем углу окна и выбрав Settings. Найдите "Flutter SDK Path" в строке поиска и дальше нажмите "Edit in settings.json".  
В файле JSON добавьте путь к каталогу Flutter SDK.   
В примере:  
"dart.flutterSdkPath": "C:/tools/flutter"

## Создание первого приложения
1. Нажимаем Ctrl+Shift+P.    
2. Выбираем там "Flutter: New Project" ->Application  
3. Выбираем путь куда сохранить проект  
4. Пишем название проекта. Например, "my_app"  
5. Нажимаем Enter. Автоматически этот проект откроется
6. Для запуска выбираем lib->main.dart в панели Explorer и нажимаем Start Debugging в верхнем правом углу
7. Из списка выбираем, где мы хотим запустить приложение. Напимер, в Chrome.


