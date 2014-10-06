/*********************************************************************/
/* 	Modified: 14:25 22/07/2014												 	*/
/* box.scad					 										 				*/
/* 																	 					*/
/* 	This files contains four modules that create components relating 	*/
/* to the component that houses the filters and light source. They 	*/
/* are	:															 					*/
/* 			1. plate - end plates that connect component housing to 		*/
/* 						  microscope								 					*/
/* 			2. topFilterPlate - top end plate that is required in 		*/
/* 									  addition to the plate to mount filter	*/
/* 			3. box - main filter housing component		 					*/
/* 			4. screwHole - used by module box, can be ignored				*/
/* 																	 					*/
/*********************************************************************/


/* IMPROVEMENTS NEEDED TO THIS FILE: */
/* 
/* Modify plate so that a connector is made to attach it to the microscope - currently there is nothing
*/

/*
 * Files needed
 * ====================================================================
 */

include <configuration.scad>;
use <filterComponents.scad>;


/*
 * End plates to connect onto the lens system
 * ====================================================================
 */

// plate module takes three arguments - x and y which determine the size of the end plate and are integers (this should be the same as the x and y dimensions of the box, and a whichEnd variable which is a String that should be passed as either "top" or blank. Passing "top" tells the module to make the top plate and not passing anything defaults it to making the bottom plate. 

module plate(x,y,whichEnd)
{
	difference()
	{
		union()
		{
			// Determines thickness of plate depending on if the additional topFilterPlate() component is required. 
			if (whichEnd == "top")
			{
				cube([x,y,MT/2]);
				translate([x/2,y/2,MT/2]) cylinder(r=CylinderD/2, h=CylinderH);
			} else {
				cube([x,y,MT]);
				translate([x/2,y/2,MT]) cylinder(r=CylinderD/2, h=CylinderH);
			}
		}
	
		union()
		{
			translate([x/2,y/2,0]) cylinder(r=(CylinderD-CylinderT)/2,h=CylinderH+MT);

			// Screw Holes
			for (ix = [[(MT+ScrewM)/2,(MT+ScrewM)/2,0],[(MT+ScrewM)/2,y-(MT+ScrewM)/2,0],[x-(MT+ScrewM)/2,(MT+ScrewM)/2,0],[x-(MT+ScrewM)/2,y-(MT+ScrewM)/2,0]])
			{
				translate (ix) cylinder(r=Screw/2, h=MT);
			}
		}
	}
}

// topFilterPlate module is required for the top end plate as this component is where the filter is housed - it cannot be combined with the top end plate component as it cannot be 3D printed successfully. 

module topFilterPlate(x,y)
{
	difference()
	{
		union()
		{
			cube([x,y,MT/2]);
		}
	
		union()
		{
			translate([x/2,y/2,0]) cylinder(r=(CylinderD-CylinderT)/2,h=CylinderH+MT);

			// Screw Holes
			for (ix = [[(MT+ScrewM)/2,(MT+ScrewM)/2,0],[(MT+ScrewM)/2,y-(MT+ScrewM)/2,0],[x-(MT+ScrewM)/2,(MT+ScrewM)/2,0],[x-(MT+ScrewM)/2,y-(MT+ScrewM)/2,0]])
			{
				translate (ix) cylinder(r=Screw/2, h=MT);
			}
		}
	}
	translate([x/2,y/2,-2]) rotate ([180,0,0]) filterPlate();
}



/*
 * Main filter housing component
 * ====================================================================
 */

// box module takes three arguments relating to the dimensions of the housing unit required.
module box(x,y,z)
{
	difference()
	{
		union()
		{
			cube([x,y,z]); // Main Body
		}
	
		union()
		{
			// Centre Cutout
			translate([MT,MT,]) cube([x-2*MT, y-2*MT, z]);
			
			// Cut out for screw holes
			for (ix=[[MT/2,MT/2,0],[MT/2,y-(MT/2+ScrewM),0],[x-(MT/2+ScrewM),MT/2,0],[x-(MT/2+ScrewM),y-(MT/2+ScrewM),0]])
			{
				translate(ix) cube([ScrewM,ScrewM,z]);
			}

			// Cutout for lighting element
			translate([x-MT,y/2 - 12.5,4]) cube([MT,filterLength,filterWidth * sin(45)]);
		}
	}

	// Screw holes
	for (ix=[[MT/2,MT/2,0],[MT/2,y-(MT/2+ScrewM),0],[x-(MT/2+ScrewM),MT/2,0],[x-(MT/2+ScrewM),y-(MT/2+ScrewM),0]])
	{
		translate(ix) screwHole(z);
	}

	// Groove for filter held at 45 degrees to slot into
	translate([(x-(filterWidth + 2*filterMT + 1 -4)*sin(45))/2,MT-0.5,1]) rotate([0,-45,0]) rightFilterGroove();
	translate([(x-(filterWidth + 2*filterMT + 1 -4)*sin(45))/2,y-(MT+4-0.5),1]) rotate([0,-45,0]) leftFilterGroove();

}

// Module used by box - ignore
module screwHole(z)
{
	difference()
	{
		union()
		{
			cube([ScrewM, ScrewM, z]);
		}
	
		union()
		{	
			for (iz= [0, z*0.75])
			{
				translate([ScrewM/2, ScrewM/2,iz]) cylinder(r=Screw/2, h=z/4);
			}			
		}
	}
}