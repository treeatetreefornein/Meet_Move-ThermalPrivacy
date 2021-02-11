# Pose Verifier
Deze code is ontwikkeld om twee OpenPose pose outputs te vergelijken. Bij het invoeren van twee folders met deze OpenPose outputs wordt het volgende berekend per lichaamsdeel (lichaam, handen, gezicht):
1. Verschil pose coördinaten
2. Gemiddelde zekerheid
3. Aantal missend
## Prerequisites
1. OpenCV
2. CMake
## Bouwen
### 
Start het script "configure" in de map "poseVerifier" en bouw de code:
```
cd poseVerifier
./configure && make
```
###  (niet getest)
```
cd poseVerifier
md build && cd build
cmake ../ && make
```
## Gebruik
Vergelijk twee OpenPose pose outputs.
```
./poseVerifier [origineel] [anoniem]
```
Origineel en anoniem zijn folders die de JSON output van OpenPose bevatten. Origineel kan hier de onaangepaste thermische camera beelden zijn, of de bijpassende visuele/reguliere camerabeelden. De anonieme folder bevat OpenPose output afkomstig van de anonieme thermische camera beelden (VideoAnonimisation code).
Voorbeeld OpenPose pose output is te vinden in de map "crsRoomOpenposeOutput".

# OpenPose
## Gebruik Code
!Belangrijk: De PoseVerifier verwacht output van slechts één persoon per video, voer OpenPose daarom uit met de flag: `--number_people_max 1`
Of implementeer een fatsoenlijke JSON parser😉 b.v. [https://stedolan.github.io/jq/](jq).
## Uitvoer Opties
### Google Colab
Upload het bestand OpenPose.ipynb naar Google Colab en voer iedere codeblock uit.
### Docker
OpenPose kan in Docker uitgevoerd worden, zo hoef je (buiten Docker) niets te installeren.
#### Verkrijgen
Maak de docker image beschikbaar:
```
sudo docker pull exsidius/openpose
```
#### Sudoless Docker ()
Om Docker zonder sudo te kunnen gebruiken kan je jezelf toevogen aan de Docker groep. E.g. (raadpleeg je distro docs!):
```
sudo useradd -g docker $(whoami)
```

# Issues
* Kan slechts één persoon per video analyseren
* Gaat ervan uit dat OpenPose output gezicht, handen en lichaam bevat
