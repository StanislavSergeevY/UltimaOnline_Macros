#####################
###### By Xottab ######
##### Best.UO 2017г ##### 
######################################
##### СКРИПТ НА ГОРОДСКИЕ РАБОТЫ #####
######################################

;--- ПЕРЕМЕННЫЕ ---                                                                             
VAR Drops                            ; Выгрузка в Банк
VAR t                                ; таймер выбора работ
VAR i                                ; порядок выполнения работ
VAR ii                               ; проверка выполненых работ
VAR iii                              ; Имя работ
VAR reg                              ; переменная рег
VAR Runes =                 '0x1F14' ; тип рун
VAR sunduk =            '0x40AA1217' ; сундук с регами
VAR Market =                '0x1183' ; перемещение на Маркет
VAR bank =              '0x00345448' ; Банкир на Маркете
VAR BagBagsID =         '0x40043C10' ; сумка с сумками ID
VAR BagBagsType =           '0x0E75' ; сумка с сумками Type
VAR BagBagsColor =          '0x0002' ; сумка с сумками Color
VAR RuneRegs =          '0x40891319' ; сумка с рунками для докупки рег
VAR RuneWorksMinoc =    '0x40C11D92' ; сумка с рунками работ г. Minoc
VAR RuneWorksMoonglow = '0x40396AE7' ; сумка с рунками работ г. Moonglow
VAR RuneWorksTrinsic =  '0x40A9EBAC' ; сумка с рунками работ г. Trinsic
VAR RuneWorksVesper =   '0x40AA318D' ; сумка с рунками работ г. Vesper
VAR shutdownwindows =    0           ; авто выключение ПК, по умолчанию "0" не выключает, если "1" выключает
VAR RepeatWorks =        0           ; авто повторение работ по умолчанию "0" повторяет, если "1" не повторяет
VAR RepeatRound =        2           ; кол-во повторений работ в сукти

sub AutoStart() ; Start - скрипт на городские работы
   
   Wait ( 150 )
   UO.Exec( 'terminate Reconnect' )
   Wait ( 150 )
   UO.Exec( 'terminate CityWorks' )
   Wait ( 150 )
   UO.Exec( 'terminate AutoHiding' )
   Wait ( 150 )
   UO.Exec( 'terminate AutoGuards' )   
   Wait ( 150 )
   UO.Exec( 'exec AutoGuards' )
   Wait ( 150 )     
   UO.Exec( 'exec AutoHiding' )
   Wait ( 150 ) 
   UO.Exec( 'exec CityWorks' )
   Wait ( 150 )
   UO.Exec( 'exec Reconnect' )
   Wait ( 150 )
   
endsub

