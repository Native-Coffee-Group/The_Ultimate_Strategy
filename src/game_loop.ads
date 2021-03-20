with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Containers.Vectors;

package Game_Loop is

	package String_Vectors is new Ada.Containers.Vectors(Natural, Unbounded_String);

	type Proj is record
		Pos_X : Natural := 1;
		Pos_Y : Natural := 1;
	end record;

	package Proj_Vectors is new Ada.Containers.Vectors(Natural, Proj);

	TOP : Natural := 17;
	BOTTOM : Natural := 18;
	MAX_RIGHT : Natural :=19;

	MIN_POS : Natural := 1;
	MAX_POS : Natural := 19;

	FIRE_START : Natural := 16;
	FIRE_LAST_POS : Natural := 6;

	CLEAN_ROW : Unbounded_String := To_Unbounded_String("#                 #");

	type Object is tagged record
		Game_Board: String_Vectors.Vector := String_Vectors.Empty_Vector;
		Board_Size: Natural := 20;
		Top_Pos: Natural := 3;
		Bot_Pos_1: Natural := 2;
		Bot_Pos_2: Natural := 4;
		Proj_Vec: Proj_Vectors.Vector := Proj_Vectors.Empty_Vector;
	end record;

	type Object_Access is access all Object;

	type Command is (None, Left, Right, Fire, Quit);
	type Board_Type is (Projectile, Player);

	function Create return Object;

	procedure Setup_Game_Board(Self: in out Object);
	procedure Print_Game_Board(Self: in out Object);

	procedure Move(Self: in out Object;
		Dir:  in     Boolean); 

	procedure Fire(Self: in out Object);

	function Convert(Input: Character) return Command;
	function Insert_In_Board(Pos: in Natural;
		Line: in Unbounded_String;
		CHar: in Character) return Unbounded_String;
		procedure Move_Projs(Self: in out Object);
	end Game_Loop;
