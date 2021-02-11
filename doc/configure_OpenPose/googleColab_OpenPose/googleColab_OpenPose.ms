.de BL
.IP \(bu
..

.de AD
.RS
\[dA]
.RE
..

.EQ
delim ##
.EN

.=---------------------------------------------------------------=.

.TL
OpenPose Voor Google Colab 

.NH
Samenvatting
.PP
In dit document wordt OpenPose opgezet in een remote omgeving.
.PP
Google Colaboratory geeft gebruikers de mogelijkheid gratis python code op hun servers uit te voeren. De servers hebben GPU support, dit maakt het ideaal voor OpenPose.  

.NH
Installatie
.PP
Prerequisites: 
.RS
    Een video met mensen erin, een Google account.
.RE
.PP
Setup Instructies:
.br
.RS
    1) Open "OpenPose.ipynb" in Google Colab (in portfolio map "code")
.br
    2) Zorg dat GPU mode aan staat! (Runtime->Change Runtime Type->GPU)
.br
    3) Run het eerste code block om OpenPose te installeren
.RE

.NH
Gebruik
.LP
1) Video Input
.RS
    A) Upload een video in de map "content" (open "File" tab en klik upload bovenaan)
.br
    B) Bewerk in het tweede code block de variable "video=[Input Video]" naar de gewenst video
.RE
2) Start Pose Estimation door het tweede code block te starten
.br
3) Zip de output (video+json) door het derde codeblock te starten
.br
4) Download het bestand "output.zip"

.PSPIC img/colabDone.eps
.PP 
.I "De data is klaar om gezipt te worden wanneer FFMPEG de video heeft geconverteerd."

.br
Input: Video
.br
Output: coördinaten in JSON (gehele lichaam, van één persoon)

.NH
Tips
.PP
.BL
Na inactiviteit wordt de runtime gereset. Hierdoor zal bovenstaande installatie telkens opnieuw uitgevoerd moeten worden. Het is echter wel mogelijk de input bestanden te koppelen via Google Drive, deze hoeven dan niet opnieuw geüpload te worden
.BL
Om meerdere mensen te tracken: Verwijder de flags "--number_people_max 1" en "--tracking 1". Alle people ID's worden als bijproduct op -1 gezet. Bovendien wordt nu, door OpenPose, het bepalen van posen minder accuraat uitgevoerd.
.BL
De waarde van "--net-resolution" heeft een grote invloed op snelheid (en kwaliteit), des te lager, des te sneller. Let op dat deze getallen een meervoud van 16 eisen te zijn. 