Sub CityWorks() ; Скрипт на городские работы
   
   ;--- МАССИВЫ ---
   DIM Rune[49]             ; Руны для перемещений
   Rune[0]  = '0x40B17A82'  ; Банк Minoc!!!
   Rune[1]  = '0x40B175EE'  ; Алхимик
   Rune[2]  = '0x40B16CED'  ; Жестянщик
   Rune[3]  = '0x40B175ED'  ; Кожевник
   Rune[4]  = '0x40B17A81'  ; Конюх
   Rune[5]  = '0x40B17A83'  ; Кузнец
   Rune[6]  = '0x40B0F29E'  ; Лекарь
   Rune[7]  = '0x40B0F29C'  ; Лучник
   Rune[8]  = '0x40B17C9E'  ; Музей
   Rune[9]  = '0x40B01A41'  ; Мясник
   Rune[10] = '0x40B1790F'  ; Плотник
   Rune[11] = '0x40B175EC'  ; Ткач 
   Rune[12] = '0x40B16CEE'  ; Бюро Вакансий Minoc!
   Rune[13] = '0x40CC11B1'  ; Банкир
   Rune[14] = '0x40AD331E'  ; Жестянщик
   Rune[15] = '0x40AD253C'  ; Инскриптер
   Rune[16] = '0x40AD3A2A'  ; Лекарь
   Rune[17] = '0x40AD30EC'  ; Пекарь
   Rune[18] = '0x40AD2729'  ; Плотник
   Rune[19] = '0x40AD272A'  ; Провизионер
   Rune[20] = '0x40AD3320'  ; Рыболов
   Rune[21] = '0x40AD30EB'  ; Травник
   Rune[22] = '0x40AD3A29'  ; Эзотерик
   Rune[23] = '0x40AD3569'  ; Ювелир 
   Rune[24] = '0x409B0C87'  ; Бюро Вакансий Moonglow!
   Rune[25] = '0x407F461D'  ; Барабанщик
   Rune[26] = '0x40CC1426'  ; Боксер:
   Rune[27] = '0x40C27B85'  ; Ветеринар
   Rune[28] = '0x407F4730'  ; Жестянщик
   Rune[29] = '0x40CC1294'  ; Конюх
   Rune[30] = '0x407F576B'  ; Лекарь
   Rune[31] = '0x407F472F'  ; Медный доспех
   Rune[32] = '0x40C29ACE'  ; Музыкант  
   Rune[33] = '0x407F4731'  ; Рукопашник
   Rune[34] = '0x40CC1424'  ; Рыболов
   Rune[35] = '0x407F59E0'  ; Стальной доспех  
   Rune[36] = '0x40C29AD0'  ; Бюро Вакансий Trinsic!
   Rune[37] = '0x409617E5'  ; Взломщик
   Rune[38] = '0x409B2033'  ; Вор
   Rune[39] = '0x409B16D9'  ; Картограф
   Rune[40] = '0x409B1962'  ; Лекарь
   Rune[41] = '0x409B1CB3'  ; Музыкант
   Rune[42] = '0x409B1CB2'  ; Оружейник
   Rune[43] = '0x4095FC7C'  ; Пасечник
   Rune[44] = '0x4095F9CF'  ; Повар
   Rune[45] = '0x40961F4A'  ; Стражник
   Rune[46] = '0x40965EC7'  ; Художник
   Rune[47] = '0x4095FC7E'  ; Шахтер
   Rune[48] = '0x40965EC3'  ; Бюро Вакансий Vesper!  
   
   DIM Names[49]
   Names[0]  = 'Банк Minoc'
   Names[1]  = 'Алхимик'
   Names[2]  = 'Жестянщик'
   Names[3]  = 'Кожевник'
   Names[4]  = 'Конюх'
   Names[5]  = 'Кузнец'
   Names[6]  = 'Лекарь'
   Names[7]  = 'Лучник'
   Names[8]  = 'Музей'
   Names[9]  = 'Мясник'
   Names[10] = 'Плотник'
   Names[11] = 'Ткач'
   Names[12] = 'Бюро вакансий Minoc'
   Names[13] = 'Банкир'
   Names[14] = 'Жестянщик'
   Names[15] = 'Инскриптер'
   Names[16] = 'Лекарь'
   Names[17] = 'Пекарь'
   Names[18] = 'Плотник'
   Names[19] = 'Провизионер'
   Names[20] = 'Рыболов'
   Names[21] = 'Травник'
   Names[22] = 'Эзотерик'
   Names[23] = 'Ювелир'
   Names[24] = 'Бюро вакансий Moonglow'
   Names[25] = 'Барабанщик'
   Names[26] = 'Боксер'
   Names[27] = 'Ветеринар'
   Names[28] = 'Жестянщик'
   Names[29] = 'Конюх'
   Names[30] = 'Лекарь'
   Names[31] = 'Медный доспех'
   Names[32] = 'Музыкант'
   Names[33] = 'Рукопашник'
   Names[34] = 'Рыболов'
   Names[35] = 'Стальной доспех'  
   Names[36] = 'Бюро Вакансий Trinsic'
   Names[37] = 'Взломщик'
   Names[38] = 'Вор'
   Names[39] = 'Картограф'
   Names[40] = 'Лекарь'
   Names[41] = 'Музыкант'
   Names[42] = 'Оружейник'
   Names[43] = 'Пасечник'
   Names[44] = 'Повар'
   Names[45] = 'Стражник'
   Names[46] = 'Художник'
   Names[47] = 'Шахтер'
   Names[48] = 'Бюро Вакансий Vesper'  
   
   DIM Names2[49]
   Names2[0]  = 'Bank Minoc'
   Names2[1]  = '1-Alkhimik'
   Names2[2]  = '2-Zhestyanshchik'
   Names2[3]  = '3-Kozhevnik'
   Names2[4]  = '4-Konyukh'
   Names2[5]  = '5-Kuznets'
   Names2[6]  = '6-Lekar'
   Names2[7]  = '7-Luchnik'
   Names2[8]  = '8-Muzey'
   Names2[9]  = '9-Myasnik'
   Names2[10] = '10-Plotnik'
   Names2[11] = '11-Tkach'
   Names2[12] = 'Byuro vakansiy Minoc'
   Names2[13] = '1-Bankir'
   Names2[14] = '2-Zhestyanshchik'
   Names2[15] = '3-Inskripter'
   Names2[16] = '4-Lekar'
   Names2[17] = '5-Pekar'
   Names2[18] = '6-Plotnik'
   Names2[19] = '7-Provizioner'
   Names2[20] = '8-Rybolov'
   Names2[21] = '9-Travnik'
   Names2[22] = '10-Ezoterik'
   Names2[23] = '11-Yuvelir'
   Names2[24] = 'Byuro vakansiy Moonglow'
   Names2[25] = '1-Barabanshchik'
   Names2[26] = '2-Bokser'
   Names2[27] = '3-Veterinar'
   Names2[28] = '4-Zhestyanshchik'
   Names2[29] = '5-Konyukh'
   Names2[30] = '6-Lekar'
   Names2[31] = '7-Mednyy dospekh'
   Names2[32] = '8-Muzykant'
   Names2[33] = '9-Rukopashnik'
   Names2[34] = '10-Rybolov'
   Names2[35] = '11-Stalnoy dospekh'  
   Names2[36] = 'Byuro Vakansiy Trinsic'
   Names2[37] = '1-Vzlomshchik'
   Names2[38] = '2-Vor'
   Names2[39] = '3-Kartograf'
   Names2[40] = '4-Lekar'
   Names2[41] = '5-Muzykant'
   Names2[42] = '6-Oruzheynik'
   Names2[43] = '7-Pasechnik'
   Names2[44] = '8-Povar'
   Names2[45] = '9-Strazhnik'
   Names2[46] = '10-Khudozhnik'
   Names2[47] = '11-Shakhter'
   Names2[48] = 'Byuro Vakansiy Vesper'  
   
   DIM Tools[49]
   Tools[0]  = '0x00681601'  ; Банк г. Минок!!!
   Tools[1]  = '0x185B'      ; Инструменты "Алхимик"    
   Tools[2]  = '0x1EB5'      ; Инструменты "Жестянщик" 
   Tools[3]  = '0x107C'      ; Инструменты "Кожевник"
   Tools[4]  = '0x0F36'      ; Инструменты "Конюх"
   Tools[5]  = '0x0FB0'      ; Инструменты "Кузнец"
   Tools[6]  = '0x3D67'      ; Инструменты "Лекарь"
   Tools[7]  = '0x0F41'      ; Инструменты "Лучник" 
   Tools[8]  = '0x1E23'      ; Инструменты "Музей" 
   Tools[9]  = '0x3D6B'      ; Инструменты "Мясник" 
   Tools[10] = '0x0C1C'      ; Иструментты "Плотник" 
   Tools[11] = '0x0EC6'      ; Инструменты "Ткач"
   Tools[12] = '0x00DA3F83'  ; Бюро вакансий Minoc!
   Tools[13] = '0x12CA'      ; Инструменты "Банкир"    
   Tools[14] = '0x11AD'      ; Инструменты "Жестянщик" 
   Tools[15] = '0x2D4E'      ; Инструменты "Инскриптер"
   Tools[16] = '0x2130'      ; Инструменты "Лекарь"
   Tools[17] = '0x160B'      ; Инструменты "Пекарь"
   Tools[18] = '0x1BDF'      ; Инструменты "Плотник"
   Tools[19] = '0x2AFA'      ; Инструменты "Провизионер" 
   Tools[20] = '0x1EA6'      ; Инструменты "Рыболов" 
   Tools[21] = '0x1865'      ; Инструменты "Травник" 
   Tools[22] = '0x0E2E'      ; Инструменты "Эзотерик" 
   Tools[23] = '0x1E2C'      ; Инструменты "Ювелир"  
   Tools[24] = '0x00B582AC'  ; Бюро вакансий Moonglow!
   Tools[25] = '0x0E9C'      ; Инструменты "Барабанщик"
   Tools[26] = '0x1071'      ; Инструменты "Боксер"
   Tools[27] = '0x2101'      ; Инструменты "Ветеринар"
   Tools[28] = '0x1852'      ; Инструменты "Жестянщик"
   Tools[29] = '0x14F8'      ; Инструменты "Конюх"
   Tools[30] = '0x1D8C'      ; Инструменты "Лекарь"
   Tools[31] = '0x3DAA'      ; Инструменты "Медный доспех"
   Tools[32] = '0x0E9E'      ; Инструменты "Музыкант"
   Tools[33] = '0x37A0'      ; Инструменты "Рукопашник"
   Tools[34] = '0x14EB'      ; Инструменты "Рыболов"
   Tools[35] = '0x3D86'      ; Инструменты "Стальной доспех"  
   Tools[36] = '0x00AB5809'  ; Бюро Вакансий Trinsic!
   Tools[37] = '0x09A8'      ; Инструменты "Взломщик"
   Tools[38] = '0x1075'      ; Инструменты "Вор"
   Tools[39] = '0x1048'      ; Инструменты "Картограф"
   Tools[40] = '0x0A68'      ; Инструменты "Лекарь"
   Tools[41] = '0x0EB1'      ; Инструменты "Музыкант"
   Tools[42] = '0x1E22'      ; Инструменты "Оружейник"
   Tools[43] = '0x091A'      ; Инструменты "Пасечник"
   Tools[44] = '0x0993'      ; Инструменты "Повар"
   Tools[45] = '0x2566'      ; Инструменты "Стражник"
   Tools[46] = '0x0F66'      ; Инструменты "Художник"
   Tools[47] = '0x1A88'      ; Инструменты "Шахтер"
   Tools[48] = '0x00765862'  ; Бюро Вакансий Vesper! 
   
   #######################################################################   
   
   UO.ColorPrint( 0x0026, "Ожидание прогрузки персонажа" )
   
   UO.Say( "" )
   UO.Say( "" )
   UO.Say( ",resend" )
   UO.Say( "; Начать!" )     ; ";" - Говорит шопотом, видно в радиусе 4 клеток
   UO.Say( "; Продолжить!" ) ; ";" - Говорит шопотом, видно в радиусе 4 клеток  
   UO.Say( "; НЕТ!" )        ; ";" - Говорит шопотом, видно в радиусе 4 клеток
   UO.Say( "; ДА!" )         ; ";" - Говорит шопотом, видно в радиусе 4 клеток
   
   Wait( 3000 )              ; ожидание прогрузки персонажа
   CheckLag()
   UO.ColorPrint( 0x0044, "Ожидание прогрузки персонажа завершено!" )
   
   UO.UseObject( Backpack )          ; открываем сумку игрока
   Wait( 100 )
   CheckLag()
   UO.UseObject( BagBagsID )         ; открываем сумку с сумками для рун
   Wait( 100 )
   CheckLag()
   UO.UseObject( RuneWorksMinoc )    ; открываем сумку с рунками работ
   Wait( 100 )
   CheckLag()
   UO.UseObject( RuneWorksMoonglow ) ; открываем сумку с рунками работ
   Wait( 100 )
   CheckLag()
   UO.UseObject( RuneWorksTrinsic )  ; открываем сумку с рунками работ
   Wait( 100 )
   CheckLag()
   UO.UseObject( RuneWorksVesper )   ; открываем сумку с рунками работ
   Wait( 100 )
   CheckLag()
   UO.UseObject( RuneRegs )          ; открываем сумку с рунками для покупки рег
   Wait( 100 )
   CheckLag()    
   UO.Set( 'finddistance', '1' )     ; устанавливаем дистанцию поиска инструментов
   UO.IgnoreReset()                  ; Обнуляем игнор лист инструментов
   UO.deletejournal()                ; Обнуляем журнал сообщений 
   
   CheckBagBags()
   
   #######################################################################   
   UO.ColorPrint( 0x0044, "Выключить ПК после завершения всех работ? Скажи * ДА! *, по умолчанию не выключает!" )  
   UO.deletejournal( "ДА!" ) 
   t = 5
   while not ( t == -1 or UO.InJournal( "ДА!" ) )
      UO.ColorPrint( 0x042B, str( t ) + " сек." )
      Wait( 1000 )
      t = t - 1 
   wend        
   If UO.InJournal( "ДА!" ) Then
      UO.ColorPrint( 0x0044, "Установлен режим отключения ПК по завершению всех работ!" )
      shutdownwindows = 1
   Endif
   #######################################################################   
   UO.ColorPrint( 0x0044, "Не повторять работы заного после завершения? Скажи * НЕТ! *, по умолчанию повторяет!" )  
   UO.deletejournal( "НЕТ!" ) 
   t = 5
   while not ( t == -1 or UO.InJournal( "НЕТ!" ) )
      UO.ColorPrint( 0x042B, str( t ) + " сек." )
      Wait( 1000 )
      t = t - 1 
   wend    
   If UO.InJournal( "НЕТ!" ) Then
      UO.ColorPrint( 0x0044, "Повторение работ отключено!" )
      RepeatWorks = 1
      Endif
      #######################################################################   
      
      ;--- РЕКОЛ В БАНК - НАЧАЛО ---   
      repeat
         UO.deletejournal()
         Wait( 600 )
         UO.setGlobal( 'Names', Names[ 0 ] )
         UO.setGlobal( 'Names2', Names2[ 0 ] )
         UO.setGlobal( 'i', 0 )
         UO.setGlobal( 'RuneRecall', Rune[ 0 ] )                    
         RecallMoveRegsBackpack()                      
         ;--- ДОБОР РЕГОВ - КОНЕЦ --- 
         
         ;--- РЕКОЛ К СЛЕДУЮЩЕМУ МЕСТУ - НАЧАЛО---    
         For i = 1 To 48 ; реколл по рункам по очереди   !
            UO.Click( Rune[ i ] )
            Wait( 100 )
            CheckLag()
            ;--- ПРОВЕРКА ВЫПОЛНЕНЫХ РАБОТ - НАЧАЛО ---
            If i >= 1 && i <= 12 Then    ; Первая работа в строке журнала инжекта Minoc
               ii = 231 + i            
               iii = 207 + i
            Endif
            
            If i >= 13 && i <= 24 Then    ; Первая работа в строке журнала инжекта Moonglow
               ii = 255 + i
               iii = 231 + i
            Endif
            
            If i >= 25 && i <= 36 Then    ; Первая работа в строке журнала инжекта Trinsic
               ii = 279 + i
               iii = 255 + i
            Endif
            
            If i >= 37 && i <= 48 Then    ; Первая работа в строке журнала инжекта Vesper
               ii = 303 + i
               iii = 279 + i
            Endif             
            
            UO.DeleteJournal() 
            UO.WaitGump( 'cancel' )   ; закрываем меню Quests 
            Wait( 100 )
            UO.Press ( 187 )        ; открываем меню Quests
            Wait( 600 )            
            CheckLag()               
            UO.charprint( 'self', 1061, UO.LastGump( 'text', iii ) + " " + str( i ) + ", Руна: " + UO.getname( Rune[i] ) + ", Выполнена: " + UO.LastGump( 'text', ii ) + " раз." ) 
            If ( UO.LastGump( 'text', ii ) <= UO.LastGump( 'text', 350 ) or UO.LastGump( 'text', ii ) == UO.LastGump( 'text', 243 ) or UO.LastGump( 'text', ii ) == UO.LastGump( 'text', 279 ) or UO.LastGump( 'text', ii ) == UO.LastGump( 'text', 315 ) or UO.LastGump( 'text', ii ) == UO.LastGump( 'text', 351 ) ) Then ; Проверяльщик выполнености работ                      
               ;--- ПРОВЕРКА ВЫПОЛНЕНЫХ РАБОТ - КОНЕЦ ---
               
               ;--- ТАЙМЕР ВЫБОРА РАБОТ - НАЧАЛО ---      
               UO.ColorPrint( 0x042B, "Жду команду * Продолжить! * для выбора работы" )  
               UO.deletejournal( "Продолжить!" )
               Wait( 100 ) 
               t = 5             
               while not ( t == -1 or UO.InJournal( "Продолжить!" ) )
                  UO.ColorPrint( 0x042B, str( t ) + " сек." )
                  Wait( 1000 )
                  t = t - 1 
               wend        
               If UO.InJournal( "Продолжить!" ) Then
                  repeat
                     i = i + 1
                     
                     If i >= 1 && i <= 12 Then    ; Первая работа в строке журнала инжекта Minoc
                        ii = 231 + i
                     Endif
                     
                     If i >= 13 && i <= 24 Then    ; Первая работа в строке журнала инжекта Moonglow
                        ii = 255 + i
                     Endif
                     
                     If i >= 25 && i <= 36 Then    ; Первая работа в строке журнала инжекта Trinsic
                        ii = 279 + i
                     Endif
                     
                     If i >= 37 && i <= 48 Then    ; Первая работа в строке журнала инжекта Vesper
                        ii = 303 + i
                     Endif                                       
                     
                     If i <= 48 Then               
                        UO.Click( Rune[i] )
                        Wait( 600 )
                        CheckLag()
                        UO.ColorPrint( 0x0044, "Выбор работы - " + Names[i] + ": " + str( i ) + ", Руна: " + UO.getname( Rune[i] ) + ", Выполнена: " + UO.LastGump( 'text', ii ) + " раз." )
                        UO.ColorPrint( 0x042B, "Жду команду * Продолжить! * для подтверждения выбранной работы" )
                        UO.deletejournal( "Продолжить!" )
                        Wait( 100 )               
                        t = 3
                        while not ( t == -1 or UO.InJournal( "Продолжить!" ) )
                           UO.ColorPrint( 0x042B, str( t ) + " сек." )
                           Wait( 1000 )
                           t = t - 1 
                        wend  
                     else
                        Wait( 100 )
                        i = 0
                     Endif   
                  Until UO.InJournal( "Продолжить!" ) or UO.Dead()
                  UO.deletejournal( "Продолжить!" )
               Endif
               ;--- ТАЙМЕР ВЫБОРА РАБОТ - КОНЕЦ ---                          
               ;--- РЕКОЛ К СЛЕДУЮЩЕМУ МЕСТУ - НАЧАЛО ---                              
               If not ( i == 12 or i == 24 or i == 36 or i == 48 ) then  
                  UO.setGlobal( 'Names', Names[ i ] )
                  UO.setGlobal( 'Names2', Names2[ i ] )
                  UO.setGlobal( 'i', i )
                  UO.setGlobal( 'RuneRecall', Rune[ i ] )                    
                  UO.setGlobal( 'TextStrok', UO.LastGump( 'text', ii ) )
                  UO.setGlobal( 'Tools', Tools[ i ] )
                  RecallToWorks()
                  RuneFades()
                  Wait( 1000 )
                  ;--- РЕКОЛ К СЛЕДУЮЩЕМУ МЕСТУ - КОНЕЦ ---                    
                  ;--- НАЧАЛО РАБОТЫ ---
                  UO.setGlobal( 'timer', UO.timer() ) ; Запоминаем время начала работы
                  repeat 
                     GoGoGoTool()
                     ;--- ЕСЛИ НЕ НАШЁЛ ИНСТРУМЕНТ, ИДЁТ К ДРУГОМУ ---                                                 
                     ;--- ОТДЫХАЕТ ЕСЛИ УСТАЛ - НАЧАЛО ---
                     If UO.InJournal( "Вы нуждаетесь в отдыхе!" ) Then ; если усталость больше 100 % отдыхает 4 часа и работаем дальше
                        UO.setGlobal( 'Names', Names[ 0 ] )
                        UO.setGlobal( 'Names2', Names2[ 0 ] )
                        UO.setGlobal( 'i', 0 )
                        UO.setGlobal( 'RuneRecall', Rune[ 0 ] )                    
                        RecallToWorks()
                        RuneFades()
                        DropBank()
                        Wait( 1000 )
                        MoveRegsBackpack()
                        Sleep()     
                        UO.setGlobal( 'Names', Names[ i ] )
                        UO.setGlobal( 'Names2', Names2[ i ] )
                        UO.setGlobal( 'i', i )
                        UO.setGlobal( 'RuneRecall', Rune[ i ] )                    
                        UO.setGlobal( 'TextStrok', UO.LastGump( 'text', ii ) )
                        RecallToWorks()
                        RuneFades()
                     Until UO.Dead()
                  Endif
                  ;--- ОТДЫХАЕТ ЕСЛИ УСТАЛ - КОНЕЦ ---                  
                  ;--- ЖДЁМ ЗАВЕРШЕНИЯ РАБОТЫ - НАЧАЛО ---       
                  UO.setGlobal( 'timer', UO.timer() )
                  repeat
                     If UO.InJournal ( "Выполнение работы прервано!" ) Then
                        UO.deletejournal( "Выполнение работы прервано!" )
                        UO.charprint( 'self', 1082, "Кто-то или что-то прервало работу" ) 
                        Wait( 20000 )
                        UO.charprint( 'self', 1082, "Лечу отсиживаться на Маркет" )
                        UO.setGlobal( 'Names', Names[ 0 ] )
                        UO.setGlobal( 'Names2', Names2[ 0 ] )
                        UO.setGlobal( 'i', 0 )
                        UO.setGlobal( 'RuneRecall', Rune[ 0 ] )                    
                        RecallToWorks()
                        RuneFades()
                        DropBank()
                        Wait( 1000 )
                        MoveRegsBackpack()
                        Wait( 300000 )
                        UO.charprint( 'self', 1082, "Возвращаюсь к прерванной работе " + Names[i] )
                        UO.setGlobal( 'Names', Names[ i ] )
                        UO.setGlobal( 'Names2', Names2[ i ] )
                        UO.setGlobal( 'i', i )
                        UO.setGlobal( 'RuneRecall', Rune[ i ] )                    
                        UO.setGlobal( 'TextStrok', UO.LastGump( 'text', ii ) )
                        RecallToWorks()
                        RuneFades()
                        UO.setGlobal( 'timer', UO.timer() ) ; Запоминаем время начала работы
                        GoGoGoTool()
                     Endif
                     repeat
                        Wait( 1000 )                               
                     Until UO.InJournal( "You can't reach that.|You can't see the target|Let's go!|Вы нуждаетесь в отдыхе!|Рабочее место уже занято!|Выполнение работы прервано!|Вы успешно справились с работой!|Необходимо подойти ближе!|Нельзя приступить к работе сидя верхом!" ) or UO.Timer() > ( val( UO.getGlobal( 'timer' ) ) + 6200 ) or UO.Dead()                     
                  Until not UO.InJournal( "Выполнение работы прервано!" )
                  ;--- ЖДЁМ ЗАВЕРШЕНИЯ РАБОТЫ - КОНЕЦ ---                                            
               else           
                  ;--- СДАЁМ РАБОТУ В БЮРО - НАЧАЛО ---    
                  UO.setGlobal( 'Tools', Tools[ i ] )
                  UO.setGlobal( 'Names', Names[ i ] )
                  UO.setGlobal( 'Names2', Names2[ i ] )
                  UO.setGlobal( 'i', i )
                  UO.setGlobal( 'RuneRecall', Rune[ i ] )                    
                  UO.setGlobal( 'TextStrok', UO.LastGump( 'text', ii ) )               
                  RecallToWorks()
                  RuneFades()
                  Buro()
                  ;---СДАЁМ РАБОТУ В БЮРО - КОНЕЦ --- 
               Endif 
            Endif               
         Next  
         ;--- КОНЕЦ РАБОТЫ ---                     
         ;--- ПЕРЕЗАПУСК СКРИПТА - НАЧАЛО ---                 
         If RepeatWorks == 1 Then
            If not UO.Dead() Then
               UO.charprint( 'self', 1082, "Все работы завершены, лечу отдыхать на Маркет!" )
               UO.setGlobal( 'Names', Names[ 0 ] )
               UO.setGlobal( 'Names2', Names2[ 0 ] )
               UO.setGlobal( 'i', 0 )
               UO.setGlobal( 'RuneRecall', Rune[ 0 ] )                    
               RecallToWorks()
               RuneFades()
               DropBank()
               Wait( 1000 )
               MoveRegsBackpack()
            Endif
         Endif         
         If RepeatWorks == 0 Then
            If not UO.Dead() Then
               UO.charprint( 'self', 1082, "Все работы завершены, лечу на Маркет!" )
               UO.setGlobal( 'Names', Names[ 0 ] )
               UO.setGlobal( 'Names2', Names2[ 0 ] )
               UO.setGlobal( 'i', 0 )
               UO.setGlobal( 'RuneRecall', Rune[ 0 ] )                    
               RecallToWorks()
               RuneFades()
               DropBank()
               Wait( 1000 )
               MoveRegsBackpack()                              
               UO.WaitGump( 'cancel' )   ; закрываем меню Quests 
               Wait( 100 )
               UO.Press ( 187 )        ; открываем меню Quests
               Wait( 600 )            
               CheckLag()
               UO.deletejournal( "Начать!" )                        
               while val( UO.LastGump( 'text', 350 ) ) >= RepeatRound and not UO.InJournal( "Начать!" )   
                  Wait( 300000 )
                  UO.WaitGump( 'cancel' )   ; закрываем меню Quests 
                  Wait( 100 )
                  UO.Press ( 187 )        ; открываем меню Quests
                  Wait( 600 )            
                  CheckLag()
                  ;--- АВТО ВЫКЛЮЧЕНИЕ КОМПА - НАЧАЛО ---   
                  If shutdownwindows == 1 then
                     UO.Say( ",shutdownwindows normal" )
                     UO.exec( 'terminate all' )           
                  Endif
                  UO.charprint( 'self', 1082, "Жду обнуления счётчика работ..." )
                  ;--- АВТО ВЫКЛЮЧЕНИЕ КОМПА - КОНЕЦ ---                   
               wend
               If val( UO.LastGump( 'text', 350 ) ) == 0 then
                  UO.charprint( 'self', 1082, "Счётчик работ обнулён, начался новый день, приступаю к работе!" )
               Endif
               UO.Exec( 'exec AutoStart' )               
            Endif
         Endif         
         ;--- ПЕРЕЗАПУСК СКРИПТА - КОНЕЦ --- 
