.RP no
.ND

.EQ
delim ##
.EN

.TL
Pose Estimation Algoritme 
.AU
Van Hout C., Thom
.AI
Innosportlab
.br
Sport & Beweeg!
.AB
Onderzoek naar meest geschikte pose estimation algoritme.
.AE

.NH
Inleiding
.PP
Voor de camera monitoring oplossing, wordt verwacht een pose/positie/objectdetectie algoritme te gebruiken. In dit document wordt onderzocht welk algoritme het meest geschikt is. 

.NH
Requirements
.PP
.BL
Performance #-># grote resolutie, meerdere personen, goede framerate (kans dat fietser been positie zelfde is als wandel)
.BL
Meerdere personen ~30
.BL
Lichaam (-hoofd, -handen, -voeten, -armen?) + lengte (m.b.)
//Difference body joint length? => age guesstimation -> Pixel diff height-range
//Homography Matrix -> 2d -> 3d w/ camera

.NH
Onderzoeksvragen
.NH 2
Hoofdvragen
.BL
Welk algoritme?
.BL
Meerdere camera's combineren?
.BL
Hoe kan positie bepaald worden?

.NH
Verwerking
.NH 2
Hoe kan positie bepaald worden?
.PP
.BL
Bluetooth
.PP
Door gebruik te maken van low energy beacons kunnen lokaties van mensen bepaald worden. Het aantal beacons heeft een invloed op het aantal dimensies waarin iemands lokatie bepaald kan worden. Deze relatie is als volgt:
.BL
2D #-># 2 beacons nodig. 
.BL
3D #-># 2 beacons + hoogtemap of 3 beacons. 

Een 3D positie achterhalen leverde volgens dit onderzoek
.[
bluetoothposition
.]
in 27.3% van de gevallen een lagere error waarde op dan bij het berekenen van een 2d positie. 

.NH
Openpose
.PP
.TS
tab(@) allbox;
c c
l l.
Feature Present @ -Missing
IP camera       @\
T{
Position Estimation (needs two camera's) (multiple person #-># fail)
T}
GPU selection   @ 
Video input
Image input
Hide display
Disable bodypart
Heatmap output
Skip frames if behind
Save output
Multi camera
T{
Camera types:
.BS
Flir
.BS
Normal
T}
Optimization
T{
>7 FPS #-># can generate ~same id
T}
UDP Communication
.TE

.NH
Conclusie
.PP
//Voorlopig #-># Openpose bestaat sinds 2017, gebruikt dataset van Kinect, waarschijnlijk vanwege vele features.

//TODO: remove
.NH
Considerations
.PP
.BL
Klimrek -> positie inschatten (hooger lijkt verder weg)
.BL
Depth A.I.:
    https://github.com/ialhashim/DenseDepth
    https://robomechjournal.springeropen.com/articles/10.1186/s40648-018-0119-5
    https://github.com/nianticlabs/monodepth2

//UniPose: https://arxiv.org/pdf/2001.08095.pdf / https://openaccess.thecvf.com/content_CVPR_2020/papers/Artacho_UniPose_Unified_Human_Pose_Estimation_in_Single_Images_and_Videos_CVPR_2020_paper.pdf

//3d Position Estimation
https://www.cv-foundation.org/openaccess/content_cvpr_2013/papers/Simo-Serra_A_Joint_Model_2013_CVPR_paper.pdf

//2d/3d pose estimation papers
https://github.com/huyhieupham/State-of-the-art-approaches-on-2D-3D-Human-Pose-Estimation

//Multiperson 3d Position (nadeel->onze camera staat op vaste plek)
https://kilthub.cmu.edu/articles/Reconstructing_3D_Human_Pose_from_2D_Image_Landmarks/6560621/files/12042908.pdf

//Full 3d model monocular multiperson
http://openaccess.thecvf.com/content_cvpr_2018/papers/Zanfir_Monocular_3D_Pose_CVPR_2018_paper.pdf

//3d pose & (seems) multiperson position
https://github.com/DenisTome/Lifting-from-the-Deep-release

//Depth estimation stereo camera
https://github.com/ArpitaSTugave/Depth-Estimation-using-CNN

//Keep it SMPL: Automatic Estimation of 3D Human Pose and Shape from a Single Image
http://files.is.tue.mpg.de/black/papers/BogoECCV2016.pdf

//Position estimation
https://digitalcommons.usu.edu/cgi/viewcontent.cgi?article=1495&context=etd

//People counting paper
https://digitalcommons.usu.edu/cgi/viewcontent.cgi?article=1495&context=etd

//Calculate max range radar
https://www.allaboutcircuits.com/tools/radar-maximum-range-calculator/

//Used by Fontys group
https://pjreddie.com/darknet
.TC
