/*********************************************************************/
/* 	Modified: 14:25 18/07/2014													*/ 
/* 	configuration.scad 															*/ 
/* 																						*/
/* 	This files contains all the variables that are needed to create	*/
/* the fluoroscence module.														*/
/* Set the desired values here and they will then be used in all the	*/
/* other files to make the module to the correct dimensions.			*/
/* 																						*/
/*********************************************************************/


$fn = 50;


/*
 * Filter dimension variables
 * ====================================================================
 */

filterWidth = 16;
filterLength = 25;
filterThickness = 1;
filterMT = 2; // Thickness of filter support


/*
 * Main box variables
 * ====================================================================
 */

MT = 3; // Material thickness
Screw = 3; // Diameter of screw being used
ExtraM = 2; //Extra material around screw
ScrewM = Screw + ExtraM; // Thickness of screw support 


/*
 * Microscope optics dimensions
 * ====================================================================
 */

CylinderH = 20; // Height of cylinder
CylinderD = 29; // Diameter of optical section
CylinderT = 10; // Thickness of cylinder