endsub

################################################################################
############################# СДАЁМ РАБОТУ В БЮРО ##############################

Sub Buro()
   UO.WaitGump(1)
   Wait( 100 )
   UO.UseObject( UO.getGlobal( 'Tools' ) )  ; Сдаём работу в Бюро 
   Wait( 1000 )
   CheckLag()      
   UO.WaitGump( 'cancel' )                ; закрываем меню бюро Бюро 
   Wait( 100 )         
   UO.UseObject( UO.getGlobal( 'Tools' ) )
   Wait( 1000 )
   CheckLag()   
endsub

################################################################################
######################## ПОКУПКА РЕГ - РЕКОЛ ПО РУНКАМ #########################

Sub RecallRuneBuyRegs()
   UO.ColorPrint(0x0026, "Нету регов в банке!" )
   UO.IgnoreReset()
   repeat
      repeat
         UO.deletejournal( "The spell fizzles.|You stop casting the spell." )
         Meditation()
         UO.Findtype( Runes, '-1', RuneRegs )
         UO.Click( 'finditem' )
         Wait( 600 )
         UO.Charprint('self', 1061, "Летим по рунке: " + UO.getname( 'finditem' ) )
         UO.setGlobal( 'RuneBuyRegs', 'finditem' )
         UO.setGlobal( 'NsmesRuneBuyRegs', UO.getname( 'finditem' ) )
         UO.setGlobal( 'RuneBuyCount', UO.FindCount() )
         UO.Print( "Количество рунок в сумке: " + str(UO.FindCount()) )
         UO.Cast( 'Recall', 'finditem' )
         Wait( 6500 )
         CheckLag()                                                                                                         
      Until not UO.InJournal( "The spell fizzles.|You stop casting the spell." ) or UO.Dead()
      RuneBuyRegsFades()
      BuyRegs()
   Until UO.FindCount() == 0 or UO.Dead()
   UO.Print( "Количество рунок в сумке: " + str(UO.FindCount()) )   
