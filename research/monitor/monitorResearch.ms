.ND
.RP no
.TL
Meet & Move
.br
Public Space Insights
.AU
Van Hout C., Thom 
.AI
Innosportlab
.br
Sport & Beweeg!
.br
Eindhoven
.AB
Positie en activiteit bepaling van meerdere personen
.AE

.de BL
.IP \(bu
..

.EQ
delim ##
.EN

.XS
Introductie
.XE
.NH
Introductie
.PP
Dit is een onderzoek naar data collectie in een publieke ruimte.
.NH 2
Aanleiding
.PP
Gemeenten weten niet welk van hun inversteringen rendabel zijn. Om hier meer inzicht op te krijgen is het belangrijk
.NH 2
Probleemstelling
.PP
Hoe kunnen de volgende activiteiten van meerdere mensen in realtime verzameld worden?
.TS
tab(@) allbox;
c c
l l.
T{
.B
Should  
T}@\
T{
.B
Could
T}
Lopen   @ Spelen
Fietsen @ Sporten
Hardlopen   @ Ontmoeten
.TE

.NH 3
Probleem
.NH 3
Oorzaak
.NH 2
Doelstelling
.PP
Het doel is de volgende gegevens automatisch te kunnen genereren:
.TS
tab(@) allbox;
c c
l l.
Meet    @ Omschrijving
Activiteit
Tijd (pieken)
Hotspots
Aantal ontmoetingen
.TE
.NH 2
Oplossingen

.XS
Requirements
.XE
.NH
Requirements
.PP
.TS
tab(@) allbox;
c c c
l l l.
Requirement @ Omschrijving  @ MoSCoW
Detecteer Activiteit    @ @ M
's Nachts informatie verzamelen @   @   M
Hufter proof    @ Beschermend omhulsel/goedkoop  @ M
Gemakkelijk te verplaatsen @ @ M
In realtime data verwerken @   @   M
Standalone @\
T{
Heeft eigen stroom + data voorziening (genoeg voor 1 maand)
T}@ S
Schokbestendig  @   @ S
Weerbestendig   @   @ S
Hittemap Terrein Activiteit @   @ S
Leeftijds detectie  @   @ W
.TE

.XS
Onderzoeksvragen
.XE
.NH
Onderzoeksvragen
.NH 2
Hoofdvragen
.PP
.nr step 1 1
.IP \n[step] 1
Hoe kunnen de activiteiten van meerdere personen in realtime achterhaald worden?
.NH 2
Deelvragen
.PP
.nr step 1 1
.IP \n[step] 4
Waar wordt people tracking al toegepast?
.BL
City of Things - Antwerpen
.BL
Smart Data City:
.[
smartdatacity
.]
.RS
.BL
Living Lab - Eindhoven Stratumseind
.BL
Sensor City - Assen
.[
sensorcity
.]
.BL
Datacapital - Almere
.[
almeredatacapital
.]
.RE
.BL
China
.IP \n+[step]
Welke locatie bepaling technieken bestaan al?
.[
trackingtech
.]
.BL
Stereo lab ZED 
.[
zed
.]
traceert mensen en auto's in ongeveer twintig meter.
De beelden van twee camera's worden gebruikt en in een "Neural Stereo Depth Sensing" A.I. geoutputtet. Het apparaat is mobiel, om de 3d positie te kunnen achterhalen tijdens beweging, wordt gebruikt gemaakt van een accelerometer, barometer, gyroscoop, magnetometer en temperatuur sensor.
.BL
Amsterdam toeristenstromen in kaart via foto's.
.[
socialmediakaart
.]
.PP
Technieken boven genoemde people tracking projecten:
.BL
City of Things:
.RS
.BL
Vehicle loop detectors (alleen voorbijgaande auto's zijn meetbaar)
.BL
Informatie van voetgangers wordt verzameld, doordat voetgangers bereidt moeten zijn hun mobiele telefoon signaal te delen met hun systemen.
.[
The Benefits for Pedestrians
.]
.BL
Bij zeebrapaden wordt met behulp van hitte camera's het aantal voetgangers geteld. "Using thermal cameras, we were able to detect the number of road-users at the crossroads..."
.[
slimmeverkeerslichten
.]
.BL
Observer Dashboard gebruikt een combinatie van verkeers tellers (in wegdek), camera's, data van het TCI netwerk
.[
tci
.]
, data van mobiele apps en in de toekomst RFID voor grote groepen.
.[
observertraffic
.]
.RE
.BL
Living Lab:
.RS
.BL
Geluids camera
.BL
Geur camera? //TODO
.BL
Camera (heatmap/agression detection met algoritme of deeplearning?)
.RE
.BL
Sensor City:
.RS
Verlichting -> Afwijkend geluid of beweging
.RE
.BL
Datacapital:
.RS
Beweren zorg projecten te gaan doen
.RE
.BL
~Smart Data City #-># Standardisation Document -> ANPR Operation in South Ilford 9 arrestaties
.[
anproperation
.]
.BL
Utrecht lege fietsenrek plaats herkenning.
.[
utrechtfietsenrek
.]
Lumiguide doen auto- en fietsdetectie.
.[
lumiprojects
.]
Hun autodetectie systeem kan volgens hen 100 parkeer plaatsen in de gaten houden. De gebruikte camera's zijn stereo camera's van Axis, de software komt van LumiGuide.
.IP \n+[step]
Hoe kan data AVG vriendelijk verstuurd en verwerkt worden? (check Open Data Principles.
.[
opendataprinciples
.]
=> Maak publiek toegankelijk, maar niet tot persoon herleidbaar.
.br
AVG guidelines
.[
avgguidelines
.]
=> //TODO: Onderzoek wanneer eindoplossingen in beeld zijn, check though:
.RS
.BL
Camera: https://edpb.europa.eu/sites/edpb/files/files/file1/edpb_guidelines_201903_video_devices.pdf
.BL
Data: https://autoriteitpersoonsgegevens.nl/sites/default/files/atoms/files/20171013_wp248_rev01_enpdf.pdf (e.g. III.3 #-># Systematic Monitoring)
.BL
Consent: https://autoriteitpersoonsgegevens.nl/sites/default/files/atoms/files/guidelines_on_consent.pdf => II. Plaats bordjes bij ingang?
.RE
.IP \n+[step]
Deeplearning ~minimale resolutie? 's Nachts? PC eisen? Groothoek lens? Meerdere camera's?
.br
Onderzoek opties: => strength weakness //hoe krijgt City of Things het geschaft?
.RS
.BL
Camera ~ Deeplearning pose estimation (Some views may be blocked) Activity monitoring patch?
Activity detection -> try image classifier network
.[
poseestimation
.]
Seems to have used dataset w/ minimal resolution 640x480 @ 25fps.
.[
poseestimationdataset
.]
Git repo Openpose
.[
openpose
.]
.BL
YOLOv3 (probably slower bc detects all objects)
.[
yolov3
.]
.BL
LPC (license plate capture) camera's hebben software ingebouwd om te compenseren voor 's nachts, mist, snelheden en koplamp gloed (10-30fps).
.[
lpccamera
.]
.BL
Radio (may interfere w/ other signals from city/location) => check wavelengths
.[
radiopos
.]
legaal zomaar een frequentie te gebruiken?

.BL
Bluetooth (3d pos => 3 nodes of 2 met height map, 2d pos => 2 nodes)
    .RS
Maximale range: (mobiel = klasse 3; Rx + Tx need to be within each other's range)
.[
bluetoothrange
.]
.TS
tab(@) allbox;
c c c
l l l.
Klasse  @ Range @ Effectieve Range
1   @ #100m#    @ #20-30m#
2   @ #30m#     @ #5-10m#
3   @ #10m#     @ #>10m#
.TE
//TODO: translate!
BLE (Bluetooth low energy) beacons -> low energy cost, requires App when BLE advertises
.[
bletracking
.]
.RE
.TS
tab(@) allbox;
c c c c c c
l l l l l l.
Name    @ Power | On | Active | Sleep   @ BT Version    @ Frequency @ Size  @ Cost 
MH-10   @ 2.50-3VDC 50mA |              @ V4.0 BLE      @ 2.4 GHz   @ 27mm x 13mm x 2.2mm @ 8,95
.TE
//Consider

.BL
(MEMS) Motion sensors (e.g. accelerometer) -> drift issue
.BL
Infrared (wss short range) e.g. gebruikt door City Of Things
.[
imeccamera
.]

.BL
GPS (/Galileo ~ should have ~1m accuracy)
.BL
Kinect (uses infrared+camera I believe, short range + limited people count)
.RE
.BL
Data transmissie + verwerking
.BL
Deeplearning -> does disabling features require retraining?
.BL
Het Japanse bedrijf Omron claimed snelle computer visie (lijkt discontinued)
.[
vision2013
.]
(nog niet released)
.[
vision2019
.]
te hebben ontwikkeld
.BL
Capgemini (store tracking e.g. heatmaps) lijkt A.I. te gebruiken (https://www.capgemini.com/services) hun services: (https://www.capgemini.com/service/the-smart-digital-store/)

.XS
Verwerking
.XE
.NH
Verwerking
.NH 2
Deelvragen
.NH 3
Toepassings Analyse
.PP
.TS
tab(@) allbox;
c c c
l l l.
Methode     @ Voordelen     @ Nadelen
Bluetooth   @ Kan personen onderscheiden @\
T{
\(bu Vereist Rx + Tx op ieder persoon 
.br
\(bu Vereist vele nodes
.br
\(bu Bluetooth moet ingeschakeld zijn
.br
\(bu De verbinding kan makkelijk door obstacles geblokkeerd worden
.br
\(bu Er kan alleen gedetecteerd worden wanneer iemand de range uitgaat
.br
\(bu Is te spoofen
.br
\(bu Signaal verstoorbaar door omgevings signalen
.br
\(bu Korte range => Meer apparaten => Grotere kans op kapotgaan
T}
Camera @ Waarschijnlijk 1 nodig @\
T{
\(bu Privacy
.br
\(bu Grote hoeveelheid data
.br
\(bu Deeplearning dure hardware #-># scalability
T}
T{
Galileo
.[
galileo
.]
T}@\
T{
\(bu #1m# hori+vert accuraat
\(bu accurater dan GPS
.[
gpsvsgalileo
.]
T}@\
T{
\(bu Vereist node op ieder persoon
\(bu Ongeveer 2x duurder dan GPS
T}
Infrarood (passief)   @ Lage kosten   @ \(bu Accuratie (maakt geen onderscheid 1- of meerdere personen)
Thermische Camera   @\
T{
Kan grote range hebben
.[
thermalcameras
.]
T}@ Lage framerate ~9fps
Range/3d Camera's @\
T{
Gewoonlijk een robuuste buiten security camera
T}@ Duur 
WiFi @  @\
T{
\(bu Niet accuraat
.br
\(bu Moet ingeschakeld zijn
.br
\(bu Relatief klein bereik ~10m
.br
\(bu Hoog energie verbruik
T}
RFID @ Mogelijk batterijloos @ Vereist nodes/tags
Pressure Sensor @ @\
T{
\(bu Veel nodig
.br
\(bu Personen onderscheiden
T}
Ultrasoon Sensor @ @\
T{
\(bu Reflections #-># difficult setup
.br
\(bu Pick up each other
.br
\(bu Geen onderscheid meerdere personen 
.br
\(bu Verstoord door temperatuur
T}
.TE

.BL
RFID
.PP
Long range (active) RFID tags bestaan, met een range van #~100m#.
.[
longrangerfid
.]
Hoe groter het bereik, des te groter de prijs en sensor volume e.g. #~1500m#.
.[
1500mrfid
.]
.br
Het geeft ook passieve RFID tags, deze ontvangen energie door een antenne waarmee een signaal wordt terug gestuurd op #~10m#.
.[
powerlessrfid
.]
.BL
Deeplearning
.TS
tab(@) allbox;
c c c
l l l.
Algorithm   @ Performance/Person   @ Hardware
T{
Openpose
.[
openpose
.]
T}@\
T{
Barely increases
.[
openposebenchmark
.]
Limiet 30?
T}@ 1080 Ti (CUDA 8)
.TE
De live video kan via radio verstuurd worden.
.[
buildradiolink
.]
.br
Gebruik meerdere cameras
.[
micromca
.]
, filter bepaalde golflengtes, combineer en gebruik dit beeld voor het leren.
.br
Meerdere landelijke locaties #-># waarschijnlijk loadbalancing nodig en/of meerdere video kaarten.
.br
Welke camera? Thermisch/3d #-># anoniem
.RS
.BL
Zorgen:
Kan het voor de gek gehouden worden met: dieren, kartonen figuur, ruis (regen, donkerheid), schaduws.
Max aantal personen?
Schommeling van camera door wind #-># positie bepaling.
.RE

.BL
App
.TS
tab(@) allbox;
c c c
l l l.
Name @ + @ -
T{
PinMe
.[
pinme
.]
T}@ Geen/weinig locale sensoren @ Kan niet iedere gebruiker vinden
.TE
.PP
Wellicht kan een inwoner "uitdagingen" in bepaalde gebieden doen. Deze uitdagingen komen van de app, beloningen volgen. Echter is dit een blind systeem (b.v. hangjongeren zullen dit waarschijnlijk niet installeren).

.BL
Radio
.PP
Each phone uses unique frequency band -> track same person
.TS
tab(@) allbox;
c c c
l l l.
Name @ + @ -
4G  @ Widespread    @\
T{
\(bu Omschakeling naar 5G is nabij.
.br
\(bu Range: #50-150km#
.[
345range
.]
.br
\(bu Range: #3-7km#
.[
4gtowerrange
.]
T}
5G  @ Groot aantal devices @\
T{
\(bu Range: #10-100m#
.[
5grange
.]
of #250-300m#
.[
345range
.]
T}
.TE
.PP
De radio signalen opvangen kan inaccuraat zijn, sinds contact met de toren maar een aantal keer plaatsvindt, afhankelijk van inkomende/uitgaande berichten/telefoongesprekken, of ping berichten een aantal keer per uur.
.[
towerping
.]
Is onbetaald gebruik maken van bepaalde frequenties illegaal?
.br
Tensorflow pose estimation
.[
tensorflowposeestimation
.]
runt ~10fps op een Jetson TX2 (~$460),
.[
jetsontx2
.]
lokaal berekenen #-># geen grote video feed data #-># ander transmissie protocol.

.BL
Telefoon Tracking
.PP
Er zijn een aantal mogelijkheden om telefoons te tracken, echter is vereist dat het toestel bekend is.
.[
trackphone
.]
// Kan niets vinden om telefoons in specifiek gebied te tracken; tower ping is te zeldzaam.

.BL
Ultrasoon
.PP

.BL
Bluetooth
.RS
30-40% Bluetooth aan? -> smartwatch + wireless earbuds
.RE

.BL
Batterij
.TS
tab(@) allbox;
c c c c c c
l l l l l l.
Naam @ Spanning @ Stroomsterkte @ Vermogen @ Watt Uur @ Price
Yuasa YBX5019 @ 12V @ @ 1200W @ 100Ah @ 115,58
Yuasa YBX3096 @ 12V @ @ 980W @ 76Ah   @ 75,12
T{
WB-LYP1000AHC LiFeYPO4 
.[
wblyp1000
.]
T}@ 3,2V @ @ @ 1000Ah @ 1.068,96
.TE

.BL
Zonne-energie
.TS
tab(@) allbox;
c c c c c
l l l l l.
Naam        @ Spanning (V)  @ Stroomsterkte (A) @ Vermogen (W)  @ Afmetingen (HxBxL) (m)
LG315N1K-V5 @ 30            @ 7                 @ 236           @ 1,6x1x0,40
GWL/Sunny Poly @ 18V        @ 6.1               @ 105           @ 1x0,665x0,030mm
.TE

.NH 3
Bestaande Toepassingen
.BL
Human Movement Behaviour In Urban Spaces Implications For The Design And Modelling Of Effective Pedestrian Environments:
.PP
Dit is een wat oudere toepassing uit 2013, waarin menselijke observators zijn gebruikt om aan de nauwkeurige resultaten te komen. In hun onderzoeksverslag staat omschreven welke taken software- en welke handmatig zijn uitgevoerd:
.RS
.BL
Softwarematig: Snelheid, afstand, positie, terrein (b.v. stoep)
.BL
Handmatig: Leeftijd, geslacht, mobiliteit (vervoersmiddel of medereizigers), groepsgrootte, pad omschrijving.
.RE
.PP
Deze resultaten werden vervolgens gecombineerd en in een birds eye view weergegeven.
.BL
3D Positie - Homography Matrix: 
.br
Via bekende punten in de omgeving (met hun afstand) is een model gemaakt om iemands positie vanuit een 2d, naar 3d positie om te berekenen.

.NH 2
Hoofdvragen
.PP
.TS
tab(@) allbox;
c c c c c c
l l l l l l.
Item    @ Kosten @ Max Mensen @ Energie verbruik @ Range @ Standalone
RFID    @ @ @ @\
T{
aantal cm - 100m
.[
longrangerfid
.]
T}@ Nee (Antenne nodig)
.TE
.br
Met wat van de uitkomst data moet rekening gehouden worden?

.XS
Proof of Concept
.XE
.NH
Proof of Concept
.BL
(n)Client + (1)Server
.BL
Loadbalancing (hopelijk niet)
.BL
Security
.BL
Data transport

.BL
Hoe kunnen activiteiten bepaald worden?
.RS
.BL
Verschil Snelheden
.TS
tab(@) allbox;
c c
l l.
Activiteit  @ Snelheid
Lopen   @\
T{
#5km/h#
.[
avgloop
.]
T}
Hardlopen   @\
T{
#10km/h#
.[
avghardloop
.]
T}
Fietsen @\
T{
#18km/h#
.[
avgfiets
.]
T}
.TE
.BL
Verschil in pose
.RE

.XS
Test
.XE
.NH
Test
.PP
Battery
.BL
Performance client- + server side
.BL
Transfer error handling
.BL
(Afhankelijk van gekozen oplossing:) Dier, karton, signaal storing, lichten, hitte afdruk (b.v. schud kokend water in vorm van mens)

.NH
Bluetooth
.NH 2
Gebruik gemeten:
.PP
In trein:
.TS
tab(@) allbox;
c c
l l.
Aantal Mensen Bluetooth Aan @ Totaal
8 @ 13
8 @ 11
1 @ 4
.TE

//TODO
.NH
WiFi
.NH 2
Gebruik gemeten:
.PP
NMap/EtterCap scan:

.XS
Conclusie
.XE
.NH
Conclusie
.PP
Voorlopig:
.BL 
Niet optimaal om gebruikers sensoren te geven (vereist veel nodes), of een app te laten installeren+activeren (zal geen hangjongeren detecteren).
.BL
Standalone 4G/5G snooping is niet nuttig, alleen maar een paar pings naar toren/uur #-># niet genoeg data. Bij de switch naar 5G zouden de minimale 2 masten dichterbij geplaatst moeten worden i.v.b.m de kortere range.
.BL
RFID is niet handig #-># moet uitgedeeld worden aan mensen.
.BL
Bluetooth/WiFi snooping potentieel niet genoeg data (mensen die het uit hebben; City Of Things heeft data van telecommunicatie bedrijven en van een App). #-># Voordeel, mensen kunnen onderscheiden worden, ook in toekomst. Maar mensen kunnen hhun MAC address spoofen.
Smart Watch/Earphones -> bluetooth
.NH 2
Kosten Vergelijking:
.BL
Goedkoopst
.TS
tab(@) allbox;
c c c
l l l.
Artikel     @ Aantal    @ Kosten
IR camera   @ 1x        @ 
.TE
.BL
Middelste
.BL
Duurst
//Sterke PC
//180*/Fisheye Lens
//Rangefinder
//Zoom+Direction control
//Two way communication

.XS
Reflectie
.XE
.NH
Reflectie

.NH
Consideraties
.PP
.BL
Met hoeveel tijd zal een zonnecel de levensduur verlengen? //E.g. Peopleradar

TEMP! Useful URLs maybe? ------------------------------------------------------------
.BL
https://arxiv.org/pdf/1907.05272v3.pdf  //deeplearning pose est. introduction
.BL
https://www.researchgate.net/publication/301591194_Minimal_Solutions_for_Pose_Estimation_of_a_Multi-Camera_System   //multiple camera pos estimation paper w/ good references
.BL 
https://www.flir.com/browse/camera-cores-amp-components/thermal-camera-cores/   //infrared cameras
.br
http://www.longrangethermalcam.com/products.html    //more cameras
.BL
https://timdettmers.com/2018/12/16/deep-learning-hardware-guide/    //hardware guide deeplearning
.BL
RFID Tracking:
.br
https://link.springer.com/article/10.1007%2Fs10776-013-0210-z
.br
https://litumiot.com/how-active-rfid-works/
.BL
Wireless Long Range Communications:
.br
https://www.controleng.com/articles/connectivity-of-things-wireless-for-the-last-100-m-of-iot/
.br
https://journals.sagepub.com/doi/full/10.1177/1550147716671720 "Ultrasonic -> influenced by temperature, WiFi high power usage. + Bluetooth location math"
.br
OpenData Eindhoven: 
.[
opendata
.]
bevat wellicht live gegevens (op eerste oogopslag niet).
.br
https://www.smartdatacity.org/wp-content/uploads/2015/01/Eindrapport-Verkenningen-Roosendaal-Smart-Retail-City-v1.2.pdf
.br
https://www.thermal.com/law-enforcement.html // IP67 + 24deg FOV
.br
https://sustainder.com/en/products/sustainder-anne // Smart lantern - Casing -> IP66 + IK10(8 for glass), operating temp -20 to 35
.br
https://cctvdesk.com/anpr-camera/   // Licenceplate camera specs
.br
https://shop.bsigroup.com/upload/Shop/Download/PAS/PD8101-2014.pdf  // Smart city planning guide from smartcitydata ~ 50 bucks lol -> https://shop.bsigroup.com/ProductDetail/?pid=000000000030294642
.br
https://data.overheid.nl/   //open data van de overheid

//-----------------------------------------------------------------------------------------
//has avg speeds
https://www.researchgate.net/publication/23541458_Human_movement_behaviour_in_urban_spaces_Implications_for_the_design_and_modelling_of_effective_pedestrian_environments

//Xandra's gevonden paper (flippin' goldmine):
https://www.researchgate.net/publication/267729089_Measuring_Human_Movement_Patterns_and_Behaviors_in_Public_Spaces     // 30fps, AxisQ1922, 3d pos accuracy 25-100cm accurate
    //activities recognized: meeting, flocking, avoidance and following a leader
    //^Software makers CV papers: https://web.archive.org/web/20110917034143/http://www.tft.lth.se:80/video/co_operation/seminars/november_2010/        //https://web.archive.org/web/20140830104012/http://www.tft.lth.se/video/co-operation/data-exchange/        //https://web.archive.org/web/20140830104029/http://www.tft.lth.se/video/methodology/

www.urbanobservatory.org //Urban Observatory - vergelijk opendata in steden, onder verschillende catagorien 

//Estimate Battery Duration
https://www.cypress.com/documentation/application-notes/an92584-designing-low-power-and-estimating-battery-life-ble

.TC
