with Ada.Text_IO; use Ada.Text_IO;

package body Game_Loop is

	procedure Print_Game_Board(Self: in out Object) is
	begin
		for Line of Self.Game_Board loop
			Put_Line(To_String(Line));
		end loop;
	end Print_Game_Board;

	procedure Setup_Game_Board(Self: in out Object) is
	begin
		Self.Game_Board := String_Vectors.Empty_Vector;
		Self.Game_Board.Append(To_Unbounded_String("###################"));
		Self.Game_Board.Append(To_Unbounded_String("#    | _  _ |     #"));
		Self.Game_Board.Append(To_Unbounded_String("#    | O  O |     #"));
		Self.Game_Board.Append(To_Unbounded_String("#    |  __  |     #"));
		Self.Game_Board.Append(To_Unbounded_String("#    \______/     #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("#                 #"));
		Self.Game_Board.Append(To_Unbounded_String("# |               #"));
		Self.Game_Board.Append(To_Unbounded_String("#| |              #"));
		Self.Game_Board.Append(To_Unbounded_String("###################"));

	end Setup_Game_Board;

	function Create return Object is 
	begin

		return Object'(Game_Board => <>,
		Board_Size => <>,
		Top_Pos => <>,
		Bot_Pos_1 => <>,
		Bot_Pos_2 => <>,
		Proj_Vec => <>);
	end Create;

	function Convert(Input: Character) return Command is
		Tmp_Command: Command := Left;
	begin
		if Input = 'q' then
			Tmp_Command := Quit;
		elsif Input = 'w' then
			Tmp_Command := Fire;
		elsif Input = 'a' then
			Tmp_Command := Left;
		elsif Input = 'd' then
			Tmp_Command := Right;
		else
			Tmp_Command := None;
		end if;

		return Tmp_Command;
	end Convert;


	procedure Move(Self: in out Object;
		Dir:  in     Boolean) is
		New_Bottom: Unbounded_String;
		New_Top: Unbounded_String;
		New_Bot_Pos_1 : Natural;
		New_Bot_Pos_2 : Natural;
		New_Top_Pos : Natural;
	begin

		if Dir then
			New_Bot_Pos_1 := Self.Bot_Pos_1 + 1;
			New_Bot_Pos_2 := Self.Bot_Pos_2 + 1;
			New_Top_Pos := Self.Top_Pos + 1;
		else
			New_Top_Pos := Self.Top_Pos -1;
			New_Bot_Pos_1 := Self.Bot_Pos_1 -1;
			New_Bot_Pos_2 := Self.Bot_Pos_2 -1;
		end if;

		New_Bottom := Insert_In_Board(New_Bot_Pos_1,
		CLEAN_ROW,
		'|');

		New_Bottom := Insert_In_Board(New_Bot_Pos_2,
		New_Bottom, '|');

		New_Top := Insert_In_Board(New_Top_Pos,
		CLEAN_ROW,
		'|');

		if New_Bot_Pos_1 > MIN_POS and then New_Bot_Pos_2 < MAX_POS then
			Self.Game_Board.Replace_Element(Index => BOTTOM,
			New_Item => New_Bottom);
			Self.Game_Board.Replace_Element(Index => TOP,
			New_Item => New_Top);
			Self.Bot_Pos_1 := New_Bot_Pos_1;
			Self.Bot_Pos_2 := New_Bot_Pos_2;
			Self.Top_Pos := New_Top_Pos;
		end if;

	end Move;

	procedure Fire(Self: in out Object) is
		New_Line : Unbounded_String;
	begin
		New_Line := Insert_In_Board(Pos => Self.Top_Pos,
		Line => Self.Game_Board.Element(FIRE_START),
		Char => 'o');

		Self.Game_Board.Replace_Element(Index => FIRE_START,
		New_Item => New_Line);

		Self.Proj_Vec.Append((Pos_X => Self.Top_Pos,
		Pos_Y => FIRE_START));
	end Fire;


	procedure Move_Projs(Self: in out Object) is
		New_Line: Unbounded_String;
		Old_Line: Unbounded_String;
	begin
		for Proj of Self.Proj_Vec loop
			New_Line := Insert_In_Board(Proj.Pos_X,
			Self.Game_Board.Element(Proj.Pos_Y + 1),
			'o');
			
			Old_Line := Insert_In_Board(Proj.Pos_X,
			Self.Game_Board.Element(Proj.Pos_Y),
			' ');
			
			Self.Game_Board.Replace_Element(Index => Proj.Pos_Y +1,
			New_Item => New_Line);
			Self.Game_Board.Replace_Element(Index => Proj.Pos_X + 1,
			New_Item => Old_Line);
		end loop;

	end Move_Projs;

	function Insert_In_Board(Pos: in Natural;
		Line: in Unbounded_String;
		Char: in Character) return Unbounded_String is
		New_Line : Unbounded_String;
	begin
		for I in 1..MAX_RIGHT loop
			if I = Pos then
				New_Line := New_Line & Char;
			else 
				New_Line := New_Line & Element(Line,I);
			end if;
		end loop;

		return New_Line;
	end Insert_In_Board;
end Game_Loop;