endsub

################################################################################
######################## ПОКУПКА РЕГ - ПЕРЕЗАРЯДКА РУН #########################

Sub RuneBuyRegsFades()                     
   If UO.InJournal( "The recall rune fades completely.|The recall rune is starting to fade." ) then
      UO.deletejournal( "The recall rune fades completely.|The recall rune is starting to fade." )
      UO.ColorPrint(0x0026, "Закончились заряды в руне: " + UO.getGlobal( 'NsmesRuneBuyRegs' ) )
      repeat
         UO.deletejournal( "The spell fizzles.|You stop casting the spell." )
         Meditation()                             
         UO.Cast( 'Mark', UO.getGlobal( 'RuneBuyRegs' ) )
         Wait( 6500 )
         CheckLag()
         UO.UseObject( UO.getGlobal( 'RuneBuyRegs' ) )                        
         Wait( 1000 )
         CheckLag()
         UO.Say( UO.getGlobal( 'NsmesRuneBuyRegs' ) )
         Wait( 100 )                    
      Until not UO.InJournal( "The spell fizzles.|You stop casting the spell." ) or UO.Dead()                       
      UO.ColorPrint(0x0044, "Руна: " + UO.getGlobal( 'NsmesRuneBuyRegs' ) + " перезаряжена!" ) 
   Endif
endsub

################################################################################
######################## ПОКУПКА РЕГ ###########################################

Sub BuyRegs()
   UO.Buy( 'regs' )
   Wait( 1000 )
   CheckLag()
   UO.SendGumpSelect(3)
   Wait( 600 )
   CheckLag()                
   UO.Ignore( UO.getGlobal( 'RuneBuyRegs' ) )
   Wait( 600 )
   CheckLag()
   UO.Findtype( Runes, '-1', RuneRegs )   
endsub

################################################################################
######################## АВТО ХИДИНГ ###########################################

Sub AutoHiding()
   repeat
      If val( UO.getGlobal( 'HFlag' ) ) == 0 then         
         If not UO.Hidden() then  ;если не в хайде то пытаемся спрататься
            UO.UseSkill( 'Hiding' )
            UO.Print( "Пытаемся уйти в хайд..." )
            Wait( 4000 ) 
         Endif
      Else
         UO.Print( "Хидинг на паузе, медитируем" )
         while val( UO.getGlobal( 'HFlag' ) ) == 1 and not UO.Dead()       
            Wait( 100 )
         wend
      Endif
      Wait( 500 ) 
   Until UO.Dead()
endsub

################################################################################
######################## АВТО ОХРАНА ###########################################

Sub AutoGuards()
   repeat            
      If UO.Life < UO.GetMaxHP() Then   ; если жизней меньше максимума зовёт Охрану
         UO.PlayWav("C:\UOML\Music\Digital\WOW.wav")
         UO.Exec('exec GoGoGoDanger')
         UO.Exec('exec BabandageSelf')
         UO.Exec('exec DoorsOpen')         
         while UO.Life < UO.GetMaxHP() and not UO.Dead()
            UO.Say( "Guards" )
            Wait( 5000 )
         wend
         UO.Exec('terminate DoorsOpen')
      Endif
      Wait( 100 )      
   Until UO.Dead()
endsub

################################################################################
######################## АВТО ОХРАНА - ХОДИЛКА #################################

Sub GoGoGoDanger()           
   while UO.Life < UO.GetMaxHP() and not UO.Dead() ; если жизней меньше максимума зовёт Охрану    
      If UO.Life >= 100 Then
         UO.Press ( 37, 4 )
         UO.Print ( "Иду вверх")
         Wait( 1000 )
         UO.Press ( 40, 4 )
         UO.Print ( "Иду в лево")
         Wait( 1000 )
      Endif
      Wait( 100 )
      If UO.Life < 100 Then
         UO.Press ( 39, 8 )
         UO.Print ( "Иду вниз")
         Wait( 1600 )
         UO.Press ( 38, 8 )
         UO.Print ( "Иду в право")
         Wait( 1600 )
      Endif
      Wait( 100 )
   wend
endsub

;33 - N - Право
;34 - E - Низ
;35 - S - Лево
;36 - W - Верх
;37 - WS - Верх и Лево
;38 - WN - Верх и Право
;39 - NE - Низ и Право
;40 - ES - Низ и Лево
################################################################################
#################### АВТО ОХРАНА - ЛЕЧЕНИЕ БИНТОМ ##############################

Sub BabandageSelf()            
   while UO.Life < UO.GetMaxHP() and not UO.Dead()   ; если жизней меньше максимума зовёт Охрану
      UO.bandageself() ; лечит себя бинтом
      Wait( 2500 )
   wend
   UO.Exec('warmode 0') ;отключает вар режим
endsub

