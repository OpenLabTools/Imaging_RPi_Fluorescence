/*********************************************************************/
/* 	Modified: 14:25 22/07/2014													*/ 
/* 	filterComponents.scad 														*/ 
/* 																						*/
/* 	This files contains four modules that create components relating	*/
/* to the filter. They are:														*/
/* 			1. filterPlate - base plate where the filter sits				*/
/* 			2. filterClip - clip for base plate which holds filter in  */
/* 								plate													*/
/* 			3. rightFilterGroove - groove to slot filterPlate into 		*/
/* 			3. leftFilterGroove - groove to slot filterPlate into 		*/
/* 																						*/
/* 	ISSUE: This is only designed to accommodate a filter of thickness	*/
/* 			 1mm.																		*/
/* 																						*/
/*********************************************************************/


/*
 * Files needed
 * ====================================================================
 */

include <configuration.scad>;


// "+1" has been included to allow the filter to fit into the slot easily
// HACK: the thickness of the plate has been set to 4, it doesn't change and could cause issues if filter thickness is much larger than 1mm

module filterPlate()
{
	difference()
	{
		union()
		{
			cube ([filterLength + 2*filterMT + 1, filterWidth + 2*filterMT + 1, 4], center=true);
		}
	
		union()
		{	
			translate([0,0,1.5]) cube ([filterLength + 1, filterWidth + 1 ,4], center=true); // Platform for filter to rest on
			cube ([filterLength - filterMT, filterWidth - filterMT, 4], center=true);
			translate([-(filterLength + filterMT + 1)/2, 0, 1]) cube ([filterMT,6,0.8], center=true); // Slot to slide clip into
		}
	}
}

module filterClip()
{
	difference()
	{
		union()
		{
			cube([filterLength+0.5, filterWidth+0.5, filterThickness]);
			translate ([-filterMT,5.75,0]) cube([filterMT,5,filterThickness/2]);
		}
	
		union()
		{	
			translate([filterMT,filterMT,0]) cube([21.5,12.5,filterThickness]);
		}
	}
}

module rightFilterGroove()
{
	difference()
	{
		union()
		{
			cube([filterWidth + 2*filterMT + 1 + 2*2, 4, 4 + 2]);
			translate([0,0,4 + 2]) cube([(filterWidth + 2*filterMT + 1 + 2*2)/2,4,2]);
		}

		union()
		{
			translate([2,2,2]) cube([23,2,4.1]);
		}
	}
}

module leftFilterGroove()
{
	difference()
	{
		union()
		{
			cube([filterWidth + 2*filterMT + 1 + 2*2, 4, 4 + 2]);
			translate([0,0,4 + 2]) cube([(filterWidth + 2*filterMT + 1 + 2*2)/2,4,2]);
		}

		union()
		{
			translate([2,0,2]) cube([filterWidth + 2*filterMT + 1 + 2,2,4.1]);
		}
	}
}