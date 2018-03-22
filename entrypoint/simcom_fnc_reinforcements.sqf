/* Description 
* This function will spawn a group consisting of at least one men or vehicle at a given entrypoint. 
*
* Parameters 
* _entrypoint is an array which stores needed information about the initialisation. "entrySouthAir = [[2412.01, 6036.33, -0.839965], side, entryDir];"
* _side is the side which gets reinforcement.
* _entryDir is the direction unit shall face when spawn on the given entrypoint. Should be 0 when South, 180 when North and so on.
* _units is an array which stores classnames of men.
* _vehicles is an array which stores classnames of ground vehicles.
* _air is an array which stores classnames of air vehicles.
* _waypoints is an array which stores information about waypoints in form of lists (other arrays).
* _inCargo is a boolean which when true will load all men into cargo of _vehicles or _air.
*
* Return
* This method has no return.
*/
params ["_entrypoint", "_units", "_vehicles", "_air", "_waypoints", "_inCargo"];

_entrypoint = _this select 0;

if ((count _entrypoint) == 0) exitWith {};

_units = _this select 1;
_vehicles =_this select 2; 
_air = _this select 3;
_waypoints = _this select 4;
_inCargo = _this select 5;

_position = _entrypoint select 0;
_side = _entrypoint select 1;
_entryDir = _entrypoint select 2;

_group = createGroup [_side, true];

if ((count _vehicles) > 0) then { 
	for "_i" from 0 to count _vehicles -1 do {
		_vehicle = createVehicle [_vehicles select _i, _position, [], _entryDir, "FORM"]; 
		createVehicleCrew _vehicle;
		(crew _vehicle) joinSilent _group;
	};
}; 

if ((count _air) > 0) then {
	for "_i" from 0 to count _air -1 do {
		_vehicle = createVehicle [_vehicles select _i, _position, [], _entryDir, "FLY"]; 
		createVehicleCrew _vehicle;
		(crew _vehicle) joinSilent _group;	
	};
};

if ((count _units) > 0) then {
	
	_infantry = [_position, _side, _units,[],[],[],[],[], _entryDir] call BIS_fnc_spawnGroup

	if (_inCargo) then {
		_cargos = [];
		_cargos pushBack _vehicle;
		_cargos pushBack _air;
		_availableSeats = [];
		{
			if (isNull (fullCrew [_x, "cargo", true] select 0)) then {
				_availableSeats pushBack _x;		
			};
		} forEach _cargos;

		{
		 _x moveInCargo _availableSeats;

		} foreach _infantry;
	};
};

if ((count _waypoints) > 0) then {
	for "_i" from 0 to count _waypoints -1 do {
		_group addWaypoint [_waypoints select _i, 0] // [center, radius, index, name]
	};
};