################################################################################
##################### АВТО ОХРАНА - ОТКРЫВАТЕЛЬ ДВЕРЕЙ #########################

Sub DoorsOpen()
   UO.AddFindList('Doors', 0x06E9)
   UO.AddFindList('Doors', 0x06F1)
   UO.AddFindList('Doors', 0x06F3)
   UO.AddFindList('Doors', 0x06A9)
   UO.AddFindList('Doors', 0x06E5)
   UO.AddFindList('Doors', 0x06E7)
   UO.AddFindList('Doors', 0x06ED)
   UO.AddFindList('Doors', 0x06EF)
   UO.AddFindList('Doors', 0x06A5)
   UO.AddFindList('Doors', 0x06A7)
   UO.AddFindList('Doors', 0x06AD)
   UO.AddFindList('Doors', 0x06AF)
   UO.AddFindList('Doors', 0x0675)
   UO.AddFindList('Doors', 0x0677)
   UO.AddFindList('Doors', 0x067D)
   UO.AddFindList('Doors', 0x067F)
   UO.AddFindList('Doors', 0x06DD)
   UO.AddFindList('Doors', 0x06DF)
   UO.AddFindList('Doors', 0x06B3)
   UO.AddFindList('Doors', 0x06B5)
   UO.AddFindList('Doors', 0x06B7)
   UO.AddFindList('Doors', 0x06D5)
   UO.AddFindList('Doors', 0x06D7)
   UO.AddFindList('Doors', 0x0824)
   UO.AddFindList('Doors', 0x0826)
   UO.AddFindList('Doors', 0x0870)
   UO.AddFindList('Doors', 0x0874)
   UO.AddFindList('Doors', 0x0866)
   UO.AddFindList('Doors', 0x0868)
   UO.AddFindList('Doors', 0x0839)
   UO.AddFindList('Doors', 0x083B)
   UO.AddFindList('Doors', 0x067B)
   UO.AddFindList('Doors', 0x0679)  
   var Door
   repeat
      if UO.FindList('Doors', 'ground', 1, -1, -1) <> '' && UO.GetDistance('finditem') <= 2 then
         Door= UO.getSerial('finditem')
         UO.useobject(Door)
         if UO.InJournal('door is locked') then 
            UO.DeleteJournal()
            UO.Ignore(Door)
         end if
      end if
      wait(100)
   until UO.dead()
endsub

################################################################################
######################## МЕДИТАЦИЯ #############################################

Sub Meditation()
   UO.setGlobal( 'HFlag', 1 )
   while UO.Mana < 50 and not UO.Dead()      
      UO.Print( "Медитируем, Маны меньше 50 %" )
      UO.UseSkill( 'Meditation' )
      Wait( 3500 )
      If not UO.InJournal( "You stop concentrating.|You lose your concentration." ) then
         UO.Print( "Медитируем успешно..." )
         UO.setGlobal( 'timer', UO.timer() )
         while UO.Mana <> UO.int and UO.Timer() < (val( UO.getGlobal( 'timer' )) + 3000) and not UO.Dead()
            Wait( 100 )
         wend
         CheckLag()
      Endif            
      UO.deletejournal( "You stop concentrating.|You lose your concentration." ) 
   wend
   UO.Print( "Медитация завершена!" )
   UO.setGlobal( 'HFlag', 0 )   
endsub

################################################################################            
########################## ПРИСТУПАЕМ К РАБОТЕ #############################

Sub WorkStart()
   UO.Findtype( UO.getGlobal( 'Tools' ), '-1', '1' ) ;Ищим инструмент 
   Wait( 600 )
   UO.ColorPrint(0x0044, "Приступаю к работе - " + UO.getGlobal( 'Names' ) + " " + UO.getGlobal( 'i' ) + ", Руна: " + UO.getname( UO.getGlobal( 'RuneRecall' ) )  + ", Выполнена: " + UO.getGlobal( 'TextStrok' ) + " раз." )       ;Порядковый номер работы  
   UO.WaitGump(1)
   Wait( 600 )
   UO.UseObject( 'finditem' ) ;Начинаем работу 
   Wait( 1000 )          
   CheckLag()
   UO.setGlobal( 'find', 'finditem' )
   UO.setGlobal( 'tool', UO.FindCount() )      ;Запоминаем кол-во найденных инструментов
   UO.setGlobal( 'iX', UO.getX( 'finditem' ) ) ;Запоминаем координаты X найденного итрумента 
   UO.setGlobal( 'iY', UO.getY( 'finditem' ) ) ;Запоминаем координаты Y найденного итрумента
   UO.setGlobal( 'myX', UO.getX( 'self' ) )    ;Запоминаем свои координаты X найденного итрумента)
   UO.setGlobal( 'myY', UO.getY( 'self' ) )    ;Запоминаем свои координаты Y найденного итрумента      
endsub

################################################################################            
########################## ХОДИЛКА ПО ИНСТРУМЕНТАМ #############################

