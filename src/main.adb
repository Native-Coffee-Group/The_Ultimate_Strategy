with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Characters.Latin_1;
with Game_Loop;

procedure Main is
	Main_Loop: Game_Loop.Object := Game_Loop.Create;
	Next_Input: Game_Loop.Command;
	String_Input: Character;
        Last : Boolean := False;
begin
				Put(Ada.Characters.Latin_1.ESC & "[2J");
        Main_Loop.Setup_Game_Board;
	Main_Loop.Print_Game_Board;


	while true loop
		Get_Immediate(Item => String_Input, Available => Last);
		Next_Input := Game_Loop.Convert(String_Input);
		--Put_Line("Next Input: " & To_String(Next_Input));
		case Next_Input is
			when Game_Loop.Quit =>
				Put(Ada.Characters.Latin_1.ESC & "[2J");
				exit;
			when Game_Loop.Fire =>
				Put(Ada.Characters.Latin_1.ESC & "[2J");
                                Main_Loop.Fire;
				Main_Loop.Move_Projs;
				Main_Loop.Print_Game_Board;
			when Game_Loop.Left =>
				Put(Ada.Characters.Latin_1.ESC & "[2J");
				Main_Loop.Move(Dir => False);
				Main_Loop.Move_Projs;
                                Main_Loop.Print_Game_Board;
			when Game_Loop.Right => 
				Put(Ada.Characters.Latin_1.ESC & "[2J");
				Main_Loop.Move(Dir => True);
				Main_Loop.Move_Projs;
                                Main_Loop.Print_Game_Board;
			when Game_Loop.None => 
				null;
		end case;
		--Main_Loop.Print_Game_Board;
	end loop;

end Main;





