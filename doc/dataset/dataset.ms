.NH
Installatie

.NH 2
FLIR 
.PP
    1) Download de FLIR dataset: 
        - Signup: https://www.flir.com/oem/adas/adas-dataset-form/
        - of direct (potentieel verlopen/out-of-date) https://flir.app.box.com/s/1z1wn8e5b9ff0vvcc589l1m5529smrnx
    2) Voeg ieder archief bijeen:
        $ cat FLIR_ADAS_1_3.zip.* >> FLIR_ADAS_1_3.zip
    3) Unzip het archief:
        $ 7z x FLIR_ADAS_1_3.zip
    * Problemen:
        - Visuele en FLIR camera zijn niet gesynct, poses van mensen in de frames komen niet overeen
    
    Optional:
        * Codec
            Videos worden encoded om bestandsgrootte te reduceren. Hiervoor worden codecs gebruikt om de video te encoden en decoden.
            FFMPEG codec steps: https://www.headendinfo.com/what-is-ffmpeg/

.NH 2
CSR
.PP
Gevarieerde dataset, helaas lage resolutie (al wat ouder).
.PP
http://csr.bu.edu/BU-TIV/BUTIV.html

.NH
Tools
.PP
Creëer een video van alle foto's om bestandsgrootte te verminderen (potentiële time-out op Google Colab).

