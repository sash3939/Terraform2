# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

### Цели задания

1. Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.
2. Освоить работу с переменными Terraform.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**02/src**](https://github.com/netology-code/ter-homeworks/tree/main/02/src).


### Задание 0

1. Ознакомился с документация по security groups https://yandex.cloud/ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav&utm_referrer=https%3A%2F%2Fgithub.com%2Fnetology-code%2Fter-homeworks%2Fblob%2Fmain%2F02%2Fhw-02.md


### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.
Убедитесь что ваша версия **Terraform** ~>1.8.4

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.

![ssh key](https://github.com/user-attachments/assets/0ec96abf-42f3-4368-83e3-06cc666824e5)
---
   
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).

![service account](https://github.com/user-attachments/assets/91bc7aef-c477-4017-aa62-3cc9e9b655fe)
---
![service account key](https://github.com/user-attachments/assets/b6a271da-ed1c-4672-a14d-59f98e16a688)
---

3. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.

![ssh key pub](https://github.com/user-attachments/assets/f81ca16a-b267-498d-980c-063fc57ccc00)
---
![ssh vars](https://github.com/user-attachments/assets/b461d917-a644-4c7c-8805-6893e6a3ca02)
---


4. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.

![init](https://github.com/user-attachments/assets/767dc64b-e4fc-4ecd-8938-99f7707649d8)
---

1)
- Ошибка в platform_id:
"standart-v4"
Исправлено на: "standard-v1"

- Неверное написание идентификатора платформы. standard вместо standart.

2) Значения cores, memory, core_fraction в соответствии с standard_v3 должны быть минимально такие

resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 1
        }

Поправили хардкодом, запустили проект

![after terraform apply](https://github.com/user-attachments/assets/52c71f7c-bbcd-4f50-a868-846e19d88100)
---

5. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;

![connect VM ssh](https://github.com/user-attachments/assets/99ffbb1b-da4e-442b-baa5-e0dda381eabf)
---

![curl](https://github.com/user-attachments/assets/fc9e63ec-9e2d-48b3-84a3-bb1e9da675e0)
---

6. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.

## Параметр preemptible=true

    Описание: Preemptible ВМ (прерываемые виртуальные машины) представляют собой временные ВМ, которые могут быть завершены в любое время (например, если ресурсы потребуются для других задач) с коротким уведомлением.
    Преимущества:
        Стоимость: Preemptible ВМ обычно дешевле, чем стандартные ВМ. Это позволяет существенно снизить расходы на обучение моделей, особенно при работе с большими объемами данных или сложными моделями.
        Эффективность использования ресурсов: Такие ВМ подходят для задач, которые могут быть прерваны и возобновлены без существенных потерь данных или прогресса.
    Недостатки:
        Непредсказуемость: ВМ могут быть прерваны в любое время, что может потребовать дополнительных усилий для управления контрольными точками и возобновления задач.

## Параметр core_fraction=5

    Описание: Параметр core_fraction указывает процент процессорного времени, который будет доступен для задачи. В данном случае core_fraction=5 означает, что задача будет использовать только 5% процессорного времени.
    Преимущества:
        Снижение затрат: Параметр core_fraction позволяет гибко управлять ресурсами, выделяя только необходимую долю CPU, что может быть особенно полезно для фоново интенсивных задач или задач с низким приоритетом.
        Оптимизация производительности: При низких значениях core_fraction возможно параллельное выполнение большего числа задач на одном и том же оборудовании без существенного снижения производительности каждой из них.
    Недостатки:
        Ограниченная производительность: Использование только части CPU может существенно замедлить выполнение задач, особенно если они требуют интенсивных вычислений.


В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.


### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.

![main_vm_web variables](https://github.com/user-attachments/assets/e9f9a22a-0009-4dc8-9741-915b8916876b)
---
   
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 

![variable_vm_web variables](https://github.com/user-attachments/assets/ee3c4b65-0655-4c8c-9b0a-7a832ee9f032)
---

3. Проверьте terraform plan. Изменений быть не должно. 

![terraform plan no changes](https://github.com/user-attachments/assets/8c7a04ad-0431-4474-9e5b-9f6ce0eaf178)
---


### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.

![resource vm_db](https://github.com/user-attachments/assets/1609dc74-96a2-47b9-aaf7-4880f4b6e467)
---


### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.

![outputs](https://github.com/user-attachments/assets/1de4387d-5429-4b91-ace6-c0e13214e398)
---

### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.

![locals](https://github.com/user-attachments/assets/f5799f2f-2dbe-4dda-a6c8-18a2034649bd)
---

2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.

![changes after locals](https://github.com/user-attachments/assets/d2ee4202-3639-464b-ad98-e2b1b6f06966)
---
  
3. Примените изменения.

![ycloud after locals](https://github.com/user-attachments/assets/0bf70515-ffcc-4197-92ac-d0763edf4939)
---


### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map(object).  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=2
       memory=2
       core_fraction=5
       hdd_size=10
       hdd_type="network-hdd"
       ...
     },
     db= {
       cores=2
       memory=4
       core_fraction=20
       hdd_size=10
       hdd_type="network-ssd"
       ...
     }
   }
   ```

![terraform plan after map variables](https://github.com/user-attachments/assets/d456a33b-da91-443b-804a-5b6c77f298de)
---


2. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
![terraform tfvars](https://github.com/user-attachments/assets/caf86a59-eec4-4901-a85f-c53d7523e538)
---
## Теперь ключ подставляется из terraform.tfvars

3. Найдите и закоментируйте все, более не используемые переменные проекта.

![variables tf after map variables](https://github.com/user-attachments/assets/8fc02c59-4b99-43c7-bc46-6d84c8cdfe28)
---

4. Проверьте terraform plan. Изменений быть не должно.
Изменений нет.

------

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   
Они помогут глубже разобраться в материале. Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


------
### Задание 7*

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list.

local.test_list[1]
"staging"

2. Найдите длину списка test_list с помощью функции length(<имя переменной>).

length(local.test_list)
3
   
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map.

local.test_map["admin"]
"John"

4. Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

"${ local.test_map["admin"] } is keys(local.test_map)[0] for ${ local.test_list[2] } server based on OS ${ local.servers["production"]["image"] } with ${ local.servers["production"]["cpu"] } vcpu, ${ local.servers["production"]["ram"] } ram and ${ length(local.servers["production"]["disks"]) } virtual disks"

**Примечание**: если не догадаетесь как вычленить слово "admin", погуглите: "terraform get keys of map"

В качестве решения предоставьте необходимые команды и их вывод.

------

### Задание 8*
1. Напишите и проверьте переменную test и полное описание ее type в соответствии со значением из terraform.tfvars:
```
test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
```
2. Напишите выражение в terraform console, которое позволит вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117" из этой переменной.
------

------

### Задание 9*

Используя инструкцию https://cloud.yandex.ru/ru/docs/vpc/operations/create-nat-gateway#tf_1, настройте для ваших ВМ nat_gateway. Для проверки уберите внешний IP адрес (nat=false) у ваших ВМ и проверьте доступ в интернет с ВМ, подключившись к ней через serial console. Для подключения предварительно через ssh измените пароль пользователя: ```sudo passwd ubuntu```

### Правила приёма работыДля подключения предварительно через ssh измените пароль пользователя: sudo passwd ubuntu
В качестве результата прикрепите ссылку на MD файл с описанием выполненой работы в вашем репозитории. Так же в репозитории должен присутсвовать ваш финальный код проекта.

**Важно. Удалите все созданные ресурсы**.


### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 
