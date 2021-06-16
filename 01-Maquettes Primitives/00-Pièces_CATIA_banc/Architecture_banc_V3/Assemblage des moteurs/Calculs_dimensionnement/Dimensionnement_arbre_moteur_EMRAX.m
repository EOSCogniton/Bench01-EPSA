%% Dimensionnement arbre moteur 
%%Diamètre arbre sortie moteur
d=40 %(mm)

%%Moment de la génératrice (cas critique si une erreur est commise et que
%%la génératrice est utilisée en fonctionnement moteur/Le moment maxi de
%%l'EMRAX ne dépasse pas 230N.m
Mt=471*10^3 %(N.mm)

%%Moment quadratique de l'arbre de sortie
Io=(pi*d^4)/32

%%Calcul de la contrainte max lié à la torsion de l'arbre 
Tau=Mt/(Io/(d/2)) %(en MPa)

%% Dimensionnement Accoupelment élastique Norelem 
%Données de raideur des deux accouplements 
K1 = 8; % en Nm/arcmin
K2 = 66.9; % en Nm/arcmin

Conversion = 3437.75; %1 radian = 3437,75 arcmin

Kelastique=K1*Conversion; % en Nm/rad
Ksoufflet=K2*Conversion; % en Nm/rad

InertieElastique = 5.2*10^-3; % en kgm²
InertieSoufflet = 4.7*10^-3; % en kgm²


InertieGeneratrice = 0.652; % en kgm²
InertieMoteur = 0.0383; % en kgm²
InertieArbre = 0.002; % en kgm²

%Formule de calcul de la première fréquence propre du système (Page 11/140)
%https://www.rw-france.fr/fileadmin/images/Produkte_fr/PK_Katalog_FR_screen-pdf.pdf

felastique = (1/(2*pi))*sqrt(Kelastique*(InertieMoteur+InertieElastique/2+InertieArbre+InertieGeneratrice+InertieElastique/2)/((InertieMoteur+InertieElastique/2+InertieArbre)*(InertieGeneratrice+InertieElastique/2)))
fsoufflet = (1/(2*pi))*sqrt(Ksoufflet*(InertieMoteur+InertieSoufflet/2+InertieArbre+InertieGeneratrice+InertieSoufflet/2)/((InertieMoteur+InertieSoufflet/2+InertieArbre)*(InertieGeneratrice+InertieSoufflet/2)))


