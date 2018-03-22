/*
* Description
* A task created for a group
* Offensive, Defensive, Ambush, Guard, Position (Emplacement, e.g. SAM).-
*
* Parameters
* _group is the group which will get assigned to the task if no task has been assigned earlier.
*
*
*/
params ["_group"];

_group = _this select 0;

if !(_group getVariable "task") then {

	_role = _group getVariable "role";
	_kind = doctrine getVariable "kind";

	switch (_role) do { 
		case "AA" : { 
			
			switch (_kind) do { 
				case 1 : {  
					[_group,[],["Ambush","Move to the designated position and wait for enemy air units to engage.","ambushMark"],[0,0,0],1,2,true] call BIS_fnc_taskCreate
				}; 
				case 2 : {  }; 
				
				default { }; 
				};			
			
			
				
			};
		}; 
		case 2 : {   }; 
		default {   }; 
	};

};
