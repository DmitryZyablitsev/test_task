# README

1. Использовать gem ActiveInteraction => https://github.com/AaronLasseigne/active_interaction отрефакторить класс Users::Create
2. Исправить опечатку Skil. Есть 2 пути решения. Описать оба.
3. Исправить связи
4. Поднять Rails приложение и в нем использовать класс Users::Create
5. Написать тесты
6. При рефакторнге кода использовать Декларативное описание(подход в программировании)

1. Сделал
2. Средствами IDE можно массово заманить Skil на Skill в ручную переименовать файл модели. Потом можно создать миграцию которая переименует таблицу skils на skills, а можно БД не трогать и в модели указать, что она связана с таблицей skils
3. Исправил на has_and_belongs_to_many, так же можно воспользоваться has_many :patients, through:, но придется создавать новую модель это даст больше гипкости над таблицей в БД, но пораждает новую лишнюю сущность, поэтому выбрал первый способ
4. Приложение запускается
5. Тесты написал
