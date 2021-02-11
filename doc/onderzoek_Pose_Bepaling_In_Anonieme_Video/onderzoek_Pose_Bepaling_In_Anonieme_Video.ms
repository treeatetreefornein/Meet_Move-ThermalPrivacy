.TL
Pose Bepaling In Anonieme Thermische Beelden
.AU
Van Hout C., Thom
.AI
Innosportlab
.br
Sport & Beweeg!
.AB
Vergelijk pose estimation resultaten van de verschillende anonimiseringsmethoden
.AE

.NH
Samenvatting
.PP

.NH
Inhoud
.PP

.NH
Begrippen
.LP
Een aantal veelvoorkomende begrippen
Begrip      @ Betekenis
Pose Estimation

.NH
Onderzoeksvragen
.NH 2
Hoofdvraag
.PP
.BL
Welke invloed heeft ieder van de anonimiseringsmethoden op de effectiviteit van pose estimation?
.NH 2
Deelvragen
.PP
.BL
Hoe kunnen lichaamsposen verkregen worden uit video beelden?
.BL
Hoe kan de invloed van de anonimiseringsmethoden gemeten worden?
.BL
Hoe kan onderscheid worden gemaakt tussen lopen, hardlopen en fietsen?
.PP
Ter oriëntatie op activiteiten bepalen uit pose, wordt onderzocht of het mogelijk is onderscheid te maken uit bovenstaande activiteiten op basis van snelheid.

.NH
Verwerking
.NH 2
Hoofdvraag
.NH 2
Deelvragen
.BL
Hoe kunnen lichaamsposen verkregen worden uit video beelden?
.PP
OpenPose: 
    * 3d Met meerdere camera's
    * Gemakkelijke kalibratie 
.[
calibration module
.]
voor camera's. 
.RS
Door opnames met een uitgeprint schaakbord op A4 te maken, is het mogelijk de volgende camera eigenschappen te bepalen: vervorming, intrinsic- en extrinsic camera parameters). Een fantastische visualisatie (en uitleg) van deze camera eigenschappen is aan het eind van dit artikel
.[
.]
te vinden.
.RE

.BL
Hoe kan de invloed van de anonimiseringsmethoden gemeten worden?
.PP
Output van OpenPose bestaat uit:
ID
Pose Keypoints
Gezicht Keypoints
Linker Hand
Rechter Hand

Pose Verifier
.NH 3
Resultaten
.PP
Alleen gekeken naar x-coordinaat positie. De confidence waarde geeft wellicht beter inzicht in "de moeite" die OpenPose heeft bij iedere anonimiseringsmethode. Echter blijft deze waarde helaas op 1 tenzij apart naar iedere arm wordt gekeken (niet handig i.v.m. occlusie).

.PSPIC img/visual_vs_8-bit.eps
.PSPIC img/visual_vs_digi.eps
.PSPIC img/visual_vs_exp1.eps
.PSPIC img/visual_vs_exp2.eps
.PSPIC img/visual_vs_noise.eps

.NH 2
Dataset
.NH 3
FLIR
.NH 3
CRS


.NH
JSON Parsing
* Protobuf: https://developers.google.com/protocol-buffers/docs/reference/cpp/google.protobuf.util.json_util

.NH
Openpose
.NH 2
Setup
.PP
Docker Openpose
.NH 2
Settings
.PP
- Net-resolution meervouden van 16
- De "--flir-camera" optie is bestemd voor een fysieke camera
## Output
pose2d: x0, y0, c0, x1, y1, c1,...
[img body parts]
## Ingebouwde Interpolatie (helaas geen lage resolutie vriendelijk voor AMG8833 ~mix bilinear filtering/nearest neighbor): https://docs.opencv.org/3.4/da/d54/group__imgproc__transform.html

.NH
Dataset
.PP
De FLIR dataset heeft de beste resolutie en annotated objecten. Deze dataset is echter niet ideaal om de afwijking in pose te meten. De thermische en visuele camera zijn namelijk out of sync en hebben een andere FOV.

* Fieters
* Voetgangers
* Hardlopers
== Google Colab
Zorg dat GPU runtime enabled is!
== Type
8-bit thermal camera

== Keuze ==
* Korte clips, anders 30s ~30m

.NH
OpenPose
.NH 2
Keuze
.PP
Alphapose heeft hogere score => Niet genoeg V-RAM
.SH 2 
Issues
.PP
1) Geen mensen in beeld => ~1.5x langzamer

# Net resolutions: Optimal -> Less: 1312x736 (Out of Memory)
# Default: 16*82, 16*46
#   "1152x576" => 1/2 hours for 1:30 min video

== Conclusie
* FLIR: camera's out of sync => Pose RGB != Pose Thermal

* Confidence Score
* Afwijking Pose

!!!!!!!!!! FLIR kan NIET door glas zien

.TC
