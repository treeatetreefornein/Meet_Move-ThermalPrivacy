.RP no
.ND

.EQ
delim ##
.EN

.de BL
.IP \(bu
..

.TL
Onderzoek Anonimisering van Thermische Video Beelden
.AU
Van Hout C., Thom
.AI
Innosportlab
.br
Sport & Beweeg!
.AB
Anonimisering van thermische camera beelden, op basis van drie gevonden methoden die toepasbaar zijn in Hardware. 
.AE

..........................................................................................

.NH
Samenvatting
.PP
Voordelen Thermisch: geen omgevings verlichting nodig. Niet beïnvloedbaar door zon, koplampen of schaduwen. 24/7 in alle weersomstandigheden. Robuust, onafhankelijk van infrastructuur of bomen in de field of view.
        => Warmte beelden perfect voor thermische camera's


.NH
Inleiding
.PP
In dit onderzoek worden drie gevonden anonimiseringsmethoden gesimuleerd in software.

.NH
Onderzoeksvragen
.NH 2
Hoofdvraag
.PP
.BL
Hoe kunnen de drie gevonden anonimiseringsmethoden voor thermische camera's gesimuleerd worden?
.NH 2
Deelvragen
.PP
.br
1) Hoe kunnen pixel waarden van een video bewerkt worden?
.br
2) Wat is de meest privacy-vriendelijke anonimiseringsmethode?

.NH
Verwerking
.NH 2
Anonimisering
.PP

.NH 2
1) Hoe kunnen pixel waarden van een video bewerkt worden?
.PP
Om de anonimiseringsmethoden te simuleren is het nodig de pixelwaarden van een video uit te kunnen lezen en te schrijven. Het uitlezen van een video is niet zo simpel als een bitmap uitlezen, video's worden compressed om ruimte te besparen. Deze compressie verschilt per video, 
In onderstaande tabel zijn een aantal media libraries vergeleken, die elk video kunnen uitlezen.

.PP
Comparison:
.TS
tab(@) allbox;
c c c c
l l l l.
Library @ +                             @ - @ Pixel Frame Extraction
OpenCV  @\
T{
Wordt gebruikt door OpenPose
.br
Video display
.br
Streaming support (webcam)
.br
Video processing support
T}@   @ vec3b
FFMPEG  @\
T{
Ervaring CLI, industrie standaard 
.br
Streaming https://lembergsolutions.com/blog/how-process-live-video-stream-using-ffmpeg-and-opencv
T}@ AVFrame
SDL     @                               @\
T{
Grafische library, geen default video support
T}
GStreamer @\
T{
Streaming (HTTP, MMS, RTSP)
T}@ Complex, diepe pipelines @\
T{
Raw Video Parse, GST Video Frame
T}
SF::Movie (gebruikt FFMPEG) @ Access current image @\
T{
Geen stream playback 
.br
Vereist SF:system,window,graphics,audio modules
T}@ 
QT::Multimedia @\
T{
Abstractions for frame manipulation 
T}@ @ QVideoFrame
LibCinder @ Wiskunde functies + meer @\
T{
Pixels in video niet aan te passen (alleen playback support)
T}
.TE

=>
FFMPEG: 
OpenCV: 
    * Machine Learning
    * Met GStreamer plugin kunnen http(s) beelden bekeken worden, perfect voor security camera's

.NH 2
Hoe kunnen de drie gevonden anonimiseringsmethoden voor thermische camera's gesimuleerd worden?
.BL
Exposure: 
- Issues:
    - Hardware niet voldoende gesimuleerd:
        De hardware noise toepassing op een thermische camera, is volledig willekeurig (RNG). De Perlin Simplex Noise library genereerd voor dezelfde input altijd dezelfde waarde.


.NH
Conclusie
.NH 2
Hoe kunnen pixel waarden van een video bewerkt worden?
.PP

.TC
