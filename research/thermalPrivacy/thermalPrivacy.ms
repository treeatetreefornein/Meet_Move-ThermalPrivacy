.RP no
.ND

.EQ
delim ##
.EN

.de BL
.IP \(bu
..

.TL
Thermal Privacy
.AU
Van Hout C., Thom
.AI
Innosportlab
.br
Sport & Beweeg!
.AB
Onderzoek naar thermische camera anonimisering en een zoektocht naar de meest geschikte experimenteer thermische camera.
.AE

......................................................................................................

.NH
Inleiding
.PP
Het eerste doel van dit document is te bepalen welk type anonimisering (noise, digitization, exposure) voldoende is. Verder wordt bepaald hoe met deze wijze geëxperimenteerd kan worden zonder veel geld te verspillen.

......................................................................................................

.NH
Onderzoeksvragen
.PP
.BL
Hoe werkt de anonimisering?
.RS
.BL
Welke wijze van anonimisering is het meest toepasbaar?
.BL
Combinatie methoden beter?
.BL
Rekening houden met openbreken camera.
.BL
Onderdelen vereist?
.RE
.BL
Welke thermische camera is het meest geschikt?

......................................................................................................

.NH
Verwerking
.NH 2
Welke wijze van anonimisering is het meest toepasbaar?
.BL
Hoe werkt de anonimisering?
.RS
.BL
Exposure:
.RE
.br
Kijk uit naar een 'Integration Time' feature om exposure te kunnen veranderen.
.PP
Digitization is in tegenstelling tot exposure en noise niet afhankelijk van hardware. Exposure moet in de camera zelf worden aangepast, overexposure daarbuiten is mogelijk met een buffer maar heeft echter een counter nodig om te weten welke pixel geschreven wordt.
.br
Noise gebruikt de bolometers uit de camera, er is risico op schade als deze niet gemakkelijk toegankelijk zijn.
.br
Bij een losse sensor kan de digitization methode, temperaturen binnen de gevoelige range simpelweg "weggooien". De buitentemperatuur wordt opgenomen en d.m.v. een grafiek kan de menselijke temperatuur gefilterd worden.

.PSPIC img/digitizationCircuit.eps
.I "Een voorgestelde Hardware omschrijving uit het artikel"
.[
thermalcameraprivacy
.]

.NH 2
Welke thermische camera is het meest geschikt?
.PP
De volgende tabel bevat een aantal camera's:
.TS
tab(@) allbox;
c c c c c c
l l l l l l.
Camera  @ Price @ Resolution @ Temperatuur Bereik @ Type @ Golflengte
T{
XE-26D/HT-175
.[
xe26d
.]
T}@ $170 @ 32x32 @ -20 - 380°C @ Camera
T{
MLX9064
.[
mlx9064
.]
T}@ $200 per 2 @ 32x24 @ 10 - 43°C @ Sensor
T{
GY-AMG8833
.[
gyamg8833
.]
T}@ $30 @ 8x8 @ 0 - 80°C @ Sensor
T{
PLUG 417 
.[
plug417 
.]
T}@ $1300 @ 384x288 @ -20 - 150°C @ Camera
.TE
.BL
Rauw signaal? Of encoded video?
.br
TODO
.BL
Golflengte:
.br
Menselijke lichamen stralen een golflengte van ~10\[*m]m uit.
.[
menselijke golflengte
.]
Deze golflengte valt in de categorie van long-wave infrarood (8-15\[*m]m)
.[
infrared regions
.]
, dit betekent dat zo'n type thermische camera vereist is.
.BL
Op welke afstand kan een thermische camera een mens zien?
.br
TODO:
.RS
.BL
Kan het bereik worden verlengt m.b.v. een lens?
.br
Ja, echter is de lens geacht voor de camera bestemd te zijn, elders kloppen de temperatuur metingen niet: https://www.researchgate.net/post/Can_you_compensate_for_estimate_temperatures_on_a_thermal_camera_that_has_a_telephoto_lens_attached
.br
FLIR heeft testen met verschillende lenzen uitgevoerd.
.[
thermal imaging how far can you see with thermal
.]
Bereken
.[
a lesson on ir
.]
Met behulp van het Johnson criteria kan er objectief onderscheidt worden gemaakt tussen de kwaliteit van camera's. Het getal bestaat uit drie categorieën die beschrijven hoeveel pixels er voor een mens vereist zijn aan herkenning te voldoen met 50% zekerheid:
.RS
.BL
Detectie:
1.5px = 0.75 cycles in staring array
.BL
Herkenning (auto of persoon; onderscheid enig object):
6px
.BL
Identificatie (vriend of vijand):
12px
.RE
.BL
Welke factoren hebben invloed op het bereik?
.br
Type thermische camera (gekoeld/ongekoeld, laatste de beste), lens, te-meten object (natuur, grootte) en atmosfeer.
.RE

.NH 2
Camera Aanraders Expert
.TS
tab(@) allbox;
c c c 
l l l.
Bedrijf @ Camera  @ Price 
Infratec:
FLIR: @	1-866-FLIR-911 or 1-866-3547-911
Infrared Cameras: @	Toll-Free: (866) 861-0788 | Direct: (409) 861-0788
Optris: @ +49 30 500197-0
InfraTec: @ +184 4226 3722
IRCameras: @ 805 965 9650
Monroe Infrared: @ 800-221-0163
Jaycar: @ 1800 022 888
Omega: @ 0800 488 488 | International +44(0) 161 777 6611
Kolar Vision: @	+1 844 565-2741
LifePixel: @ (conversion blog)    866.610.1710
dlsrpros: @ 877 299 1075
Fluke:	@ 877-864-5880
warmtebeeldcamera.nl:   @ +31 (0)416 - 369473
antratek @ +31 (0)180 704 000
.TE
=> FLIR leading bedrijf
	Klein temperatuurbereik, specifiek menselijke temperatuur
	FLIR Bose 3d (2x camera) + Kleine afmeting
	~Geen dev camera -> Lepton

......................................................................................................

.NH
Video Anonimisering Software
.NH 2
Implementatie
.PP
.BL
Digitization
.BL
Noise
* Often deploys bolometer for ambient noise reduction
* Adjust sensitivity: GSK GFID
.RS
https://github.com/SRombauts/SimplexNoise
.RE
.BL
Exposure
* Over
* Under
* Fusion

......................................................................................................

.NH
Conclusie
.PP
H.W. onafhankelijke oplossing => Digitization of overexposure
Mix => Noise

.NH 2
Limitaties
.PP
De geïmplementeerde anonimisering technieken kunnen niet iemands "loopje", silhouet of lengte verbergen. Deze eigenschappen worden niet als persoonsgegevens gezien, dit kan in de toekomst potentieel veranderen.

//TODO:
- Is upscaled pose estimation een optie (slechte camera resolutie)?
- Voor eerste tests gebruik maken van contactloze, infrarode thermometers?
//TOCHECKOUT
* http://www.yuheng.lu/research/anonymous-camera
* AI temperatuur tweaking:	https://www.hikvision.com/nl/Oplossingen-Voor-De-1,5m-Samenleving/temperatuur-screening/?utm_source=google&utm_medium=textad&utm_campaign=temp%20screen

CHEAP!: https://circuitdigest.com/microcontroller-projects/ir-thermometer-using-arduino-and-ir-temperature-sensor => MB use https://www.alibaba.com/product-detail/Infrared-Sensor-PIR-IR-Infrared-Probe_62476937014.html?spm=a2700.7724857.normalList.58.49fe3babZTAxDX

Calculator thermal (zoom) cameras: https://www.infratec-infrared.com/thermography/infrared-camera/variocam-hd-z-security/
Chose lens:     - https://res.cloudinary.com/iwh/image/upload/q_auto,g_center/assets/1/7/Ti_Lens_Sales_Guide.pdf
- https://res.cloudinary.com/iwh/image/upload/q_auto,g_center/assets/1/7/Fluke_Thermal_Macro_Lens_Application_Notes.pdf
- https://www.flir.com/support-center/iis/machine-vision/application-note/selecting-a-lens-for-your-camera/
- https://www.tequipment.net/choosing-the-right-thermal-camera-lens/

https://peoplesense.irlynx.com/

.TC
