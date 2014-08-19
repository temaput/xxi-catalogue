<?xml version="1.0"?>
<!-- Creating catalog structure from flat xml exported from 1C -->
<!-- this is first to run
     creates notsorted.xml
     arranges all units inside the tree structure wich will
     form the contents of the new catalog
     the structure is from data:contents
     additional sequences are in data:sequence
     -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:data="http://classica21.ru/catalogue" >
    <xsl:output method="xml" indent="yes" encoding="utf-8"/>

    <xsl:preserve-space elements="data:*"/>
    <xsl:strip-space elements="*"/>
    <xsl:key name="by-group" match="издание" use="concat(тип, '+', группа)"/>
    <xsl:key name="by-series" match="издание" 
        use="concat(тип, '+', группа, '+', серия)"/>

    <xsl:key name="sequences" match="sequence" use="first"/>
    <xsl:key name="series" match="издание" use="серия"/>


    <data:contents>
        <!-- here we give the whole structure of the new catalog
             included groups types and series correspond to 1C -->
        <group>
            <name>Учебно-методическая литература</name>
            <included-groups>
                <groupdef>ФОРТЕПИАНО</groupdef>
                <groupdef>СОЛЬФЕДЖИО, ТЕОРИЯ МУЗЫКИ</groupdef>
                <groupdef>ВОПРОСЫ МУЗЫКАЛЬНОГО ОБРАЗОВАНИЯ</groupdef>
                <groupdef>БАЯН, АККОРДЕОН</groupdef>
                <groupdef>ВОКАЛ</groupdef>
                <groupdef>РАЗВИТИЕ ТВОРЧЕСКИХ СПОСОБНОСТЕЙ</groupdef>
                <groupdef>СКРИПКА</groupdef>
                <groupdef>ПЕДАГОГИКА</groupdef>
                <groupdef>НОВОЕ ОБРАЗОВАНИЕ</groupdef>
                <groupdef>КОМПЬЮТЕР ДЛЯ МУЗЫКАНТА</groupdef>
                <groupdef>ПОСОБИЯ ПО ИЗО</groupdef>
            </included-groups>
            <included-types>
                <typedef>Методическая литература</typedef>
                <typedef>Книги</typedef>
            </included-types>
        </group>
        <group>
            <name>Книги о музыке и музыкантах</name>
            <included-groups>
                <groupdef>КНИГИ О МУЗЫКЕ И МУЗЫКАНТАХ</groupdef>
                <groupdef>ЭНЦИКЛОПЕДИИ, СЛОВАРИ, СПРАВОЧНИКИ</groupdef>
            </included-groups>
            <included-types>
                <typedef>Книги</typedef>
                <typedef>Комплект (книга + СD)</typedef>
                <typedef>DVD-ROM</typedef>
            </included-types>
        </group>
        <group>
            <name>Учебные программы</name>
            <included-groups>
                <groupdef>РАЗВИТИЕ ТВОРЧЕСКИХ СПОСОБНОСТЕЙ</groupdef>
                <groupdef>ПОДБОР ПО СЛУХУ, ИМПРОВИЗАЦИЯ, КОМПОЗИЦИЯ</groupdef>
                <groupdef>СИНТЕЗАТОР</groupdef>
                <groupdef>СЛУШАНИЕ МУЗЫКИ</groupdef>
                <groupdef>ФОРТЕПИАНО</groupdef>
                <groupdef>ГИТАРА</groupdef>
                <groupdef>БАЯН, АККОРДЕОН</groupdef>
                <groupdef>ХОР</groupdef>
                <groupdef>БАЛАЛАЙКА</groupdef>
                <groupdef>ДОМРА</groupdef>
                <groupdef>ВОПРОСЫ МУЗЫКАЛЬНОГО ОБРАЗОВАНИЯ</groupdef>
            </included-groups>
            <included-types>
                <typedef>Учебные программы</typedef>
            </included-types>
        </group>
        <group>
            <name>Учебные пособия</name>
            <subgroups>
                <group>
                    <name>Сольфеджио, теория музыки</name>
                    <subgroups>
                        <group>
                            <name>Учебники и учебные пособия</name>
                            <included-groups>
                                <groupdef>СОЛЬФЕДЖИО, ТЕОРИЯ МУЗЫКИ</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>игровое пособие</typedef>
                                <typedef>Книги</typedef>
                                <typedef>Ноты</typedef>
                                <typedef>Ноты + CD</typedef>
                                <typedef>Плакаты, дипломы и прочее</typedef>
                                <typedef>Учебники и учебные пособия</typedef>
                            </included-types>
                        </group>
                        <group>
                            <name>Рабочие тетради</name>
                            <included-groups>
                                <groupdef>СОЛЬФЕДЖИО, ТЕОРИЯ МУЗЫКИ</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>Рабочие тетради</typedef>
                            </included-types>
                        </group>
                    </subgroups>
                </group>
                <group>
                    <name>Слушание музыки</name>
                    <included-groups>
                        <groupdef>СЛУШАНИЕ МУЗЫКИ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Audio-CD</typedef>
                        <typedef>MP3-CD</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                        <typedef>Ноты</typedef>
                        <typedef>Ноты + CD</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Музыкальная литература</name>
                    <subgroups>
                        <group>
                            <name>Учебные пособия</name>
                            <included-groups>
                                <groupdef>МУЗЫКАЛЬНАЯ ЛИТЕРАТУРА, ИСТОРИЯ МУЗЫКИ</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>DVD-Video</typedef>
                                <typedef>DVD-ROM</typedef>
                                <typedef>Книги</typedef>
                                <typedef>Ноты</typedef>
                                <typedef>Учебные пособия + CD</typedef>
                                <typedef>Учебники и учебные пособия</typedef>
                            </included-types>
                        </group>
                        <group>
                            <name>Рабочие тетради</name>
                            <included-groups>
                                <groupdef>МУЗЫКАЛЬНАЯ ЛИТЕРАТУРА, ИСТОРИЯ МУЗЫКИ</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>Рабочие тетради</typedef>
                            </included-types>
                        </group>
                        <group>
                            <name>Серия "Знакомство с шедеврами классики"</name>
                            <included-groups>
                                <groupdef>МУЗЫКАЛЬНАЯ ЛИТЕРАТУРА, ИСТОРИЯ МУЗЫКИ</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>Учебники и учебные пособия</typedef>
                            </included-types>
                            <included-series>
                                <seriesdef>Знакомство с шедеврами классики</seriesdef>
                            </included-series>
                        </group>
                        <group>
                            <name>Серия "Великие композиторы. Жизнь и творчество"</name>
                            <included-groups>
                                <groupdef>МУЗЫКАЛЬНАЯ ЛИТЕРАТУРА, ИСТОРИЯ МУЗЫКИ</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>Книги</typedef>
                            </included-types>
                            <included-series>
                                <seriesdef>Великие композиторы. Жизнь и творчество</seriesdef>
                            </included-series>
                        </group>
                    </subgroups>
                </group>
                <group>
                    <name>Клавиры</name>
                    <included-groups>
                        <groupdef>ОПЕРА</groupdef>
                        <groupdef>ОПЕРЕТТА. МЮЗИКЛ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Ноты (клавиры)</typedef>
                        <typedef>Ноты</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Оперы на DVD</name>
                    <included-groups>
                        <groupdef>ОПЕРА</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>DVD-ROM</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Балеты на DVD</name>
                    <included-groups>
                        <groupdef>БАЛЕТ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>DVD-ROM</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Ритмика</name>
                    <included-groups>
                        <groupdef>РИТМИКА</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Игровые пособия</typedef>
                        <typedef>Методическая литература</typedef>
                        <typedef>Ноты</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Развитие музыкальных способностей</name>
                    <included-groups>
                        <groupdef>РАЗВИТИЕ ТВОРЧЕСКИХ СПОСОБНОСТЕЙ</groupdef>
                        <groupdef>МУЗЫКА В ДЕТСКОМ САДУ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Игровые пособия</typedef>
                        <typedef>игровое пособие</typedef>
                        <typedef>Книги</typedef>
                        <typedef>Аудиокниги</typedef>
                        <typedef>Ноты</typedef>
                        <typedef>Audio-CD</typedef>
                        <typedef>MP3-CD</typedef>
                        <typedef>DVD-Video</typedef>
                        <typedef>Учебные пособия + CD</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                    </included-types>
                    <subgroups>
                        <group>
                            <name>Серия "Теория и практика начального музыкально обучения"</name>
                            <included-groups>
                                <groupdef>РАЗВИТИЕ ТВОРЧЕСКИХ СПОСОБНОСТЕЙ</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>Учебники и учебные пособия</typedef>
                            </included-types>
                            <included-series>
                                <seriesdef>Теория и практика начального музыкально обучения</seriesdef>
                            </included-series>
                        </group>
                    </subgroups>
                </group>
            </subgroups>
        </group>
        <group>
            <name>Орф-педагогика</name>
            <included-groups>
                <groupdef>ОРФ-ПЕДАГОГИКА</groupdef>
            </included-groups>
            <included-types>
                <typedef>Учебники и учебные пособия</typedef>
                <typedef>Ноты</typedef>
                <typedef>ноты</typedef>
                <typedef>Книги</typedef>
            </included-types>
        </group>
        <group>
            <name>Детский музыкальный театр</name>
            <included-groups>
                <groupdef>ДЕТСКИЙ МУЗЫКАЛЬНЫЙ ТЕАТР</groupdef>
            </included-groups>
            <included-types>
                <typedef>Ноты</typedef>
                <typedef>Ноты + CD</typedef>
                <typedef>ноты</typedef>
            </included-types>
        </group>
        <group>
            <name>Нотные издания</name>
            <subgroups>
                <group>
                    <name>Фортепиано</name>
                    <subgroups>
                        <group>
                            <name>Учебные пособия для начинающих</name>
                            <included-groups>
                                <groupdef>УЧЕБНЫЕ ПОСОБИЯ ДЛЯ НАЧИНАЮЩИХ</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>Ноты</typedef>
                                <typedef>Учебники и учебные пособия</typedef>
                            </included-types>
                        </group>
                        <group>
                            <name>Репертуар ДМШ</name>
                            <included-groups>
                                <groupdef>РЕПЕРТУАР ДМШ</groupdef>
                                <groupdef>РЕПЕРТУАР УЧИЛИЩ И ВУЗОВ</groupdef>
                                <groupdef>ФОРТЕПИАНО</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>Ноты</typedef>
                                <typedef>Учебники и учебные пособия</typedef>
                                <typedef>Ноты + CD</typedef>
                                <typedef>Учебные пособия + DVD</typedef>
                            </included-types>
                        </group>
                        <group>
                            <name>Серия "Мастер-класс Александра Майкапара"</name>
                            <included-groups>
                                <groupdef>ФОРТЕПИАНО</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>Ноты</typedef>
                            </included-types>
                            <included-series>
                                <seriesdef>Мастер-класс Александра Майкапара</seriesdef>
                            </included-series>
                        </group>
                        <group>
                            <name>Джаз за фортепиано</name>
                            <included-groups>
                                <groupdef>ДЖАЗ</groupdef>
                            </included-groups>
                            <included-types>
                                <typedef>Ноты</typedef>
                            </included-types>
                        </group>
                    </subgroups>
                </group>
                <group>
                    <name>Подбор по слуху, импровизация, композиция</name>
                    <included-groups>
                        <groupdef>ПОДБОР ПО СЛУХУ, ИМПРОВИЗАЦИЯ, КОМПОЗИЦИЯ</groupdef>
                        <groupdef>ПОСОБИЯ ДЛЯ КОНЦЕРТМЕЙСТЕРОВ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Ноты</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                        <typedef>игровое пособие</typedef>
                        <typedef>Игровые пособия</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Фортепианные  ансамбли (в 4 руки, 2 ф-п.)</name>
                    <included-groups>
                        <groupdef>ФОРТЕПИАННЫЕ АНСАМБЛИ</groupdef>
                        <groupdef>АНСАМБЛИ ДЛЯ ДВУХ ФОРТЕПИАНО</groupdef>
                        <groupdef>АНСАМБЛИ ДЛЯ ФОРТЕПИАНО В 4 РУКИ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Ноты</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Синтезатор</name>
                    <included-groups>
                        <groupdef>СИНТЕЗАТОР</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Ноты</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Скрипка</name>
                    <included-groups>
                        <groupdef>СКРИПКА</groupdef>
                        <groupdef>ВИОЛОНЧЕЛЬ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Ноты</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Духовые и ударные инструменты</name>
                    <included-groups>
                        <groupdef>ТРУБА</groupdef>
                        <groupdef>ГОБОЙ</groupdef>
                        <groupdef>ФЛЕЙТА, БЛОКФЛЕЙТА</groupdef>
                        <groupdef>САКСОФОН</groupdef>
                        <groupdef>КЛАРНЕТ</groupdef>
                        <groupdef>УДАРНЫЕ ИНСТРУМЕНТЫ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Ноты</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Гитара</name>
                    <included-groups>
                        <groupdef>ГИТАРА</groupdef>
                        <groupdef>ГИТАРНЫЕ АНСАМБЛИ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Книги</typedef>
                        <typedef>Ноты</typedef>
                        <typedef>Ноты + CD</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Домра / Балалайка</name>
                    <included-groups>
                        <groupdef>БАЛАЛАЙКА</groupdef>
                        <groupdef>ДОМРА</groupdef>
                        <groupdef>ОРКЕСТРЫ И АНСАМБЛИ РУССКИХ НАРОДНЫХ ИНСТРУМЕНТОВ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Ноты</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Баян / Аккордеон</name>
                    <included-groups>
                        <groupdef>БАЯН, АККОРДЕОН</groupdef>
                        <groupdef>АНСАМБЛИ ДЛЯ БАЯНА И АККОРДЕОНА</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Ноты</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Домашнее музицирование</name>
                    <included-groups>
                        <groupdef>ДОМАШНЕЕ МУЗИЦИРОВАНИЕ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Ноты</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Хор / Вокал</name>
                    <included-groups>
                        <groupdef>ХОР</groupdef>
                        <groupdef>ВОКАЛ</groupdef>
                        <groupdef>ПЕСНИ ДЛЯ ДЕТЕЙ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Ноты</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                        <typedef>Учебные пособия + DVD</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Хореография / Пособия для концертмейстеров</name>
                    <included-groups>
                        <groupdef>ХОРЕОГРАФИЯ</groupdef>
                        <groupdef>БАЛЕТ</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>Книги</typedef>
                        <typedef>DVD-Video</typedef>
                        <typedef>Ноты</typedef>
                        <typedef>Учебники и учебные пособия</typedef>
                    </included-types>
                </group>
            </subgroups>
        </group>
        <group>
            <name>Видео и аудио продукция</name>
            <subgroups>
                <group>
                    <name>Серия «Рус. исп. школа» на DVD</name> 
                    <included-groups>
                        <groupdef>ФОРТЕПИАНО</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>DVD-ROM</typedef>
                    </included-types>
                </group>
                <group>
                    <name>Концерты выдающихся музыкантов в формате mp3</name> 
                    <included-groups>
                        <groupdef>ФОРТЕПИАНО</groupdef>
                    </included-groups>
                    <included-types>
                        <typedef>MP3-CD</typedef>
                    </included-types>
                </group>
            </subgroups>
        </group>
        <group>
            <name>Изобразительное искусство</name>
            <included-groups>
                <groupdef>ПОСОБИЯ ПО ИЗО</groupdef>
            </included-groups>
            <included-types>
                <typedef>DVD-Video</typedef>
                <typedef>Учебные пособия + CD</typedef>
                <typedef>Книги</typedef>
                <typedef>Учебники и учебные пособия</typedef>
                <typedef>Учебные пособия + DVD</typedef>
            </included-types>
        </group>
        <group>
            <name>Декоративно-прикладное творчество</name>
            <included-groups>
                <groupdef>ДОМАШНЕЕ ТВОРЧЕСТВО</groupdef>
                <groupdef>ДЕКОРАТИВНО-ПРИКЛАДНОЕ ТВОРЧЕСТВО</groupdef>
            </included-groups>
            <included-types>
                <typedef>Книги</typedef>
            </included-types>
        </group>
        <group>
            <name>Детское творчество</name>
            <included-groups>
                <groupdef>ПОСОБИЯ ПО ДЕТСКОМУ ТВОРЧЕСТВУ</groupdef>
                <groupdef>ОБЩЕРАЗВИВАЮЩАЯ ЛИТЕРАТУРА ДЛЯ ДЕТЕЙ</groupdef>
            </included-groups>
            <included-types>
                <typedef>DVD-Video</typedef>
                <typedef>Книги</typedef>
            </included-types>
        </group>
        <group>
            <name>Библиотека директора школы</name>
            <included-groups>
                <groupdef>МЕНЕДЖМЕНТ В СФЕРЕ КУЛЬТУРЫ / ТВОРЧЕСКИЕ ИНДУСТРИИ</groupdef>
                <groupdef>БИБЛИОТЕКА ДИРЕКТОРА ШКОЛЫ</groupdef>
            </included-groups>
            <included-types>
                <typedef>Книги</typedef>
            </included-types>
        </group>
        <group>
            <name>Дневники / Оформление классов</name>
            <included-groups>
                <groupdef>Сумки разные</groupdef>
                <groupdef>Прочее</groupdef>
                <groupdef>Канцтовары</groupdef>
                <groupdef>ПОРТРЕТЫ КОМПОЗИТОРОВ</groupdef>
            </included-groups>
            <included-types>
                <typedef>Плакаты, дипломы и прочее</typedef>
                <typedef>Плакаты, дипломы, грамоты</typedef>
                <typedef>Сувенирная продукция</typedef>
            </included-types>
        </group>
    </data:contents>
    <data:sequences>
        <!-- this is for "unnamed series" where some units must 
             be attached to each other
             name is optional but in top it will appear as the name of
             series
             -->
        <sequence>
            <name>Сольфеджио: серия учебников изд-ва Кифара</name>
            <first>2110</first>
            <attached>
                <item>6787</item>
            </attached>
        </sequence>
        <sequence>
            <name>Мир музыки Первозванской. Учебники</name>
            <first>1675</first>
            <attached>
                <item>2616</item>
                <item>2619</item>
                <item>2623</item>
            </attached>
        </sequence>
        <sequence>
            <name>Мир музыки Первозванской. Рабочие тетради</name>
            <first>1907</first>
            <attached>
                <item>2614</item>
                <item>2618</item>
                <item>2622</item>
            </attached>
        </sequence>
        <sequence>
            <name>Сольфеджио: серия учебников для ДМШ издательства Владос</name>
            <first>6552</first>
            <attached>
                <item>6553</item>
                <item>6554</item>
                <item>6555</item>
                <item>6556</item>
            </attached>
        </sequence>
        <sequence>
            <name>Сольфеджио: серия учебников для ДМШ издательства Музыка</name>
            <first>4844</first>
            <attached>
                <item>4845</item>
                <item>4846</item>
                <item>4847</item>
                <item>4848</item>
                <item>4849</item>
            </attached>
        </sequence>
        <sequence>
            <name>Музлитература: изда-во Композитор</name>
            <first>1312</first>
            <attached>
                <item>1313</item>
                <item>1913</item>
                <item>2626</item>
                <item>2627</item>
            </attached>
        </sequence>
        <sequence>
            <name>Музлитература: серия учебников издательства Музыка</name>
            <first>4736</first>
            <attached>
                <item>4729</item>
                <item>4818</item>
                <item>4768</item>
            </attached>
        </sequence>
    </data:sequences>

    <xsl:variable name="contents" select="document('')/*/data:contents"/>
    <xsl:variable name="sequences" select="document('')/*/data:sequences"/>
    <xsl:variable name="source" select="/"/>

    <xsl:template match="/">
        <Каталог>
            <data:sequences>
                <xsl:for-each select="$sequences/sequence">
                    <xsl:copy-of select="."/>
                </xsl:for-each>
                <!-- here we need to collect all natural sequences based on 
                     their series name -->
                <xsl:for-each
                    select="//издание[count(. | key('series', серия)[1]) = 1]">
                    <xsl:sort select="серия"/>
                    <xsl:variable name="serieName" select="серия"/>
                    <xsl:if test="$serieName != '' and count(key('series', $serieName)) &gt; 1">
                        <sequence>
                            <name><xsl:value-of select="$serieName"/></name>
                                <xsl:for-each
                                    select="key('series', $serieName)">
                                    <xsl:sort select="код" data-type="number"/>
                                    <xsl:if test="position()=1">
                                        <first><xsl:value-of select="код"/></first>
                                    </xsl:if>
                                </xsl:for-each>
                                <attached>
                                    <xsl:for-each
                                        select="key('series', $serieName)">
                                        <xsl:sort select="код" data-type="number"/>
                                        <xsl:if test="position() &gt; 1">
                                            <item><xsl:value-of select="код"/></item>
                                        </xsl:if>
                                    </xsl:for-each>
                                </attached>
                        </sequence>
                    </xsl:if>
                </xsl:for-each>
            </data:sequences>
            <xsl:apply-templates select="$contents/group"/>
        </Каталог>
    </xsl:template>

    <xsl:template match="data:contents//group">
        <группа>
            <название_группы><xsl:value-of select="name"/></название_группы>
            <xsl:apply-templates select="included-groups/groupdef">
            </xsl:apply-templates>
            <xsl:apply-templates select="subgroups/group"/>
        </группа>
    </xsl:template>

    <xsl:template match="groupdef">
        <xsl:variable name="groupName" select="."/>
        <xsl:apply-templates select="ancestor::group[1]/included-types/typedef">
            <xsl:with-param name="groupName" select="$groupName"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="typedef">
        <xsl:param name="groupName"/>
        <xsl:variable name="typeName" select="."/>
        <xsl:choose>
            <xsl:when test="ancestor::group[1]/included-series">
                <xsl:apply-templates 
                    select="ancestor::group[1]/included-series/seriesdef">
                    <xsl:with-param name="groupName" select="$groupName"/>
                    <xsl:with-param name="typeName" select="$typeName"/>
                </xsl:apply-templates>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates select="$source/Каталог">
                    <xsl:with-param name="groupName" select="$groupName"/>
                    <xsl:with-param name="typeName" select="$typeName"/>
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="seriesdef">
        <xsl:param name="groupName"/>
        <xsl:param name="typeName"/>
        <xsl:variable name="seriesName" select="concat('+', .)"/>
        <xsl:apply-templates select="$source/Каталог">
            <xsl:with-param name="groupName" select="$groupName"/>
            <xsl:with-param name="typeName" select="$typeName"/>
            <xsl:with-param name="seriesName" select="$seriesName"/>
        </xsl:apply-templates>
    </xsl:template>



    <xsl:template match="Каталог">
        <xsl:param name="groupName"/>
        <xsl:param name="typeName"/>
        <xsl:param name="seriesName"/>
        <xsl:choose>
            <xsl:when test="$seriesName">
                <xsl:apply-templates 
                    select="key('by-series',
                    concat($typeName, '+', $groupName, $seriesName))"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates 
                    select="key('by-group', concat($typeName, '+', $groupName))">
                </xsl:apply-templates>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="издание">
        <xsl:copy>
            <xsl:copy-of select="заголовок"/>
            <xsl:copy-of select="подзаголовок"/>
            <xsl:copy-of select="автор"/>
            <xsl:copy-of select="город"/>
            <xsl:copy-of select="издательство"/>
            <xsl:copy-of select="страниц"/>
            <xsl:copy-of select="дополнительно"/>
            <xsl:copy-of select="переплет"/>
            <xsl:copy-of select="код"/>
            <xsl:copy-of select="цена"/>
            <xsl:copy-of select="серия"/>
            <xsl:variable name="annotation" select="аннотация"/>
            <аннотация>
                <xsl:value-of
                    select="normalize-space(translate($annotation, '&#xA;&#xD;', ''))"/>
            </аннотация>
            <xsl:copy-of select="рейтинг"/>
            <xsl:copy-of select="скорость"/>
            <xsl:variable name="index" select="код"/>
            <xsl:if test="$sequences/sequence[key('sequences', $index)]">
                <xsl:copy-of 
                    select="$sequences/sequence[count(. | key('sequences', $index))=1]/attached"/>
            </xsl:if>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
