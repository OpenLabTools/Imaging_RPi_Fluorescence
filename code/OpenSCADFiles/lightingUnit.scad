/*********************************************************************/
/* 	Modified: 14:25 22/07/2014													*/
/* 	lightingUnit.scad		 														*/
/* 																						*/
/* 	This files contains two modules that create components relating	*/
/* to the filter. They are:														*/
/* 			1. singleLED - housing for LED connected to power supply		*/
/* 			2. ConstCurrent - housing for LED connected to constant 		*/
/* 								   current supply									*/
/* 			3.	cover - cover for housing - pass "CC" for cover for 		*/
/* 						  ConstCurrent housing. Leave blank otherwise		*/
/* 																						*/
/*********************************************************************/


/*
 * Files needed
 * ====================================================================
 */

include <configuration.scad>;


module singleLED()
{
	difference()
	{
		union()
		{
			cube([40,12,19]);
			translate([7.5,-5,4]) cube([25,5,11]);
		}

		union()
		{
			translate([8.5,-5,5]) cube([23,5,9]);
			translate([2.5,3,3]) cube([34,12,13]);
			translate([20,5,9.5]) rotate([90,0,0]) cylinder(r=3,h=10);
		}
	}
}
ConstCurrent();
module ConstCurrent()
{
	difference()
	{
		union()
		{
			cube([40,30,40]);
			translate([7.5,-5,3]) cube([25,5,11]);
		}

		union()
		{
			translate([8.5,-5,4]) cube([23,5,9]);
			translate([3,3,3]) cube([34,30,34]);
			translate([20,5,8.5]) rotate([90,0,0]) cylinder(r=3,h=10);
		}
	}
	
	difference()
	{
		union()
		{
			translate([3,3,3]) cube([8,3,8]);
			translate([29,3,3]) cube([8,3,8]);
			translate([3,3,29]) cube([8,3,8]);
			translate([29,3,29]) cube([8,3,8]);
		}
		union()
		{
			translate([9,8.5,7.5]) rotate([90,0,0]) cylinder(r=1.5, h=5);
			translate([31.5,8.5,7]) rotate([90,0,0]) cylinder(r=1.5, h=5);
			translate([9,8.5,32.5]) rotate([90,0,0]) cylinder(r=1.5, h=5);
			translate([33,8.5,33]) rotate([90,0,0]) cylinder(r=1.5, h=5);
		}
	}
}


// If cover is required for ConstCurrent housing, pass the string "CC" to cover module.
// If cover is required for singleLED housing, do not pass anything to cover module.
module cover(whichOne)
{
	if (whichOne == "CC")
	{
		//extra = 21;
	}
	else
	{
		//extra = 0;
	}

	difference()
	{
		union()
		{
			cube([40,2,19 + extra]); 
			translate([2.75,-5,3.25]) cube([34,5,12.5 + extra]); 
		}

		union()
		{
			translate([3.75,-5,4.25]) cube([31.5,6,10.5 + extra]); 
			translate([35,3.5,9.5]) rotate([90,0,0]) cylinder(r=1.5, h=9);
			translate([35,-6,8]) cube([7,10,3]);
		}
	}
}
