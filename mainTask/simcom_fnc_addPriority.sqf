/*
* Description
* A list of lists which stores: (1) positional data, (2) kind of task which can be assigned to within this area and (3) an integer which shows the priority.
* 
* Parameters
* _areaData is the position of the priority
* _areaData:
* "GREEN" = "Green Zone";
* "YELLOW" = "Unknown Area of Operation";
* "RED" = "Enemy Territory";
* "BLUE" = "Controlled Area";
* "ORANGE" = "Area of Operation";
* "BROWN" = "Ambush";
* 
* Aggressive Doctrine = Attack Red and/ or invade UAOO, if turns RED attack, if green leave and S&D.
* Defensive Doctrine = Defend BLUE Area, go to YELLOW, check RED, if GREEN stay. If RED do artillery strikes etc..
* Mixed Doctrine = Attack RED AREA, go to Yellow, if RED attack OR do artillery or do both.
*
* [[[2564, 2356], "COLOR", 0- 10]];
*
* Priority is a number from 0 to 10 where 10 is highly importent and 0 gets deleted.
* 
*/
params["_areaData"];

_areaData = _this select 0;
if !(isNull priorities) then {
	priorities pushBack _areaData;
}
