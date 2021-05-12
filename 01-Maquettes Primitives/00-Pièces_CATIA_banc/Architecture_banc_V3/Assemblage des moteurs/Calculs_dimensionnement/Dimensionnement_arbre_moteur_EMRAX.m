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