Sub GoGoGoTool()
   repeat
      repeat
         UO.deletejournal() 
         WorkStart()     
         GoGoGoLock()        
         If UO.InJournal( "You can't see the target|You can't use it so often|Рабочее место уже занято!" ) then            
            UO.deletejournal( "You can't see the target|You can't use it so often|Рабочее место уже занято!" )
            CheckStamina()   
            If val( UO.getGlobal( 'tool' ) ) == 0 then ; Если не нашёл интсрументы или он занят идём к друг ому                       
               UO.charprint('self', 1061, "Не нашёл инструмент иду к другому" )
               
               If val( UO.getGlobal( 'i' ) ) == 1 then  ;Ходилка для работы № 0 - Алхимик
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 30 )                           
                     Wait( 6000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 2 then  ;Ходилка для работы № 1 - Жестянщик
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 30 )                        
                     Wait( 6000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif 
               
               If val( UO.getGlobal( 'i' ) ) == 3 then  ;Ходилка для работы № 2 - Кожевник
                  UO.charprint('self', 1061, "Иду в лево")
                  UO.Press ( 35, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в право" )
                     UO.Press ( 33, 30 )                           
                     Wait( 6000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 4 then   ;Ходилка для работы № 3 - Конюх
                  UO.charprint('self', 1061, "Иду в лево")   
                  UO.Press ( 35, 5 )
                  Wait( 2000 )
                  CheckLag()                        
                  UO.charprint('self', 1061, "Открываю дверь" )
                  UO.Say(",opendoor")
                  Wait( 1000 )
                  CheckLag()                       
                  UO.charprint('self', 1061, "Иду в лево" )
                  UO.Press ( 35, 3 )
                  Wait( 1000 )
                  CheckLag()                     
                  UO.charprint('self', 1061, "Иду вверх" )   
                  UO.Press ( 36, 6 )
                  Wait( 2000 )
                  CheckLag()                       
                  UO.charprint('self', 1061, "Иду в право" )
                  UO.Press ( 33, 4 )
                  Wait( 2000 )
                  CheckLag()                        
                  UO.charprint('self', 1061, "Открываю дверь" )
                  UO.Say(",opendoor")
                  Wait( 1000 )
                  CheckLag()                    
                  UO.charprint('self', 1061, "Иду в право" )
                  UO.Press ( 33, 6 )
                  Wait( 2000 )
                  CheckLag()                                             
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вниз")   
                     UO.Press ( 34, 54 )
                     Wait( 10800 )
                     CheckLag()                           
                     UO.charprint('self', 1061, "Открываю дверь" )
                     UO.Say(",opendoor")
                     Wait( 1000 )
                     CheckLag()                        
                     UO.charprint('self', 1061, "Иду в лево" )
                     UO.Press ( 33, 6 )
                     Wait( 2000 )
                     CheckLag()                                                 
                     UO.IgnoreReset()
                  Endif
               Endif 
               
               If val( UO.getGlobal( 'i' ) ) == 5 then  ;Ходилка для работы № 4 - Кузнец
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, в лево" )
                     UO.Press ( 35, 25 )                          
                     Wait( 5000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 6 then  ;Ходилка для работы № 5 - Лекарь
                  UO.charprint('self', 1061, "Иду в лево")
                  UO.Press ( 35, 2 )                      
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в право")
                     UO.Press ( 33, 30 )                         
                     Wait( 6000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 7 then   ;Ходилка для работы № 6 - Лучник
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                       
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 25 )                           
                     Wait( 5000 )
                     heckLag()
                     UO.IgnoreReset()
                  Endif
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 8 then  ;Ходилка для работы № 7 - Музей
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 20 )                           
                     Wait( 4000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif                                                                  
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 9 then  ;Ходилка для работы № 8 - Мясник
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                       
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then   ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 20 )                           
                     Wait( 4000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 10 then  ;Ходилка для работы № 9 - Плотник
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 20 )                           
                     Wait( 4000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 11 then  ;Ходилка для работы № 10 - Ткач
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then   ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 20 )                          
                     Wait( 4000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif                                                                 
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 13 then  ;Ходилка для работы № 0 - Банкир
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 14 )                        
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                   
               
               If val( UO.getGlobal( 'i' ) ) == 14 then  ;Ходилка для работы № 1 - Жестянщик
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 13 )                        
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif 
               
               If val( UO.getGlobal( 'i' ) ) == 15 then  ;Ходилка для работы № 2 - Инскриптер
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 7 )                        
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                
               
               If val( UO.getGlobal( 'i' ) ) == 16 then  ;Ходилка для работы № 3 - Лекарь
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 7 )                           
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif  
               
               If val( UO.getGlobal( 'i' ) ) == 17 then  ;Ходилка для работы № 4 - Пекарь
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 10 )                           
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif  
               
               If val( UO.getGlobal( 'i' ) ) == 18 then  ;Ходилка для работы № 5 - Плотник
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 6 )                        
                     Wait( 2000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif  
               
               If val( UO.getGlobal( 'i' ) ) == 19 then  ;Ходилка для работы № 6 - Провизионер
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 8 )                           
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif  
               
               If val( UO.getGlobal( 'i' ) ) == 20 then  ;Ходилка для работы № 7 - Рыболов
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 24 )                        
                     Wait( 6000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                 
               
               If val( UO.getGlobal( 'i' ) ) == 21 then  ;Ходилка для работы № 8 - Травник
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 7 )                           
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif  
               
               If val( UO.getGlobal( 'i' ) ) == 22 then  ;Ходилка для работы № 9 - Эзотерик
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 7 )                        
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif  
               
               If val( UO.getGlobal( 'i' ) ) == 23 then  ;Ходилка для работы № 10 - Ювелир
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 11 )                        
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                                                                                                                                            
               
               If val( UO.getGlobal( 'i' ) ) == 25 then  ;Ходилка для работы № 0 - Барабанщик
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 10 )                        
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                                                                                                                                            
               
               If val( UO.getGlobal( 'i' ) ) == 26 then  ;Ходилка для работы № 1 - Боксер
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 9 )                        
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif              
               
               If val( UO.getGlobal( 'i' ) ) == 27 then   ;Ходилка для работы № 2 - Ветеринар
                  UO.charprint('self', 1061, "Иду вниз")   
                  UO.Press ( 34, 2 )
                  Wait( 2000 )
                  CheckLag()                  
                  UO.charprint('self', 1061, "Открываю дверь" )
                  UO.Say(",opendoor")
                  Wait( 1000 )
                  CheckLag()                 
                  UO.charprint('self', 1061, "Иду вниз")   
                  UO.Press ( 34, 3 )
                  Wait( 2000 )
                  CheckLag()
                  UO.charprint('self', 1061, "Иду в право" )
                  UO.Press ( 33, 4 )
                  Wait( 2000 )
                  CheckLag()                  
                  UO.charprint('self', 1061, "Иду вверх" )   
                  UO.Press ( 36, 3 )
                  Wait( 2000 )
                  CheckLag()                    
                  UO.charprint('self', 1061, "Открываю дверь" )
                  UO.Say(",opendoor")
                  Wait( 1000 )
                  CheckLag()                  
                  UO.charprint('self', 1061, "Иду вверх" )   
                  UO.Press ( 36, 3 )
                  Wait( 2000 )
                  CheckLag()                                              
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх" )   
                     UO.Press ( 36, 2 )
                     Wait( 2000 )
                     CheckLag()
                     UO.charprint('self', 1061, "Иду в лево" )
                     UO.Press ( 33, 8 )
                     Wait( 5000 )
                     CheckLag()
                     UO.charprint('self', 1061, "Иду вверх" )   
                     UO.Press ( 36, 3 )
                     Wait( 2000 )
                     CheckLag()                                                                      
                     UO.charprint('self', 1061, "Открываю дверь" )
                     UO.Say(",opendoor")
                     Wait( 1000 )
                     CheckLag()                        
                     UO.charprint('self', 1061, "Иду вверх" )   
                     UO.Press ( 36, 3 )
                     Wait( 2000 )
                     CheckLag()                                                 
                     UO.IgnoreReset()
                  Endif
               Endif 
               
               If val( UO.getGlobal( 'i' ) ) == 28 then  ;Ходилка для работы № 3 - Жестянщик
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 11 )                        
                     Wait( 5000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif  
               
               If val( UO.getGlobal( 'i' ) ) == 29 then   ;Ходилка для работы № 4 - Конюх
                  UO.charprint('self', 1061, "Иду в лево")   
                  UO.Press ( 35, 3 )
                  Wait( 2000 )
                  CheckLag()                        
                  UO.charprint('self', 1061, "Открываю дверь" )
                  UO.Say(",opendoor")
                  Wait( 1000 )
                  CheckLag()                       
                  UO.charprint('self', 1061, "Иду в лево" )
                  UO.Press ( 35, 2 )
                  Wait( 1000 )
                  CheckLag()                     
                  UO.charprint('self', 1061, "Иду вверх" )   
                  UO.Press ( 36, 4 )
                  Wait( 2000 )
                  CheckLag()                       
                  UO.charprint('self', 1061, "Иду в право" )
                  UO.Press ( 33, 3 )
                  Wait( 2000 )
                  CheckLag()                        
                  UO.charprint('self', 1061, "Открываю дверь" )
                  UO.Say(",opendoor")
                  Wait( 1000 )
                  CheckLag()                    
                  UO.charprint('self', 1061, "Иду в право" )
                  UO.Press ( 33, 4 )
                  Wait( 2000 )
                  CheckLag()                                             
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в право" )
                     UO.Press ( 33, 8 )
                     Wait( 4000 )
                     CheckLag() 
                     UO.charprint('self', 1061, "Иду вниз")   
                     UO.Press ( 34, 12 )
                     Wait( 9000 )
                     CheckLag()                           
                     UO.charprint('self', 1061, "Открываю дверь" )
                     UO.Say(",opendoor")
                     Wait( 1000 )
                     CheckLag()                        
                     UO.charprint('self', 1061, "Иду в право" )
                     UO.Press ( 33, 4 )
                     Wait( 2000 )
                     CheckLag()                                                 
                     UO.IgnoreReset()
                  Endif
               Endif 
               
               If val( UO.getGlobal( 'i' ) ) == 30 then   ;Ходилка для работы № 5 - Лекарь
                  UO.charprint('self', 1061, "Иду в лево")   
                  UO.Press ( 35, 3 )
                  Wait( 2000 )
                  CheckLag()                                                                   
                  UO.charprint('self', 1061, "Иду вверх" )   
                  UO.Press ( 36, 3 )
                  Wait( 2000 )
                  CheckLag()                       
                  UO.charprint('self', 1061, "Иду в право" )
                  UO.Press ( 33, 3 )
                  Wait( 2000 )
                  CheckLag()                                                                    
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")   
                     UO.Press ( 35, 3 )
                     Wait( 2000 )
                     CheckLag() 
                     UO.charprint('self', 1061, "Иду вниз")   
                     UO.Press ( 34, 14 )
                     Wait( 9000 )
                     CheckLag()                                                   
                     UO.charprint('self', 1061, "Иду в право" )
                     UO.Press ( 33, 6 )
                     Wait( 2000 )
                     CheckLag()
                     UO.charprint('self', 1061, "Иду вверх" )   
                     UO.Press ( 36, 3 )
                     Wait( 2000 )
                     CheckLag()                                                 
                     UO.IgnoreReset()
                  Endif
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 31 then  ;Ходилка для работы № 6 - Медный доспех
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 7 )                           
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif               
               
               If val( UO.getGlobal( 'i' ) ) == 32 then  ;Ходилка для работы № 7 - Музыкант
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 12 )                        
                     Wait( 6000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif              
               
               If val( UO.getGlobal( 'i' ) ) == 33 then  ;Ходилка для работы № 8 - Рукопашник
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 7 )                        
                     Wait( 5000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                
               
               If val( UO.getGlobal( 'i' ) ) == 34 then  ;Ходилка для работы № 9 - Рыболов
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 9 )                           
                     Wait( 5000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif  
               
               If val( UO.getGlobal( 'i' ) ) == 35 then  ;Ходилка для работы № 10 - Стальной доспех
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 7 )                           
                     Wait( 4000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                               
               
               If val( UO.getGlobal( 'i' ) ) == 37 then  ;Ходилка для работы № 0 - Взломщик
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 7 )                           
                     Wait( 4000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                 
               
               If val( UO.getGlobal( 'i' ) ) == 38 then  ;Ходилка для работы № 1 - Вор
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 6 )                        
                     Wait( 4000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif  
               
               If val( UO.getGlobal( 'i' ) ) == 39 then  ;Ходилка для работы № 2 - Картограф
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 10 )                        
                     Wait( 6000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                
               
               If val( UO.getGlobal( 'i' ) ) == 40 then  ;Ходилка для работы № 3 - Лекарь
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 14 )                           
                     Wait( 8000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif
               
               If val( UO.getGlobal( 'i' ) ) == 41 then  ;Ходилка для работы № 4 - Музыкант
                  UO.charprint('self', 1061, "Иду в лево")
                  UO.Press ( 35, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в право")
                     UO.Press ( 33, 6 )                        
                     Wait( 4000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                   
               
               If val( UO.getGlobal( 'i' ) ) == 42 then  ;Ходилка для работы № 5 - Оружейник
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 13 )                           
                     Wait( 8000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif               
               
               If val( UO.getGlobal( 'i' ) ) == 43 then  ;Ходилка для работы № 6 - Пасечник
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 6 )                        
                     Wait( 4000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                 
               
               If val( UO.getGlobal( 'i' ) ) == 44 then  ;Ходилка для работы № 7 - Повар
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 6 )                           
                     Wait( 3000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                 
               
               If val( UO.getGlobal( 'i' ) ) == 45 then  ;Ходилка для работы № 8 - Стражник
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 14 )                        
                     Wait( 9000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                
               
               If val( UO.getGlobal( 'i' ) ) == 46 then  ;Ходилка для работы № 9 - Художник
                  UO.charprint('self', 1061, "Иду в право")
                  UO.Press ( 33, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myY' ) ) == UO.getY( 'self' )  then  ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду в лево")
                     UO.Press ( 35, 9 )                        
                     Wait( 5000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                
               
               If val( UO.getGlobal( 'i' ) ) == 47 then  ;Ходилка для работы № 10 - Шахтер
                  UO.charprint('self', 1061, "Иду вниз")
                  UO.Press ( 34, 2 )                        
                  Wait( 600 )
                  CheckLag()
                  If val( UO.getGlobal( 'myX' ) ) == UO.getX( 'self' ) then ; Елси зашёл в тупик, возращается обратно
                     UO.charprint('self', 1061, "Я дошёл до стены, иду обратно" )
                     UO.charprint('self', 1061, "Иду вверх")
                     UO.Press ( 36, 8 )                           
                     Wait( 5000 )
                     CheckLag()
                     UO.IgnoreReset()
                  Endif
               Endif                            
            else              
               UO.ColorPrint(0x0386, "Я нахожусь в координатах: X=" + UO.getGlobal( 'myX' ) + " Y=" + UO.getGlobal( 'myY') ) 
               UO.ColorPrint(0x0386, "Добавил занятый инструмент в игнорлист " + UO.getGlobal( 'tool' ) + " " + UO.LastGump( 'text', iii ) + " в ингорлист, координаты: X=" + UO.getGlobal( 'iX' ) + " Y=" + UO.getGlobal( 'iY' ) )              
               UO.Ignore( UO.getGlobal( 'find' ) )
            Endif            
         Until val( UO.getGlobal( 'tool' ) ) == 0 or UO.Dead()
      Endif
   Until val( UO.getGlobal( 'tool' ) ) > 0 or UO.Dead()
   UO.deletejournal( "You can't see the target|You can't use it so often|Рабочее место уже занято!" ) 
   Wait( 100 )
endsub

;33 - N - Право
;34 - E - Низ
;35 - S - Лево
;36 - W - Верх
;37 - WS - Верх и Лево
;38 - WN - Верх и Право
;39 - NE - Низ и Право
;40 - ES - Низ и Лево
################################################################################
######################## ОТДЫХАЕТ ЕСЛИ УСТАЛ ###################################

Sub Sleep()
   UO.deletejournal( "Вы нуждаетесь в отдыхе!" )  
   UO.charprint( 'self', 1061, "Я устал, буду отдыхать, затем продолжу" )
   Wait( 1200000 )
   UO.charprint('self', 1061, "Я отдохнул 20 минут..." )
   Wait( 1200000 )
   UO.charprint('self', 1061, "Я отдохнул 40 минут..." )
   Wait( 1200000 )
   UO.charprint('self', 1061, "Я отдохнул 1 час..." )
   Wait( 1200000 )
   UO.charprint('self', 1061, "Я отдохнул 1 час 20 минут..." )
   Wait( 1200000 )   
   UO.charprint('self', 1061, "Я отдохнул 1 час 40 минут..." )
   Wait( 1200000 )   
   UO.charprint('self', 1061, "Я отдохнул 2 часа..." )
   Wait( 1200000 )   
   UO.charprint('self', 1061, "Я отдохнул 2 часа 20 минут..." )
   Wait( 1200000 )   
   UO.charprint('self', 1061, "Я отдохнул 2 часа 40 минут..." )
   ;Wait( 1200000 )   
   ;UO.charprint('self', 1061, "Я отдохнул 3 часа..." )
   ;Wait( 1200000 )
   ;UO.charprint('self', 1061, "Я отдохнул 3 часа 20 минут..." )
   ;Wait( 1200000 )
   ;UO.charprint('self', 1061, "Я отдохнул 3 часа 40 минут..." )
   ;Wait( 1200000 )               
   ;UO.charprint('self', 1061, "Я отдохнул 4 часа и готов работать дальше!" )
   UO.setGlobal( 'timer', UO.timer() )
   CheckLag()
endsub

################################################################################
######################## РЕКОЛ ПО РУНКАМ #######################################

Sub RecallToWorks()
   repeat
      UO.deletejournal( "The spell fizzles.|You stop casting the spell." )
      Meditation()                          
      UO.Click( UO.getGlobal( 'RuneRecall' ) )
      Wait( 600 )
      CheckLag()               
      UO.ColorPrint(0x0044, UO.getGlobal( 'Names' ) + " " + str( UO.getGlobal( 'i' ) ) + ", Руна: " + UO.getname( UO.getGlobal( 'RuneRecall' ) ) + ", Выполнена: " + UO.getGlobal( 'TextStrok' ) + " раз." )
      UO.charprint('self', 1061, UO.getGlobal( 'Names' ) )
      UO.Cast( 'Recall', UO.getGlobal( 'RuneRecall' ) )
      Wait( 6500 )
      CheckLag()                                                                                                         
   Until not UO.InJournal( "The spell fizzles.|You stop casting the spell." ) or UO.Dead()  
endsub

################################################################################
################### ПЕРЕЗАРЯДКА РУН РАБОТ ######################################                      

Sub RuneFades()                     
   If UO.InJournal( "The recall rune fades completely.|The recall rune is starting to fade." ) then
      UO.deletejournal( "The recall rune fades completely.|The recall rune is starting to fade." )
      UO.ColorPrint(0x0026, "Закончились заряды в руне: " + UO.getGlobal( 'Names' ) )
      repeat
         UO.deletejournal( "The spell fizzles.|You stop casting the spell." )
         Meditation()                             
         UO.Cast( 'Mark', UO.getGlobal( 'RuneRecall' ) )
         Wait( 6500 )
         CheckLag()
         UO.UseObject( UO.getGlobal( 'RuneRecall' ) )                        
         Wait( 1000 )
         CheckLag()
         UO.Say( UO.getGlobal( 'Names2' ) )
         Wait( 100 )                    
      Until not UO.InJournal( "The spell fizzles.|You stop casting the spell." ) or UO.Dead()                       
      UO.ColorPrint(0x0044, "Руна: " + UO.getGlobal( 'Names' ) + " перезаряжена!" ) 
   Endif
endsub

################################################################################
####################### ДОБОР РЕГ И БИНТОВ ИЗ БАНКА ############################

Sub RecallMoveRegsBackpack()
   
   DIM Regs[4] 
   Regs[0] = '0x0F7A' ; Black Pearl 
   Regs[1] = '0x0F7B' ; Bood Moss 
   Regs[2] = '0x0F86' ; Mandrake Root
   Regs[3] = '0x0E21' ; Бинты
   
   For reg = 0 To 3 ; проверка не хватающих регов из массива
      ;UO.Print( str(UO.Count( Regs[ reg ] ) ) )      
      UO.FindType( Regs[ reg ], '-1', BagBagsID )
      CheckLag()
      If UO.GetQuantity( 'finditem' ) <= 60 Then ; если не хватет какого-то рега, рекол в банк
         UO.Click( 'finditem' )
         Wait( 600 )
         CheckLag()
         UO.Print( UO.getname( 'finditem' ) + " осталось: " + str(UO.Count( Regs[ reg ] ) ) )                   
         RecallToWorks()
         RuneFades()
         DropBank()
         Wait( 600 )                      
         For reg = 0 To 3   
            UO.FindType( Regs[ reg ], '-1', BagBagsID )
            CheckLag()
            If UO.GetQuantity( 'finditem' ) <= 60 Then ; брать реги и бенты если меньше или равно 60
               UO.FindType( Regs[ reg ], '-1', sunduk ) ; ищем данный рег в сумке в банке                     
               CheckLag()
               If UO.GetQuantity( 'finditem' ) >= 70 Then  ; проверяем сколько нашли регов в банке 
                  UO.MoveItem( 'finditem', '70', BagBagsID ) ; берем 70 шт. в пак  
                  Wait( 600 ) ; паузу надо обязательно, иначе нас заблокирует сервер!
                  CheckLag()
               Else
                  RecallRuneBuyRegs()                   
                  RecallToWorks()
                  RuneFades()
                  DropBank()
                  Wait( 1000 )
                  MoveRegsBackpack()
               Endif
            Endif
         Next
      Endif  
   Next
endsub

################################################################################
####################### ДОБОР РЕГ И БИНТОВ ИЗ БАНКА ############################

Sub MoveRegsBackpack()
   
   DIM Regs[4] 
   Regs[0] = '0x0F7A' ; Black Pearl 
   Regs[1] = '0x0F7B' ; Bood Moss 
   Regs[2] = '0x0F86' ; Mandrake Root
   Regs[3] = '0x0E21' ; Бинты
   
   For reg = 0 To 3
      UO.FindType( Regs[ reg ], '-1', BagBagsID )
      CheckLag()
      If UO.GetQuantity( 'finditem' ) <= 60 Then ; брать реги и бенты если меньше или равно 60
         UO.FindType( Regs[ reg ], '-1', sunduk ) ; ищем данный рег в сумке в банке                     
         CheckLag()
         If UO.GetQuantity( 'finditem' ) >= 70 Then  ; проверяем сколько нашли регов в банке 
            UO.MoveItem( 'finditem', '70', BagBagsID ) ; берем 70 шт. в пак  
            Wait( 600 ) ; паузу надо обязательно, иначе нас заблокирует сервер!
            CheckLag()
         Else
            RecallRuneBuyRegs()                   
            RecallToWorks()
            RuneFades()
            DropBank()
            Wait( 1000 )
            MoveRegsBackpack()
         Endif
      Endif
   Next
endsub

################################################################################
####################### ВЫГРУЗКА ВЕЩЕЙ В БАНК ##################################

Sub DropBank()
   
   DIM Drop[24]        ; Выгрузка в Банк
   Drop[0]  = '0x0F0E' ; Empty Bottles 
   Drop[1]  = '0x1BEF' ; Iron Ingots 
   Drop[2]  = '0x1067' ; Cut up Leather
   Drop[3]  = '0x09D0' ; Apples
   Drop[4]  = '0x0E21' ; Clean Bandages
   Drop[5]  = '0x0F3F' ; Arrows
   Drop[6]  = '0x0E34' ; Blank Scrolls
   Drop[7]  = '0x09F1' ; Ribs
   Drop[8]  = '0x1BDD' ; Tree Log
   Drop[9]  = '0x175D' ; Folded Cloth
   Drop[10] = '0x0F7B' ; Blood Moss
   Drop[11] = '0x0F7A' ; Black Pearl 
   Drop[12] = '0x0F86' ; Mandrake Root
   Drop[13] = '0x097A' ; Raw Fish Steaks
   Drop[14] = '0x0EED' ; Golden Coins
   Drop[15] = '0x0F87' ; Eye of Newt
   Drop[16] = '0x0F26' ; Granates
   Drop[17] = '0x0FA0' ; Spool of Thread
   Drop[18] = '0x0F88' ; Nightshade
   Drop[19] = '0x1422' ; Beeswax
   Drop[20] = '0x19B9' ; Iron Ores
   Drop[21] = '0x0F8D' ; Spider's Silk
   Drop[22] = '0x0F84' ; Garlic
   Drop[23] = '0x14FB' ; Lockpicks 
   
   OpenBank() ; открываем Банк
   
   UO.ColorPrint(0x0047, "Начинаем выгружать вещи в Банк..." )   
   For Drops = 0 To 23      
      UO.FindType( Drop[ Drops ] )            
      If UO.FindCount() <> 0 Then ; если есть вещей кладём все в банк
         UO.Click( 'finditem' )
         Wait( 600 )
         CheckLag()
         UO.ColorPrint(0x0053, "Кладём в Банк: " + UO.getName( 'finditem' ) + " " + str( UO.Count( Drop[ Drops ] ) ) + " шт." )
         UO.MoveItem( 'finditem', '-1', sunduk) ; убираем вещи в Банк  
         CheckLag()
      Endif
   Next
   UO.ColorPrint(0x0047, "Выгрузка в Банк завершена!" )                
endsub

################################################################################
############################ ОТКРЫТЬ БАНК ######################################

Sub OpenBank()
   UO.FindType( Market, '-1', '1' )
   UO.UseObject( 'finditem' )
   Wait( 14000 )
   CheckLag()
   UO.Press( 37, 44 )
   Wait( 7000 )
   CheckLag()   
   UO.UseObject( bank )   ; открыть банк г. Минок
   Wait( 500 )
   CheckLag() 
   UO.UseObject( sunduk ) ; открыть сундук с регами
   Wait( 500 )
   CheckLag()
endsub

################################################################################            
################### ПРОВЕРКА НАЛИЧИЯ СУМКИ ДЛЯ РАБОТЫ ##########################

Sub CheckBagBags()        
   If UO.Count( BagBagsType, BagBagsColor ) > 0 Then
      UO.ColorPrint(0x0044, "Сумка для работы найдена!" ) 
   else
      UO.ColorPrint(0x0026, "Сумка для работы не найдена!" )
      UO.Exec('terminate CityWorks')
   Endif
endsub

################################################################################            
################### ПРОВЕРКА И ВОССТАНОВЛЕНИЕ СТАМИНЫ ##########################

Sub CheckStamina()    
   If UO.Stamina < 40 then
      UO.charprint('self', 1061, "Восстанивливаю стамину..." )
      while UO.Stamina <> UO.DEX or not UO.Dead()         
         Wait( 100 )
      wend
      UO.charprint('self', 1061, "Cтамина восстановленна!" )                
   Endif
endsub

################################################################################            
################### ПРОВЕРКА НА СЛУЧАЙ ЗАСТРЕВАНИЯ #############################

Sub GoGoGoLock()
   If UO.Timer() > (val( UO.getGlobal( 'timer' )) + 9600) then ; Таймер на случай застревания, перезапускает скрипт           
      UO.charprint('self', 1082, "Я застрял!" )
      UO.Exec('exec AutoStart')  
   endif
endsub

################################################################################
############################## РЕКОННЕКТОР #####################################

Sub Reconnect() 
   var ReconnectTime,rFlag 
   ReconnectTime='0' 
   rFlag=1 
   repeat 
      while (UO.ObjAtLayer('Bpack')=='') 
         if rFlag then 
            ReconnectTime=MakeTime() 
            rFlag=0 
         end if 
         Wait(25000) 
         UO.Say('HelloShardgogogo'); <------- Между кавычек вместо 111 прописать свой пароль 
         Wait(3000) 
         UO.Say('HelloShardgogogo') 
         Wait(3000) 
         UO.Say('') 
         Wait(3000) 
         UO.LDblClick(357,164) 
         UO.LClick(616,459) 
         Wait(3000) 
      wend 
      Wait(3000) 
      if (rFlag==0) and (ReconnectTime<>'0') then 
         UO.TextOpen() 
         UO.TextPrint('Disconnected & Reconnected @ '+ReconnectTime) 
         rFlag=1 
         ReconnectTime='0' 
      end if 
   until false 
endsub 

Sub MakeTime() 
   var d,t,ret,i 
   ret=str(UO.Time()) 
   t="" 
   for i=0 to Len(ret) 
      t=ret[Len(ret)-i]+t 
      if (i==2) or (i==4) then 
         t=":"+t 
      end if 
   next 
   ret=str(UO.Date()) 
   d="" 
   for i=0 to Len(ret) 
      d=ret[Len(ret)-i] + d 
      if (i==2) or (i==4) then 
         d="."+d 
      end if 
   next 
   ret=t+" @ "+d 
   return ret 
endsub 

################################################################################
################################################################################
############################ ПОИСК КНОПОК ######################################

Sub Press()
   var i = 0
   repeat
      i = i + 1
      UO.Press ( i, 2)
      UO.charprint('self', 1061, i )
      wait( 500 )
   Until UO.Dead()
endsub

Sub PressX()
   UO.Press ( 37, 4)
endsub

Sub Timer()
   UO.setGlobal( 'timer', UO.timer() )
   repeat
      UO.charprint('self', 1061, UO.getGlobal( 'timer' ) )
      wait( 500 )
   Until UO.Dead()
endsub
################################################################################
################################################################################
Sub isi()
   
   VAR i = -1
   
   repeat
      wait(1000)
      i = i + 1
      UO.print( "i = " + str(i) )
      If i == 4 then
         UO.print( "РАБОТАЕТ! " + str(i) )
      else
         UO.print( "ПРОПУСКАЮ! " + str(i) )
      Endif
   Until UO.Dead()
   
endsub

Sub www()
   UO.WaitGump('cancel')   ; закрываем меню Quests 
   Wait( 100 )
   UO.Press ( 187 )        ; открываем меню Quests
   Wait( 600 )            
   CheckLag()
   UO.infogump()           ; получаем параметры меню Quests из журнала инжекта  
   Wait( 600 )
   UO.deletejournal( "Продолжить!" )                    
   while not (val( UO.LastGump('text', 232) ) == 0 or UO.InJournal( "Продолжить!" ) ) ; одно и тоже разными способами
      while val( UO.LastGump('text', 232) ) <> 0 and not UO.InJournal( "Продолжить!" )   ; одно и тоже разными способами
         UO.WaitGump('cancel')   ; закрываем меню Quests 
         Wait( 100 )
         UO.Press ( 187 )        ; открываем меню Quests
         Wait( 600 )            
         CheckLag()
         UO.infogump()           ; получаем параметры меню Quests из журнала инжекта             
         UO.charprint('self', 1082, "Жду обнуления счётчика работ..." )
         Wait( 3000 )
      wend
      UO.charprint('self', 1082, "Счётчик работ обнулён, начался новый день, приступаю к работе!" )
      UO.Exec('exec AutoStart') 
endsub
;--------------------------------------------------------
; Подключение файлов с макросами
;--------------------------------------------------------

#include(ext0CityWorks.inc)

;***

; Инклуд подключаемый к основному скрипту "CityWorks"
;----------------------------------------------------------------------------

######################## АНТИ ГЛЮК #############################################

Sub CheckLag() 
   UO.DeleteJournal("Backpack") ; вытрим ТОЛЬКО нужные нам сообщения в журнале 
   UO.Click('backpack') ; одиночный клик по вашему backpack    
   repeat 
      wait(100) 
   until UO.InJournal("Backpack") ; ждем сообщения в журнале
   UO.DeleteJournal("Backpack") ; вытрим ТОЛЬКО нужные нам сообщения в журнале
endsub

################################################################################
########################                       #################################
########################  # # ### # # ### # #  #################################
########################  ##  # # ### ##  # #  #################################
########################  # # ### # # ### #### #################################
########################                       #################################
################################################################################

sub mama() ; закрывает все используемые скрипты
   uo.exec('terminate all')
   uo.print ("Все скрипты завершены")
end sub
