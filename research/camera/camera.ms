.RP no
.ND

.EQ
delim ##
.EN

.de BL
.IP \(bu
..

.de BS
.br
\(bu
..

.TL
Camera Onderzoek
.AU
Van Hout C., Thom
.AI
Innosportlab
.br
Sport & Beweeg!
.br
Eindhoven
.AB
Hoe ziet monitoren van activiteiten met een camera in de openbare ruimte eruit?
.AE

.NH
Introductie
.PP
In dit document wordt uitgewerkt hoe activiteiten in een publieke ruimte met een camera bepaalt kunnen worden.

.NH
Probleemstelling
.PP
Om gegevens als activiteiten/3d-positie te verzamelen zijn sensoren vereist, welke camera's kunnen deze taak vervullen?

.NH
Requirements
.PP
De camera zou in iedere openbare ruimte gebruikt moeten kunnen worden, van natuur tot stad. Hierdoor zijn de volgende catagorien het volgende belangrijk:
.TS
tab(@) allbox;
c c c c c
l l l l l.
Physiek         @ Video             @ Audio                 @ Type              @ Feature
Stroom eisen    @ Framerate         @ Nodig? (beweging?)    @ Beweging detectie @\
T{
Wide Dynamic Range
T}
Stroom verbruik @ Resolutie         @                       @ Anti-glare
Dimensies       @ Maximale afstand  @                       @ Auto focus
Poorten         @                   @                       @                   @\
T{
Lens:
.BS
FOV
.BS
Type
T}@
.TE

.NH
Hoofdvragen
.PP
Hoe ziet een goedkoop-, middel- en duur camera systeem eruit?

.NH
Deelvragen
.PP
.nr step 1 1
.IP \n[step] 3
Welke camera's zijn aan te raden?
.IP \n+[step]
Waaraan moet de camera voeldoen?
.IP \n+[step]
Welk algoritme is het best toe te passen?
.IP \n+[step]
Welke PC specs zijn vereist?
.IP \n+[step]
Hoe kan de data in real time verstuurd worden?
.IP \n+[step]
Wat is het energie verbruik?

.NH
Verwerking
.NH 2
Hoofdvragen
.PP
.TS
tab(@) allbox;
c c c
l l l.
Goedkoop    @ Middel    @ Duur
.TE
.NH 2
Deelvragen
.NH 3
Camera
.PP
.TS
tab(@) allbox;
c c c c c c
l l l l l l.
Camera  @ Range @ Resolutie @ Max Afstand @ Lens Type @ Stroom verbruik  
.TE
.NH 3
Wat is het energie verbruik?
.PP
motion detection ~ IR?
.NH 3
Waaraan moet de camera voldoen?
.PP
.TS
tab(@) allbox;
c c c
l l l.
Vision Type @ Voordeel  @ Nadeel
Normaal @\
T{
Goedkoop.
T}@\
T{
Slechte visie in nacht.
T}
Infra Rood  @\
T{
Werkt tijdens regen, mist en rook.
T}@\
T{
.BS
Onzichtbaar in de schaduw van infrarood licht.
.BS
Slechte range (30m).
.[
diffthermalinfrared
.]
.BS
Kan range uitbreiden.
.BS
Een omhulzing ter bescherming kan infrarood licht, uitgezonden door de camera, terug reflecteren.
T}
Thermal Imager @\
T{
.BS
Werkt tijdens regen, mist en rook.
.BS
Goede range (paar km's)
.[
flir
.]
/(5-60km)
.[
longrangeflir
.]
T}@ Ziet alleen hitte.
T{
Fusion (combinatie normaal + IR) 
T}@ Beste beelden @ Duurst
Stereo @ 3d Beeld @\
T{
.BS
Dubbele video transmissie (of verzend 1 beeld + ruwe depth map)
.BS
Korte range
T}
LiDAR @\
T{
.BS
Veel innovatie auto+robotics industrie.
.BS
Accuraat
.BS
360 deg 
.BS
>20m (~120m) al snel $2000
.[
lidarrobotshop
.]
.BS
Meestal bestemd voor buiten
.BS
Werkt 's nachts
T}@\
T{
.BS
Relatief langzaam
.BS
$1000
.BS
Mounting (scherpe hoek)
T}
.TE

.BL
.B M

.BL
.B Nachtvisie:
de camera is gewenst 's nachts door te filmen, denk bijvoorbeeld aan hangjongeren. Camera's met deze mogelijkheid zijn thermische-, 3d- (nachtvisie camera -> useless overdag)
Er bestaan gekoelde- en ongekoelde thermische camera's, de laatste is goedkoper maar heeft een slechtere resolutie.

.BL
.B LiDaR:
is een laser scanning techniek, de laser is veilig zelfs bij langdurige blootstelling aan het oog (Klasse 1).
.[
laserclasses
.]
De smart-auto industrie heeft deze technologie veel ontwikkeld de afgelopen jaren. Het voordeel hiervan is dat tegenwoordig features als object detectie in worden gebouwd. 
.br
Ook moeten sensoren van smart-auto's aan alle "Automotive-grade Requirements" voeldoen.
.[
aecdocuments
.]
Houdt in dat ze weers bestendig zijn en onder extreme temperaturen kunnen opereren. Ook worden de sensoren ontworpen accuraat te blijven tijdens regen of mist.
.[
rsruby
.]
.br
In theorie kan de omgeving eenmalig worden gescanned, vervolgens kan op een ruwe wijze verkend worden naar afwijkende meetingen. Dit kan een boel data schelen die verstuurd hoeft te worden. De ruwe scan bespaard ook stroom.

.BL
.B "Thermal Imaging"
.PP
Passive infrarood camera's steigen al snel in prijs, het voordeel is echter dat ze niet te detecteren zijn. Ook maken deze cameras beter onderscheidt tussen een object dat hitte radieerd en achter een plant staat.

Vlak na zons opgang en vlak na zons ondergang vindt er een "crossover" periode plaats. Tijdens deze hitte overgang hebben Thermische camera's moeite met onderscheidt maken tussen objecten. Des te beter de camera, des te korter deze periode duurt (aantal seconden tot een minuut).

Thermische cameras pikken uitsluitend hitte radiatie op, 's nachts kan dit een probleem zijn met objecten.

//Paper Xandra gebruikt IR camera met GIS. De thermische camera die men gebruikt is de AxisQ1922. 3D Positie wordt bepaald met behulp van een homography matrix. //wiskundige uitleg: https://en.wikipedia.org/wiki/Homography_(computer_vision)

Thermal? 3D? Normal (light environment)?
//high fov
//far range
//deeplearning compatible resolution+framerate
//low energy usage ~ motiondetection?

.TS
tab(@) allbox;
c c c c
l l l l.
Item    @ Privacy   @ Weer (r|s|m|w)    @ Tijd (d|n)    @ 
.TE

.NH 3
Welk algoritme is het best toe te passen?
.PP
.TS
tab(@) allbox;
c c c
l l l.
Pose Estimation @ Object Detectie   @ Positie Detectie
Openpose        @ YOLOv3            @ Filippo 3d Position Estimation
tf-Pose Estimation  @
.TE
.NH 4
Features
.PP
.B Openpose
.RS
.BL
Schakel lichaamsdelen in- of uit
.BL
Selecteer GPU
.BL
Selecteer Webcam
.BL
Genereer Heatmap
.RE

.NH
Vergelijking
.PP
Normale camera zonder extreem hoge ISO zou gebruikt kunnen worden in combinatie met helderheid A.I.. Tegenwoordig is dit echter nog te langzaam om in realtime met volledige resolutieuit te voeren.
.[
seeindark
.]
.TS
tab(@) allbox;
c c c c c c
l l l l l l.
Item    @ Range     @ Power (V|W)   @ Framerate @ Angle(HxVxZ) @ Kosten (EUR) 
T{
.B Normale:
.BS
Canon ME20F-SH
.[
canon20me20f
.]
T}@     @ 11-17VDC | 11W @  @  @ 18.217,53
T{
.B LiDaR:
.BS 
RS-LiDAR-32
.[
rs32
.]
.BS
SICK MRS1104C-111011
.[
mrs1104c
.]
.BS
RS-LiDAR-M1
T}@\
T{

200m

64m

150m
T}@\
T{

9-32V | 13W 

10-30V | 13W (30 max startup 1s)

9-32V | 25W
T}@\
T{

15fps

50Hz

15Hz
T}@\
T{

360x

275x7,5x360

125x25
T}@\
T{

23.400,-

4.350,-
.[
mrssickproductpage
.]
T}
T{
.B Thermisch:
.BS
XT360
.BS
PTQ136 
.BS
TeraRanger Evo Thermal 33
T}@\
T{




13m
T}@\
T{

24-28V | 280W (10A)

3V

5VDC | 75mA
T}@\
T{

2.5Hz

60fps

14Hz
T}@\
T{

360x38

24x19

33x33 - 32x32 resolution
T}@\
T{



2.783,00

160,-
T}@\ 
T{
.B "Infra Rood:"
.BS
AXIS M3057-PLVE
.[
axism3057plve
.]
.BS
Q6035-E PTZ 
T}@\
T{
20m


T}@\
T{
12V | 77m 

57V | 74W
T}@\
T{
25/30fps

60fps@720p 30fps@1080p
T}@\
T{
185x185x360 
T}@\
T{
1.210,87
T}
T{
.B Fusion:
T}@
T{
.B Stereo:
T}@      @  @   @   @ @
T{
.B Radar: 
.BS
People Radar
T}@ 1km @ ?V | 30 W @ ? @ 180x360 @ 
.TE

.NH 2
LiDAR
.PP
.BS
Het bedrijf SICK past people counting toe met hun LiDaR sensoren.
.[
lidarcounting
.]
Echter lukt het mij nergens prijzen te vinden.minder gebruiksvriendelijk + extra rekenkracht/motoren die stuk kunnen gaan.
Het grote voordeel van LiDaR is dat een reflectie index verkregen kan worden bij een scan. Hiermee kan vegetatie uit de scan gefiltered worden. Dit is super voor een omgeving waar belangrijke hoeken blokkeerd worden door bosjes.
.[
autocadpointcloud
.]
.br
Ook heeft dit potentieel een ecologische toepassing, bijvoorbeeld het tellen/indentificeren van dieren in een gebied.
.br
! De automotiveindustrie gebruikt short range.
.br
LiDAR heeft limitaties bij regen, wind en mist.
.[
lidarvsradar
.]
.br
Opvallend is dat Tesla geen LiDAR gebruikt,
.[
teslalidar
.]
 dit is waarschijnlijk omdat de toepassing nog veel te duur is tegenwoordig. Ook kan LiDAR geen kleur herkennen en is er een heleboel ruimte voor error.
.br
Ook is er waarschijnlijk een uniek ontwerp nodig.

.NH 2
Thermal Camera
.PP
3D positie achterhalen lastig (onvoorspelbaar met A.I.) - problemen perspectief, grootte personen. -> Heatmap
OF los resolutie + afstandsdetectie op via rangefinder/radar +moving camera. => minder gebruiksvriendelijk + extra rekenkracht/motoren die stuk kunnen gaan.
.NH 3
PTQ136
.PP
Consumer camera, bevat rails voor gemakkelijke bevestiging. Ook kan er voor een ingebouwd digitaal compass- en inclinometer gekozen worden. Deze gegevens helpen wellicht bij het automatisch richten van de camera.

.NH 2
Radar
.PP
Een radar wordt niet beinvloedt door weersomstandigheden, de people radar
.[
peopleradar
.]
kan mensen (en grotere objecten) en hun snelheid op maximaal 1km afstand tracken. Het maximaal aantal mensen is onbekend.
Een radar zou echter een goede manier zijn erachter te komen waar een nieuw object zich ongeveer bevindt.

.NH
Camera Setup
.NH 2
Lens
.PP
Vind pixel aantal op bepaalde afstand met Nomograph.
.[
flirperformance
.]

//Afvragen / consideraties
- Stereo camera? #-># nadeel = extra computing power costen
- Realtime upscaling? #-># goedkopere camera
- Beweeg camera: Lagere resolutie nodig, sneller, geeft mogelijkheid range-finder toe te voegen/maar maakt A.I positie lastiger. Maar niet fijn een camera op je hebben locken.
- Wind wobble: Los op met hardware, software of train A.I.? ~min GTX 1080.
- LPC camera's -> wss overkill ivbm hoge auto snelheden maar goede inspiratie -> detectie & 's nacht detectie

.NH 2
Camera FOV Upgrade?
https://scantips.com/lights/fieldofview.html //Calculator

.NH
Conclusie
.PP
.TS
tab(@) allbox;
c c c c
c c c c
l l l l.
T{
.B LiDaR
T}@ @\
T{
.B "Thermische Camera"
T}@  
+           @   -               @   +               @ -
T{
.BS
Vegetatie
.BS
Accurate 3d pos
.BS
360 deg beeld
.BS
Werkt 's nachts
.BS
Geen warmte vereist voor detectie
T}@\
T{
.BS
Verminderde accuratie bij stof, regen, sneeuw en mist
.BS
Wind (gyroscopische- + accelerometer sensor vereist)
.BS
Plaatsing
.BS
Veel error mogelijkheid
.BS
Hoog stroom verbruik
T}@\
T{
.BS
Openpose (FLIR)
.BS
Compressie 
.BS
Regen, wind, mist
.BS
Noodgeval backup (aantal uur)
.BS
Gemakkelijke plaatsing
.BS
Uitbreidbaar met meerdere camera's
T}@\
T{
.BS
Slechte resolutie
.BS
Onvoorspelbare 3D positie
T}
.TE

//TEMP LINKS--------------------------------------------------------------------------
3d camera ~20 m range - https://www.stereolabs.com/
Security article - https://www.securitymagazine.com/articles/82317-neither-rain-nor-dark-of-night-will-stop-security

// Pros en cons nightvision/thermal
https://www.opticsplanet.com/howto/how-to-thermal-imaging-vs-night-vision-devices-pros-and-cons-thermal-imagers-vs-night-vision.html

// Night Color Vision camera ~Probably also really expensive ~Still prototype it seems
https://www.x20.org/27-2/

//#360º#(full panorama)  FLIR camer
https://www.x20.org/xt360-panoramic-thermal-flir-ir-imaging-scanner/

//Deeplearning integrated camera???? FLIR
https://www.flir.com/support/products/firefly-dl

//Night vision differences
https://articles.pulsarnv.com/index.php/2018/01/09/what-are-the-differences-between-night-vision-digital-and-thermal/

//Claim to have solid state LiDAR   //no prices yet
https://quanergy.com/technology-2/

//Radar detection resources (avalanches)
https://www.geopraevent.ch/about-us/documents/?lang=en

//FLIR Ranger HRC-MS (product sheet)
https://flir.netx.net/file/asset/12601/original

//Toepassingen atrikel x20
https://www.x20.org/knowledgebase/best-infrared-cameras-veterinary/

//FLIR T1020
https://www.flir.com/products/t1020/?model=72501-0106

//Diepte---------------------------------------------------------------------
https://github.com/IntelRealSense/librealsense/blob/master/include/librealsense2/rsutil.h

https://github.com/svarnypetr/pps

//SICK lidar overview
https://cdn.sick.com/media/docs/0/30/930/Product_segment_overview_Detection_and_Ranging_Solutions_2D_laser_scanners_3D_laser_scanners_radar_sensors_en_IM0063930.PDF

//Researches agree w/ Tesla
https://www.therobotreport.com/researchers-back-teslas-non-lidar-approach-to-self-driving-cars/

//Peopleradar ~Infrared
https://www.geopraevent.ch/wp-content/uploads/2018/10/GEOPRAEVENT_ISSW2018_Poster_People_Detection.pdf

//Radar vs LiDAR
https://semiengineering.com/radar-versus-lidar/
