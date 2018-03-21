/* Description 
* This function will spawn a group consisting of at least one men or vehicle at a given entrypoint. 
*
* Parameters 
* _entrypoint is an array which stores needed information about the initialisation. "entrySouthAir = [[2412.01, 6036.33, -0.839965], side, entryDir];"
* _side is the side which gets reinforcement.
* _entryDir is the direction unit shall face when spawn on the given entrypoint. Should be 0 when South, 180 when North and so on.
* _units is an array which stores classnames of men.
* _vehicles is an array which stores classnames of vehicles.
* _waypoints is an array which stores information about waypoints in form of lists (other arrays).
*
* Return
* This method has no return.
*/
params ["_entrypoint", "_units", "_vehicles", "_waypoints"];

if (!isDedicated) exitWith {};

_entrypoint = _this select 0;

if (isNull _entrypoint) exitWith {};

_units = _this select 1;
_vehicles = _this select 2;
_waypoints = _this select 3;

_position = _entrypoint select 0;
_side = _entrypoint select 1;
_entryDir = _entrypoint select 2;

_group = createGroup [_side, true];

if ((count _units) > 0) then {
	_group = [_position, _side, _units,[],[],[],[],[], _entryDir] call BIS_fnc_spawnGroup // TODO: check if it should be [_units] instead of _units
};

if ((count _vehicles) > 0) then { 
	for "_i" from 0 to count _vehicles -1 do {
		_vehicle = createVehicle [_vehicles select _i, _position, [], _entryDir, "FORM"]; 
		createVehicleCrew _vehicle;
		(crew _vehicle) joinSilent _group;
	};
}; 

if ((count _waypoints) < 0) then {
	for "_i" from 0 to count _waypoints -1 do {
		_group addWaypoint (_waypoints select _i) // [center, radius, index, name]
	};
};