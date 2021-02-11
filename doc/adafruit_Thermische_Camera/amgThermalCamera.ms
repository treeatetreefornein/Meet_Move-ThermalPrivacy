.EQ
delim ##
.EN

.TL
AMG8833 Thermische Camera

.NH
Inleiding
.PP 
Deze camera module is aangeschaft tijdens de fase waarin de bedoeling was de anonimiseringsmethoden in hardware toe te passen. De AMG8833 is namelijk (voor een thermische camera) een goedkope test camera, het stukmaken is geen ramp.

.NH
AMG8833
.PP
De AMG8833 is een 8x8 thermische camera van Adafruit, die tot op 7m menselijke temperaturen kan herkennen. 
Communicatie tussen de camera en Arduino vindt plaats over #I sup 2 C#. Tijdens boot kunnen opties als sleep en interrupts 

.NH
Software
.PP
! De Arduino code is volledig afkomstig van Adafruit (https://github.com/adafruit/Adafruit_AMG88xx), PC code is te vinden in de map Code.
.NH 2
Design
.PP


.NH
Aansluiting
.PP
In de datasheet wordt aangegeven dat de camera stuk kan gaan bij verkeerde aansluiting
.PSPIC img/amgAansluiting.eps

.PP
In onderstaande afbeelding is de AMG data te zien. 
.PP 
Als eerst wordt de geparste data geprint, in het formaat: [value in],[mapped greyscale 0-255]
.PSPIC img/amgErrorData.eps
.I "Wegens een onbekende reden bevat de TTY willekeurige data bij het uitlezen. Alle data vóór het '[' teken wordt daarom genegeerd."

.NH
Demo

.NH
Demo
.PP
In de video "amgVisualisation.mp4" is live visualisatie van de AMG8833 te zien. De volgende activiteiten zijn "te zien":
.RS
00:00 - 00:11 -> Staan voor de camera
.br
00:12 - 00:21 -> Armen in 'O' vorm
.br
00:21 - END   -> Hand/Arm, vingers zijn onherkenbaar
.RE

.PP
.I "Het wazige beeld komt door het vergroten van het 8x8px beeld. OpenCV mist interpolatie bestemd voor lage-resoluties. De oorzaak van de blanke pixel links boven is onbekend. Deze vlek is later in het project verschenen, wellicht is het een bug of schade aan de camera."

.NH
Conclusie
.PP
De 8x8 output is niet voldoende voor OpenPose.
Een resolutie van 8x8 pixels is voldoende om op het oog een bovenlichaam van een mens te herkennen
.[
FLIR how far can you see
.]
, echter niet genoeg voor details als vingers.
