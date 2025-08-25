<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xfn="http://www.w3c.org/functions"
    exclude-result-prefixes="xfn">

    <xsl:output method="html" encoding="UTF-8" indent="yes" version="5.0"/>

    <!-- ==================== general starting point ==================== -->
    <xsl:template match="/">
        <div class="xmlArea">
            <xsl:apply-templates select="*"/>
        </div>
    </xsl:template>

    <!-- ==================== node processing ==================== -->
    <xsl:template match="*|text()[normalize-space(.) != '']|processing-instruction()|comment()">
        <div class="nodeArea">
            <div>
                <xsl:attribute name="class">
                    <!-- set correct styling for particular tree component -->
                    <xsl:choose>
                        <xsl:when test="not(ancestor::*)">
                            <xsl:text>rootNodeWrapper</xsl:text>
                        </xsl:when>
                        <xsl:when test="(following-sibling::* or following-sibling::text()[normalize-space(.) != ''] or following-sibling::processing-instruction() or following-sibling::comment()) and not(*)">
                            <xsl:text>lastLeafNodeWrapper</xsl:text>
                        </xsl:when>
                        <xsl:when test="following-sibling::* or following-sibling::text()[normalize-space(.) != ''] or following-sibling::processing-instruction() or following-sibling::comment()">
                            <xsl:text>lastNodeWrapper</xsl:text>
                        </xsl:when>
                        <xsl:when test="not(*)">
                            <xsl:text>leafNodeWrapper</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>generalNodeWrapper</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <div>
                    <xsl:attribute name="class">
                        <!-- set correct styling for particular node type -->
                        <xsl:choose>
                            <xsl:when test="self::*">
                                <xsl:text>elementNode</xsl:text>
                            </xsl:when>
                            <xsl:when test="self::processing-instruction()">
                                <xsl:text>piNode</xsl:text>
                            </xsl:when>
                             <xsl:when test="self::comment()">
                                <xsl:text>commentNode</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>textNode</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                    <xsl:choose>
                        <!-- display node content correctly -->
                        <xsl:when test="self::*">
                            <div class="elementNodeName">
                                <xsl:value-of select="name()"/>
                            </div>
                            <div class="elementNodeAttributes">
                                <xsl:for-each select="@*">
                                    <div>
                                        <xsl:value-of select="concat(name(),': ')"/>
                                        <xsl:for-each select="tokenize(.,'\n')">
                                            <i><xsl:value-of select="."/></i>
                                            <br/>
                                        </xsl:for-each>
                                    </div>
                                </xsl:for-each>
                            </div>
                        </xsl:when>
                        <xsl:when test="self::processing-instruction()">
                            <div class="piNodeName">
                                <xsl:value-of select="name()"/>
                            </div>
                            <div class="piNodeValue">
                                <xsl:for-each select="tokenize(.,'\n')">
                                    <xsl:value-of select="."/>
                                    <br/>
                                </xsl:for-each>
                            </div>
                        </xsl:when>
                        <xsl:when test="self::comment()">
                             <xsl:value-of select="."/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:for-each select="tokenize(.,'\n')">
                                <xsl:value-of select="."/>
                                <br/>
                            </xsl:for-each>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </div>
            <div class="childNodesWrapper">
                <xsl:apply-templates select="*|text()[normalize-space(.) != '']|processing-instruction()|comment()"/>
            </div>
        </div>
        <xsl:if test="following-sibling::* or following-sibling::text()[normalize-space(.) != ''] or following-sibling::processing-instruction() or following-sibling::comment()">
            <div class="nodeDelimiter"/>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
