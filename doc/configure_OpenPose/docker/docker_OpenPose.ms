.de BL
.IP \(bu
..

.TL
OpenPose Voor Docker 

.NH
Inleiding
.PP
In dit document wordt uitgelegd hoe de docker omgeving opgezet wordt.

.NH
Samenvatting
.PP
Docker kan gebruikt worden om OpenPose in een sandbox te gebruiken. Als gevolg hoeven er geen dependencies worden geïnstalleerd op de host.

.NH
Installatie
.LP
Prerequisites (Linux): libnvidia-container, nvidia-container-toolkit, docker
.br
Optioneel: dmenu (voor het launch script, optioneel omdat de waarden in het script kunnen worden gehardcode)

.NH 2
Selecteer Docker Image
.LP
De image
.B "cwaffles/openpose"
werkt voor mij het best
.br
Andere opties: 
.B "exsidius/openpose"
of 
.B "david800131s/openpose_t10_2"
.PP
Installeer de image met
.RS
$ docker pull [image]
.RE

.NH
Uitvoering
.LP
Start de container:
.RS
$ docker run -it --rm -v "[local dir]/:/var/log/openpose/" --gpus -1 [container]
.RE
.PP
Flags:
.RS
.RS
.BL
-it: Start met interactive TTY
.BL
--rm: Verwijder container na afsluiten
.BL
-v: Deel een folder tussen de container en host (voor dataset sharing en data output)
.BL
--gpus -1: Gebruik maximaal aantal GPUs beschikbaar
.RE
.RE

.NH
Tips
.PP
.BL
Het OpenPose GUI vanuit Docker weergeven is mij niet gelukt. In het launch script zijn voor GUI support twee opties uit te proberen.
.BL
Docker zonder sudo:
.RS
Voeg je gebruiker toe aan de Docker groep
.RE
.BL
De flag "--flir-camera" is bestemd voor gebruik met een fysieke FLIR camera, niet thermische video bestanden/foto's
