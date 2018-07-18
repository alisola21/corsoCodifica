<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
      <title>TV Guide</title>
      <link rel="stylesheet" href="TVGuide2.css" />
      <script type="text/javascript">
        function toggle(element) {
          if (element.style.display == 'none') {
            element.style.display = 'block';
          } else {
            element.style.display = 'none';
          }
        }
      </script>
    </head>

    <body>
      <h1>TV Guide</h1>
      <xsl:apply-templates select="/TVGuide/Channel" />
    </body>
  </html>
</xsl:template>

<xsl:template match="Channel/Name">
  <h2 class="channel"><xsl:value-of select="." /></h2>
</xsl:template>

<xsl:template match="Program">
  <div>
    <p>
      <span class="date"><xsl:apply-templates select="Start" /></span>
      <br />
      <xsl:apply-templates select="Series" />
      <br />
      <xsl:apply-templates select="Description" />
      <span onclick="toggle({Series}Cast);">[Cast]</span>
    </p>
    <div id="{Series}Cast" style="display: none;">
      <ul class="castlist">
        <xsl:apply-templates select="CastList/CastMember" />
      </ul>
    </div>
  </div>
</xsl:template>

<xsl:template match="Series">
 <span class="title"><xsl:value-of select="." /></span>
</xsl:template>

<xsl:template match="CastMember">
  <li>
    <xsl:apply-templates select="Character" />
    <xsl:apply-templates select="Actor" />
  </li>
</xsl:template>

<xsl:template match="Character" priority="2">
  <span class="character">
    <xsl:next-match />
  </span>
</xsl:template>

<xsl:template match="CastMember/Character">
  <xsl:apply-templates select="Name" />
</xsl:template>

<xsl:template match="Actor" priority="2">
  <span class="actor">
    <xsl:next-match />
  </span>
</xsl:template>

<xsl:template match="CastMember/Actor">
  <xsl:apply-templates select="Name" />
</xsl:template>

<xsl:template match="Description//Link">
  <a href="{@href}">
    <xsl:apply-templates />
  </a>
</xsl:template>

<xsl:template match="Description//Program">
  <span class="program"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="Description//Series">
  <span class="series"><xsl:apply-templates /></span>
</xsl:template>

<xsl:template match="Description//Channel">
  <span class="channel"><xsl:apply-templates /></span>
</xsl:template>

</xsl:stylesheet>