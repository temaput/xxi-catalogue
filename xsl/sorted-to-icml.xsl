<?xml version="1.0" encoding="UTF-8"?>
<!-- sorted-to-icml.xsl -->
<!-- makes the ready to use icml wich is native indesign (incopy) format
     generates price with xml tags, table structure, styles ...
     run in last turn after notsorted-sort on sorted.xml
     -->
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes" encoding="utf-8"/>

    <xsl:template match="/">
        <xsl:processing-instruction name="aid">style="50" type="snippet" readerVersion="6.0" featureSet="513" product="8.0(370)"</xsl:processing-instruction>
        <xsl:processing-instruction name="aid">SnippetType="InCopyInterchange"</xsl:processing-instruction>
        <Document DOMVersion="8.0" Self="d">
            <RootCharacterStyleGroup>
                <CharacterStyle Self="CharacterStyle/$ID/[No character style]" Name="$ID/[No character style]" />
                <CharacterStyle Self="CharacterStyle/заголовок" Name="заголовок">
                </CharacterStyle>
                <CharacterStyle Self="CharacterStyle/город" Name="город">
                </CharacterStyle>
                <CharacterStyle Self="CharacterStyle/издательство" Name="издательство">
                </CharacterStyle>
                <CharacterStyle Self="CharacterStyle/переплет" Name="переплет">
                </CharacterStyle>
                <CharacterStyle Self="CharacterStyle/подзаголовок" Name="подзаголовок">
                </CharacterStyle>
                <CharacterStyle Self="CharacterStyle/дополнительно" Name="дополнительно">
                </CharacterStyle>
            </RootCharacterStyleGroup>
            <RootParagraphStyleGroup>
                <ParagraphStyle Self="ParagraphStyle/$ID/[No paragraph style]" Name="$ID/[No paragraph style]">
                </ParagraphStyle>
                <ParagraphStyle Self="ParagraphStyle/$ID/NormalParagraphStyle" Name="$ID/NormalParagraphStyle" Imported="false" NextStyle="ParagraphStyle/$ID/NormalParagraphStyle" KeyboardShortcut="0 0">
                </ParagraphStyle>
                <ParagraphStyle Self="ParagraphStyle/название_группы" Name="название_группы">
                </ParagraphStyle>
                <ParagraphStyle Self="ParagraphStyle/наименование" Name="наименование">
                </ParagraphStyle>
                <ParagraphStyle Self="ParagraphStyle/автор" Name="автор">
                </ParagraphStyle>
                <ParagraphStyle Self="ParagraphStyle/страниц" Name="страниц">
                </ParagraphStyle>
                <ParagraphStyle Self="ParagraphStyle/код" Name="код">
                </ParagraphStyle>
                <ParagraphStyle Self="ParagraphStyle/цена" Name="цена">
                </ParagraphStyle>
            </RootParagraphStyleGroup>
            <RootCellStyleGroup>
                <CellStyle Self="CellStyle/яч_группа" AppliedParagraphStyle="ParagraphStyle/название_группы" Name="яч_группа">
                </CellStyle>
                <CellStyle Self="CellStyle/яч_наименование" AppliedParagraphStyle="ParagraphStyle/наименование" Name="яч_наименование">
                </CellStyle>
                <CellStyle Self="CellStyle/яч_автор" AppliedParagraphStyle="ParagraphStyle/автор" Name="яч_автор">
                </CellStyle>
                <CellStyle Self="CellStyle/яч_издательство" AppliedParagraphStyle="ParagraphStyle/страниц" Name="яч_издательство">
                </CellStyle>
                <CellStyle Self="CellStyle/яч_код" AppliedParagraphStyle="ParagraphStyle/код" Name="яч_код">
                </CellStyle>
                <CellStyle Self="CellStyle/яч_цена" AppliedParagraphStyle="ParagraphStyle/цена" Name="яч_цена">
                </CellStyle>
            </RootCellStyleGroup>
            <RootTableStyleGroup>
                <TableStyle Self="TableStyle/прайс" Name="прайс">
                </TableStyle>
            </RootTableStyleGroup>
            <XMLTag Self="XMLTag/основной" Name="основной">
            </XMLTag>
            <XMLTag Self="XMLTag/прайс" Name="прайс">
            </XMLTag>
            <XMLTag Self="XMLTag/яч_группа" Name="яч_группа">
            </XMLTag>
            <XMLTag Self="XMLTag/название_группы" Name="название_группы">
            </XMLTag>
            <XMLTag Self="XMLTag/яч_наименование" Name="яч_наименование">
            </XMLTag>
            <XMLTag Self="XMLTag/заголовок" Name="заголовок">
            </XMLTag>
            <XMLTag Self="XMLTag/яч_автор" Name="яч_автор">
            </XMLTag>
            <XMLTag Self="XMLTag/автор" Name="автор">
            </XMLTag>
            <XMLTag Self="XMLTag/яч_издательство" Name="яч_издательство">
            </XMLTag>
            <XMLTag Self="XMLTag/город" Name="город">
            </XMLTag>
            <XMLTag Self="XMLTag/издательство" Name="издательство">
            </XMLTag>
            <XMLTag Self="XMLTag/страниц" Name="страниц">
            </XMLTag>
            <XMLTag Self="XMLTag/переплет" Name="переплет">
            </XMLTag>
            <XMLTag Self="XMLTag/яч_код" Name="яч_код">
            </XMLTag>
            <XMLTag Self="XMLTag/код" Name="код">
            </XMLTag>
            <XMLTag Self="XMLTag/яч_цена" Name="яч_цена">
            </XMLTag>
            <XMLTag Self="XMLTag/цена" Name="цена">
            </XMLTag>
            <XMLTag Self="XMLTag/подзаголовок" Name="подзаголовок">
            </XMLTag>
            <XMLTag Self="XMLTag/дополнительно" Name="дополнительно">
            </XMLTag>
            <Story Self="ud6">
                <XMLElement MarkupTag="XMLTag/основной"> 
                    <XMLElement MarkupTag="XMLTag/прайс" NoTextMarker="true">
                        <Table Self="ud6ieb" ColumnCount="5" AppliedTableStyle="TableStyle/прайс">
                            <xsl:attribute name="BodyRowCount">
                                <xsl:value-of select="count(//группа|//издание)"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="Каталог/группа"/>
                        </Table>
                    </XMLElement>
                </XMLElement>
            </Story>
        </Document>
    </xsl:template>

    <xsl:template match="группа">
        <xsl:variable name="rowCount">
            <xsl:value-of 
                select="count(preceding::группа 
                | preceding::издание
                | ancestor::группа)"/>
        </xsl:variable>
        <Cell ColumnSpan="5" AppliedCellStyle="CellStyle/яч_группа">
            <xsl:attribute name="Name">
                <xsl:text>0:</xsl:text>
                <xsl:value-of select="$rowCount"/>
            </xsl:attribute>
            <XMLElement MarkupTag="XMLTag/яч_группа">
                <ParagraphStyleRange AppliedParagraphStyle="ParagraphStyle/название_группы">
                    <XMLElement MarkupTag="XMLTag/название_группы">
                        <Content><xsl:value-of select="название_группы"/></Content>
                    </XMLElement>
                </ParagraphStyleRange>
            </XMLElement>
        </Cell>
        <xsl:apply-templates select="издание">
        </xsl:apply-templates>
        <xsl:apply-templates select="группа"/>
    </xsl:template>

    <xsl:template match="издание">
        <xsl:variable name="rowCount">
            <xsl:value-of 
                select="count(preceding::группа 
                | preceding::издание
                | ancestor::группа)"/>
        </xsl:variable>
        <Cell AppliedCellStyle="CellStyle/яч_наименование">
            <xsl:attribute name="Name">
                <xsl:text>0:</xsl:text>
                <xsl:value-of select="$rowCount"/>
            </xsl:attribute>
            <XMLElement MarkupTag="XMLTag/яч_наименование">
                <ParagraphStyleRange AppliedParagraphStyle="ParagraphStyle/наименование">
                    <XMLElement MarkupTag="XMLTag/заголовок">
                        <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/заголовок">
                            <Content><xsl:value-of select="заголовок"/></Content>
                        </CharacterStyleRange>
                    </XMLElement>
                    <XMLElement MarkupTag="XMLTag/подзаголовок">
                        <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/подзаголовок">
                            <Content>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="подзаголовок"/>
                            </Content>
                        </CharacterStyleRange>
                    </XMLElement>
                </ParagraphStyleRange>
            </XMLElement>
        </Cell>
        <Cell AppliedCellStyle="CellStyle/яч_автор">
            <xsl:attribute name="Name">
                <xsl:text>1:</xsl:text>
                <xsl:value-of select="$rowCount"/>
            </xsl:attribute>
            <XMLElement  MarkupTag="XMLTag/яч_автор">
                <ParagraphStyleRange AppliedParagraphStyle="ParagraphStyle/автор">
                    <XMLElement MarkupTag="XMLTag/автор">
                        <Content><xsl:value-of select="автор"/></Content>
                    </XMLElement>
                </ParagraphStyleRange>
            </XMLElement>
        </Cell>
        <Cell AppliedCellStyle="CellStyle/яч_издательство">
            <xsl:attribute name="Name">
                <xsl:text>2:</xsl:text>
                <xsl:value-of select="$rowCount"/>
            </xsl:attribute>
            <XMLElement MarkupTag="XMLTag/яч_издательство">
                <ParagraphStyleRange AppliedParagraphStyle="ParagraphStyle/страниц">
                    <XMLElement MarkupTag="XMLTag/город">
                        <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/город">
                            <Content><xsl:value-of select="город"/></Content>
                        </CharacterStyleRange>
                    </XMLElement>
                    <Content>: </Content>
                    <XMLElement MarkupTag="XMLTag/издательство">
                        <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/издательство">
                            <Content><xsl:value-of select="издательство"/></Content>
                        </CharacterStyleRange>
                    </XMLElement>
                    <Br />
                    <xsl:variable name="cover" select="переплет"/>
                    <xsl:if test="contains($cover, 'переп')">
                        <XMLElement MarkupTag="XMLTag/переплет">
                            <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/переплет">
                                <Content>
                                    <xsl:choose>
                                        <xsl:when 
                                            test="contains($cover, 'супер')">
                                            <xsl:text>тв. пер., суперобл., </xsl:text>
                                        </xsl:when>
                                        <xsl:when
                                            test="contains($cover, 'переп')">
                                            <xsl:text>тв. пер., </xsl:text>
                                        </xsl:when>
                                    </xsl:choose>
                                </Content>
                            </CharacterStyleRange>
                        </XMLElement>
                    </xsl:if>
                    <xsl:if test="страниц != ''">
                        <XMLElement MarkupTag="XMLTag/страниц">
                            <Content><xsl:value-of select="страниц"/></Content>
                        </XMLElement>
                        <Content> стр.</Content>
                    </xsl:if>
                    <xsl:if test="дополнительно != ''">
                        <XMLElement MarkupTag="XMLTag/дополнительно">
                            <CharacterStyleRange AppliedCharacterStyle="CharacterStyle/дополнительно">
                                <Content>
                                    <xsl:if test="страниц != ''">
                                        <xsl:text>, </xsl:text>
                                    </xsl:if>
                                    <xsl:value-of select="дополнительно"/></Content>
                            </CharacterStyleRange>
                        </XMLElement>
                    </xsl:if>
                </ParagraphStyleRange>
            </XMLElement>
        </Cell>
        <Cell AppliedCellStyle="CellStyle/яч_код">
            <xsl:attribute name="Name">
                <xsl:text>3:</xsl:text>
                <xsl:value-of select="$rowCount"/>
            </xsl:attribute>
            <XMLElement  MarkupTag="XMLTag/яч_код">
                <ParagraphStyleRange AppliedParagraphStyle="ParagraphStyle/код">
                    <Content>код </Content>
                    <XMLElement MarkupTag="XMLTag/код">
                        <Content><xsl:value-of select="код"/></Content>
                    </XMLElement>
                </ParagraphStyleRange>
            </XMLElement>
        </Cell>
        <Cell AppliedCellStyle="CellStyle/яч_цена">
            <xsl:attribute name="Name">
                <xsl:text>4:</xsl:text>
                <xsl:value-of select="$rowCount"/>
            </xsl:attribute>
            <XMLElement  MarkupTag="XMLTag/яч_цена">
                <ParagraphStyleRange AppliedParagraphStyle="ParagraphStyle/цена">
                    <XMLElement MarkupTag="XMLTag/цена">
                        <Content><xsl:value-of select="цена"/></Content>
                    </XMLElement>
                    <Content> руб.</Content>
                </ParagraphStyleRange>
            </XMLElement>
        </Cell>
    </xsl:template>
</xsl:stylesheet>

