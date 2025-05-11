.386
.model flat, stdcall
.stack 4096
Include irvine32.inc

.data
	mazeHeight db 27
	mazeWidth db 107
	mazeLayout db 27 dup (107 dup(?))

	player_name db "No Name", 247 dup(?)

	pacman db 'X'
	wall db '#'
	ghost db '@'

	end_line db " ", 0ah, 0

	instructions1 db " > Press W to move UP ", 0
	instructions2 db " > Press S to move DOWN ", 0
	instructions3 db " > Press A to move LEFT ", 0
	instructions4 db " > Press D to move RIGHT ", 0
	instructions5 db " > Press P to PAUSE Game ", 0

	prompt1 db "Score: ", 0
	prompt2 db "Level: ", 0
	prompt3 db "Lives: ", 0
	prompt4 db "--> Press P to Play", 0
	prompt5 db "--> Press I to Instructions", 0
	prompt6 db "--> Press E to Exit", 0
	prompt7 db "Enter your Name: ", 0
	prompt8 db " > Press P to Resume", 0
	prompt9 db " > Press E to Exit", 0
	prompt10 db " PRESS E TO GO BACK TO MAIN MENU", 0
	prompt11 db "-> PLayer Name: ", 0
	prompt12 db "-> Score: ", 0
	prompt13 db " > Press R to Restart", 0

	welcome db "-----WELCOME to the parody of PACMAN-----", 0
	game_name db "- - - - >  P A C M A N  < - - - -", 0
	over db "- - -   G A M E   O V E R   - - -", 0
	pause_prompt db "- - -   G A M E   P A U S E D   - - -", 0
	instructions_prompt db "- - -   I N S T R U C T I O N S   M E N U   - - -", 0

	score dd 0
	level db 1
	lives db 3

	xPos db 54
	yPos db 16

	ghost1Pos db 2 dup(?)
	ghost2Pos db 2 dup(?)
	ghost3Pos db 2 dup(?)

	ghost1_timer dd 500
	ghost2_timer dd 500
	ghost3_timer dd 500

	ghost1_movement db ?
	ghost2_movement db ?
	ghost3_movement db ?

	inputChar db ?
	is_alive db 1
	bool_gameOver db 0

	layout1  db "###########################################################################################################"
	         db "#                                                                                                         #"
	         db "#                                                                                                         #"
	         db "#         ......................................................................................          #"
	         db "#         @                                                                                               #"	
	         db "#              ............................................................................               #"	
	         db "##########    ####################################    ######################################     ##########"
	         db "#                 .....................................................................                   #"
			 db "#                                                                                                         #"
	         db "#                                                                                                         #"
			 db "#                             ###   ###                   ############   ############                     #"
			 db "#                             ###   ###                   ###      ###   ###      ###                     #"
			 db "#                             ###   ###                   ###      ###   ###      ###                     #"
			 db "#                             ###   ###                   ############   ###      ###                     #"
			 db "#                             ###   ###               X   ###      ###   ###      ###                     #"
			 db "#                             ###   ###                   ###      ###   ###      ###                     #"
			 db "#                             ###   ###                   ############   ############                     #"
			 db "#                                                                                                         #"
			 db "#                                                                                                         #"
			 db "#                  .....................................................................                  #"
			 db "##########    ####################################    ######################################     ##########"
			 db "#              ............................................................................               #"
			 db "#                                                                                                         #"
			 db "#         ......................................................................................          #"
			 db "#                                                                                                         #"
			 db "#                                                                                                         #"
			 db "###########################################################################################################", 0

	layout2  db "###########################################################################################################"
	         db "#   ....................   ##                                               ##   ......................   #"
	         db "#   ..                ..   ##    .......................................    ##   ..                  ..   #"
	         db "#   ..  ############  ..   ##    ..         *               *         ..    ##   ..   #############  ..   #"
	         db "#   ..          * ##  ..   ##    ..    ###########################    ..    ##   ..   ##  *          ..   #"	
	         db "#   ..  ############  ..   ##    ..    ###########################    ..    ##   ..   #############  ..   #"	
	         db "#                                                                                                         #"
	         db "#  @                                                                                                      #"
			 db "#                                                                                                         #"
	         db "#     .............                    ..............................                   .............     #"
			 db "#                                                                                                         #"
			 db "#       #########                                                                         #########       #"
			 db "#           #           ########              ################           ########             #           #"
			 db "#           #                                 ## *        * ##                                #           #"
			 db "#           #           ########              #####   X  #####           ########             #           #"
			 db "#       #########                                                                         #########       #"
			 db "#                                                                                                         #"
			 db "#     .............                    ..............................                    .............    #"
			 db "#                                                                                                         #"
			 db "#                                                                                                         #"
			 db "#                                                                                                         #"
			 db "#   ..  ############  ..   ##    ..    ###########################    ..    ##   ..   #############  ..   #"
			 db "#   ..          * ##  ..   ##    ..    ###########################    ..    ##   ..   ##  *          ..   #"
			 db "#   ..  ############  ..   ##    ..         *               *         ..    ##   ..   #############  ..   #"
			 db "#   ..                ..   ##    .......................................    ##   ..                  ..   #"
			 db "#   ....................   ##                                               ##   ......................   #"
			 db "###########################################################################################################", 0

	layout3  db "###########################################################################################################"
	         db "# . # *  @  * # . #      #   #      #   #      #   #      #   #      #   #      #   #      #   #      # * #"
	         db "# . #         # . # .... #   # .... #   # ................................................................#"
	         db "# . #         # . #      #   #      #   #                                                                 #"
	         db "# .           # . #      #####      #   #      #   #      #   #      #   #      #   #      #   #      #   #"	
	         db "# . #         # . # .... #   # .... #   # ................................................................#"	
	         db "# . #         # . #      #   #      #   #@                                                                #"
	         db "# . #         # . #      #####      #####      #   #      #   #      #   #      #   #      #   #      #   #"
	         db "#             ............................................................................................#"
			 db "# * #         #   #      #   #      #   #      #   #      #   #      #   #      #   #      #   #      # * #"
			 db "###############     #################          ################      ################      ################"
			 db "#   #               #   #       #   #          #   #      #   #      #   #      #   #                 #   #"
			 db "#   #               #   #       #   #          #   #      #   #      #   #      #   #                 #   #"
			 db "###############     #################          ################      ################      ################"
			 db "# * #               #   #       #   #          #   #  X   #   #      #   #      #   #      #   #      # * #"
			 db "#@                                                                                                        #"
			 db "# . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #  #"
			 db "# . #      ...............................................................................................#"
			 db "# .        # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #  #"
			 db "# . #      ...............................................................................................#"
			 db "# . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #  #"	
			 db "# . #      ...............................................................................................#"
			 db "# . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #  #"
			 db "# .        ...............................................................................................#"
			 db "# . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #  #"
			 db "# . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #      # . #  #"
			 db "###########################################################################################################", 0

	


.code
main PROC   ;------------------------------------------------MAIN START-----------------------------------
	call mainMenu
	call showData
	cmp bool_gameOver, 1
	je endGame

	game_loop:
		cmp bool_gameOver, 1
		je endGame

		cmp score, 462
		je change_level

		cmp score, 984
		je change_level

		cmp score, 1793
		je endGame

		cmp lives, 0
		je endGame

		jmp normal_run

		change_level:
			add score, 10
			inc level
			call showData
			call InitializeGame

	  normal_run:
		call charInput
		call ghostMovement
		cmp bool_gameOver, 1
		je endGame
		
			loop game_loop

	endGame:
		call gameOver
		exit

main ENDP   ;------------------------------------------------ MAIN END------------------------------------

welcomeMenu PROC
	call clrscr
	mov eax, white + (black * 16)
	call SetTextColor

	mov dl, 44
	mov dh, 10
	call gotoxy
	mov edx, OFFSET welcome
	call writestring

	mov dl, 50
	mov dh, 12
	call gotoxy
	mov edx, OFFSET prompt7
	call writestring

	mov edx, OFFSET player_name
	mov ecx, 255
	call readString

	ret
welcomeMenu ENDP

mainMenu PROC
	call clrscr
	mov eax, white + (black * 16)
	call SetTextColor

	mov dl, 44
	mov dh, 10
	call gotoxy
	mov edx, OFFSET game_name
	call writestring

	mov dl, 49
	mov dh, 12
	call gotoxy
	mov edx, OFFSET prompt4
	call writestring

	mov dl, 49
	mov dh, 13
	call gotoxy
	mov edx, OFFSET prompt5
	call writestring

	mov dl, 49
	mov dh, 14
	call gotoxy
	mov edx, OFFSET prompt6
	call writestring

	menuLoop:
		mov eax, 0
		call readChar
		cmp al, 'p'
		je start_game

		cmp al, 'i'
		je instructions_menu

		cmp al, 'e'
		je exit_game

		jmp nnormal

		instructions_menu:
		call instructionsMenu

		nnormal:
			jmp menuLoop

	start_game:
		call welcomeMenu
		call InitializeGame
		jmp to_end

	

	exit_game:
		mov bool_gameOver, 1

	to_end:

	ret
mainMenu ENDP

instructionsMenu PROC
	call clrscr

	mov eax, white + (black * 16)
	call SetTextColor

	mov dl, 35
	mov dh, 10
	call gotoxy
	mov edx, OFFSET instructions_prompt
	call writestring

	mov dl, 47
	mov dh, 12
	call gotoxy
	mov edx, OFFSET instructions1
	call writestring

	mov dl, 47
	mov dh, 13
	call gotoxy
	mov edx, OFFSET instructions2
	call writestring

	mov dl, 47
	mov dh, 14
	call gotoxy
	mov edx, OFFSET instructions3
	call writestring

	mov dl, 47
	mov dh, 15
	call gotoxy
	mov edx, OFFSET instructions4
	call writestring

	mov dl, 47
	mov dh, 16
	call gotoxy
	mov edx, OFFSET instructions5
	call writestring

	mov dl, 59
	mov dh, 20
	call gotoxy
	mov edx, OFFSET prompt10
	call writestring

	instructionsMenu_loop:
		mov eax, 0
		call readChar
		cmp al, 'e'
		je _end

		jmp instructionsMenu_loop

	_end:
	
	call clrscr
	mov eax, white + (black * 16)
	call SetTextColor

	mov dl, 44
	mov dh, 10
	call gotoxy
	mov edx, OFFSET game_name
	call writestring

	mov dl, 49
	mov dh, 12
	call gotoxy
	mov edx, OFFSET prompt4
	call writestring

	mov dl, 49
	mov dh, 13
	call gotoxy
	mov edx, OFFSET prompt5
	call writestring

	mov dl, 49
	mov dh, 14
	call gotoxy
	mov edx, OFFSET prompt6
	call writestring

		ret
instructionsMenu ENDP

pauseMenu PROC
	call clrscr
	mov eax, white + (black * 16)
	call SetTextColor

	mov dl, 44
	mov dh, 10
	call gotoxy
	mov edx, OFFSET pause_prompt
	call writestring

	mov dl, 52
	mov dh, 12
	call gotoxy
	mov edx, OFFSET prompt8
	call writestring

	mov dl, 52
	mov dh, 13
	call gotoxy
	mov edx, OFFSET prompt13
	call writestring

	mov dl, 52
	mov dh, 14
	call gotoxy
	mov edx, OFFSET prompt9
	call writestring

	pauseMenu_loop:
		mov eax, 0
		call readChar
		cmp al, 'p'
		je start__game

		cmp al, 'r'
		je restart__game

		cmp al, 'e'
		je exit__game

		jmp pauseMenu_loop

	start__game:
		call clrscr
		call drawMaze
		jmp to__end

	restart__game:
		mov level, 1
		call InitializeGame
		jmp to__end

	exit__game:
		mov bool_gameOver, 1

	to__end:
		ret
pauseMenu ENDP

gameOver PROC
	call clrscr
	mov eax, white + (black * 16)
	call SetTextColor

	mov dl, 43
	mov dh, 10
	call gotoxy
	mov edx, OFFSET over
	call writestring

	mov dl, 47
	mov dh, 12
	call gotoxy
	mov edx, OFFSET prompt11
	call writestring
	mov edx, OFFSET player_name
	call writeString

	mov dl, 47
	mov dh, 13
	call gotoxy
	mov edx, OFFSET prompt12
	call writestring
	mov eax, score
	call writedec

	mov dl, 0
	mov dh, 23
	call gotoxy
	mov edx, OFFSET end_line
	call writestring

	ret
gameOver ENDP

ghostMovement PROC
	cmp level, 1
	je level_1

	cmp level, 2
	je level_2

	cmp level, 3
	je level_3

	jmp normal

	level_1:
		call level1_ghosts
		jmp normal

	level_2:
		call level2_ghosts
		jmp normal

	level_3:
		call level3_ghosts
		jmp normal

	normal:
		ret
ghostMovement ENDP

level1_ghosts PROC
	cmp ghost1_timer, 0
	je move_ghost

	dec ghost1_timer
	jmp to_end
	
	move_ghost:
		mov ghost1_timer, 500
		mov edi ,OFFSET ghost1Pos
		mov esi, OFFSET mazeLayout
		mov ecx, 0
		mov cl, [edi + 1]
		sub cl ,2
		find_index1: add esi, 107
			loop find_index1
		mov ecx, 0
		mov cl, [edi]
		find_index2:
			inc esi
			loop find_index2
			

		call UpdateGhost

			mov bl, [edi]
			cmp bl, 10
			je fixUp_right

			cmp bl, 95
			je fixDown_left

			jmp movement

		fixUp_right:
			mov bl, [edi + 1]
			cmp bl, 6
			je fixRight

			cmp bl, 24
			je fixUp

			jmp movement

		fixDown_left:
			mov bl, [edi + 1]
			cmp bl, 6
			je fixDown

			cmp bl, 24
			je fixLeft

			jmp movement

		fixUp: mov ghost1_movement, 1
			jmp movement

		fixDown: mov ghost1_movement, 2
			jmp movement

		fixRight: mov ghost1_movement, 3
			jmp movement

		fixLeft: mov ghost1_movement, 4
			jmp movement

		movement:

		cmp ghost1_movement, 1
		je move_up

		cmp ghost1_movement, 2
		je move_down

		cmp ghost1_movement, 3
		je move_right

		cmp ghost1_movement, 4
		je move_left

		jmp to_end

		move_up:
			mov bl, [edi + 1]
			dec bl
			mov [edi + 1], bl
			mov bl, ' '
			mov [esi], bl
			sub esi, 107
			mov bl, [esi]
			cmp bl, 'X'
			je died_up
			jmp normal_up

			died_up:
				mov is_alive, 0
				dec lives
				call showData

			normal_up:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			
				jmp to_end

		move_down:
			mov bl, [edi + 1]
			inc bl
			mov [edi + 1], bl
			mov bl, ' '
			mov [esi], bl
			add esi, 107
			mov bl, [esi]
			cmp bl, 'X'
			je died_down
			jmp normal_down

			died_down:
				mov is_alive, 0
				dec lives
				call showData

			normal_down:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			
			jmp to_end

		move_right:
			mov bl, [edi]
			inc bl
			mov [edi], bl
			mov bl, ' '
			mov [esi], bl
			add esi, 1
			mov bl, [esi]
			cmp bl, 'X'
			je died_right
			jmp normal_right

			died_right:
				mov is_alive, 0
				dec lives
				call showData

			normal_right:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			
			jmp to_end

		move_left:
			mov bl, [edi]
			dec bl
			mov [edi], bl
			mov bl, ' '
			mov [esi], bl
			sub esi, 1
			mov bl, [esi]
			cmp bl, 'X'
			je died_left
			jmp normal_left

			died_left:
				mov is_alive, 0
				dec lives
				call showData

			normal_left:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			jmp to_end

	to_end:
		ret
level1_ghosts ENDP

level2_ghosts PROC
	cmp ghost1_timer, 0
	je move_ghost

	dec ghost1_timer
	jmp to_end
	
	move_ghost:
		mov ghost1_timer, 200
		mov edi ,OFFSET ghost1Pos
		mov esi, OFFSET mazeLayout
		mov ecx, 0
		mov cl, [edi + 1]
		sub cl ,2
		find_index1: add esi, 107
			loop find_index1
		mov ecx, 0
		mov cl, [edi]
		find_index2:
			inc esi
			loop find_index2
			

		call UpdateGhost

			mov bl, [edi]
			cmp bl, 3
			je fixUp_right

			cmp bl, 104
			je fixDown_left

			jmp movement

		fixUp_right:
			mov bl, [edi + 1]
			cmp bl, 9
			je fixRight

			cmp bl, 21
			je fixUp

			jmp movement

		fixDown_left:
			mov bl, [edi + 1]
			cmp bl, 9
			je fixDown

			cmp bl, 21
			je fixLeft

			jmp movement

		fixUp: mov ghost1_movement, 1
			jmp movement

		fixDown: mov ghost1_movement, 2
			jmp movement

		fixRight: mov ghost1_movement, 3
			jmp movement

		fixLeft: mov ghost1_movement, 4
			jmp movement

		movement:

		cmp ghost1_movement, 1
		je move_up

		cmp ghost1_movement, 2
		je move_down

		cmp ghost1_movement, 3
		je move_right

		cmp ghost1_movement, 4
		je move_left

		jmp to_end

		move_up:
			mov bl, [edi + 1]
			dec bl
			mov [edi + 1], bl
			mov bl, ' '
			mov [esi], bl
			sub esi, 107
			mov bl, [esi]
			cmp bl, 'X'
			je died_up
			jmp normal_up

			died_up:
				mov is_alive, 0
				dec lives
				call showData

			normal_up:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			
				jmp to_end

		move_down:
			mov bl, [edi + 1]
			inc bl
			mov [edi + 1], bl
			mov bl, ' '
			mov [esi], bl
			add esi, 107
			mov bl, [esi]
			cmp bl, 'X'
			je died_down
			jmp normal_down

			died_down:
				mov is_alive, 0
				dec lives
				call showData

			normal_down:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			
			jmp to_end

		move_right:
			mov bl, [edi]
			inc bl
			mov [edi], bl
			mov bl, ' '
			mov [esi], bl
			add esi, 1
			mov bl, [esi]
			cmp bl, 'X'
			je died_right
			jmp normal_right

			died_right:
				mov is_alive, 0
				dec lives
				call showData

			normal_right:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			
			jmp to_end

		move_left:
			mov bl, [edi]
			dec bl
			mov [edi], bl
			mov bl, ' '
			mov [esi], bl
			sub esi, 1
			mov bl, [esi]
			cmp bl, 'X'
			je died_left
			jmp normal_left

			died_left:
				mov is_alive, 0
				dec lives
				call showData

			normal_left:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			jmp to_end

	to_end:
		ret

level2_ghosts ENDP

level3_ghosts PROC
	cmp ghost1_timer, 0
	je move_ghost1

	dec ghost1_timer
	jmp to_ghost2
	
	move_ghost1:
		mov ghost1_timer, 200
		mov edi ,OFFSET ghost1Pos
		mov esi, OFFSET mazeLayout
		mov ecx, 0
		mov cl, [edi + 1]
		sub cl ,2
		find1_index1: add esi, 107
			loop find1_index1
		mov ecx, 0
		mov cl, [edi]
		find1_index2:
			inc esi
			loop find1_index2
			

		call UpdateGhost

			mov bl, [edi + 1]
			cmp bl, 3
			je fixDown1

			cmp bl, 11
			je fixUp1

			jmp movement1

		fixUp1: mov ghost1_movement, 1
			jmp movement1

		fixDown1: mov ghost1_movement, 2
			jmp movement1

		movement1:

		cmp ghost1_movement, 1
		je move_up1

		cmp ghost1_movement, 2
		je move_down1

		jmp to_ghost2

		move_up1:
			mov bl, [edi + 1]
			dec bl
			mov [edi + 1], bl
			mov bl, ' '
			mov [esi], bl
			sub esi, 107
			mov bl, [esi]
			cmp bl, 'X'
			je died_up1
			jmp normal_up1

			died_up1:
				mov is_alive, 0
				dec lives
				call showData

			normal_up1:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			
				jmp to_ghost2

		move_down1:
			mov bl, [edi + 1]
			inc bl
			mov [edi + 1], bl
			mov bl, ' '
			mov [esi], bl
			add esi, 107
			mov bl, [esi]
			cmp bl, 'X'
			je died_down1
			jmp normal_down1

			died_down1:
				mov is_alive, 0
				dec lives
				call showData

			normal_down1:
				mov bl, ghost
				mov [esi], bl
				call Drawghost

	to_ghost2:
		cmp ghost2_timer, 0
		je move_ghost2

		dec ghost2_timer
		jmp to_ghost3
	
	move_ghost2:
		mov ghost2_timer, 200
		mov edi ,OFFSET ghost2Pos
		mov esi, OFFSET mazeLayout
		mov ecx, 0
		mov cl, [edi + 1]
		sub cl ,2
		find2_index1: add esi, 107
			loop find2_index1
		mov ecx, 0
		mov cl, [edi]
		find2_index2:
			inc esi
			loop find2_index2
			

		call UpdateGhost

			mov bl, [edi]
			cmp bl, 41
			je fixRight2

			cmp bl, 105
			je fixLeft2

			jmp movement2

		fixRight2: mov ghost2_movement, 3
			jmp movement2

		fixLeft2: mov ghost2_movement, 4

		movement2:

		cmp ghost2_movement, 3
		je move_right2

		cmp ghost2_movement, 4
		je move_left2

		jmp to_ghost3

		move_right2:
			mov bl, [edi]
			inc bl
			mov [edi], bl
			mov bl, ' '
			mov [esi], bl
			add esi, 1
			mov bl, [esi]
			cmp bl, 'X'
			je died_right2
			jmp normal_right2

			died_right2:
				mov is_alive, 0
				dec lives
				call showData

			normal_right2:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			
			jmp to_ghost3

		move_left2:
			mov bl, [edi]
			dec bl
			mov [edi], bl
			mov bl, ' '
			mov [esi], bl
			sub esi, 1
			mov bl, [esi]
			cmp bl, 'X'
			je died_left
			jmp normal_left

			died_left:
				mov is_alive, 0
				dec lives
				call showData

			normal_left:
				mov bl, ghost
				mov [esi], bl
				call Drawghost


	to_ghost3:
		cmp ghost3_timer, 0
	je move_ghost3

	dec ghost3_timer
	jmp to_end
	
	move_ghost3:
		mov ghost3_timer, 200
		mov edi ,OFFSET ghost3Pos
		mov esi, OFFSET mazeLayout
		mov ecx, 0
		mov cl, [edi + 1]
		sub cl ,2
		find3_index1: add esi, 107
			loop find3_index1
		mov ecx, 0
		mov cl, [edi]
		find3_index2:
			inc esi
			loop find3_index2
			

		call UpdateGhost

			mov bl, [edi]
			cmp bl, 1
			je fixRight3

			cmp bl, 105
			je fixLeft3

			jmp movement3

		fixRight3: mov ghost3_movement, 3
			jmp movement3

		fixLeft3: mov ghost3_movement, 4

		movement3:

		cmp ghost3_movement, 3
		je move_right3

		cmp ghost3_movement, 4
		je move_left3

		jmp to_end

		move_right3:
			mov bl, [edi]
			inc bl
			mov [edi], bl
			mov bl, ' '
			mov [esi], bl
			add esi, 1
			mov bl, [esi]
			cmp bl, 'X'
			je died_right3
			jmp normal_right3

			died_right3:
				mov is_alive, 0
				dec lives
				call showData

			normal_right3:
				mov bl, ghost
				mov [esi], bl
				call Drawghost
			
			jmp to_end

		move_left3:
			mov bl, [edi]
			dec bl
			mov [edi], bl
			mov bl, ' '
			mov [esi], bl
			sub esi, 1
			mov bl, [esi]
			cmp bl, 'X'
			je died_left3
			jmp normal_left3

			died_left3:
				mov is_alive, 0
				dec lives
				call showData

			normal_left3:
				mov bl, ghost
				mov [esi], bl
				call Drawghost

	to_end:
		ret

	
level3_ghosts ENDP

UpdateGhost PROC
    mov dl, [edi]
    mov dh, [edi + 1]
    call Gotoxy
	mov eax, 0
    mov al, ' '
    call WriteChar
    ret
UpdateGhost ENDP

DrawGhost PROC
    mov eax, red + (black*16)
    call SetTextColor
	mov esi, OFFSET mazeLayout

    mov dl, [edi]
    mov dh, [edi + 1]
    call Gotoxy
    mov al, ghost
    call WriteChar
    
    ret
DrawGhost ENDP

showData PROC
	mov eax, white + (black * 16)
	call setTextColor
	mov dl, 7
	mov dh, 0
	call gotoxy
	mov eax, 0
	mov eax, score
	call writedec

	add dl, 15
	call gotoxy
	mov eax, 0
	mov al, level
	call writedec

	add dl, 15
	call gotoxy
	mov eax, 0
	mov al, lives
	call writedec

	ret
showData ENDP

UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
	mov eax, 0
    mov al, ' '
    call WriteChar
    ret
UpdatePlayer ENDP

DrawPlayer PROC
    mov eax,yellow + (black*16)
    call SetTextColor
	mov esi, OFFSET mazeLayout

    cmp is_alive, 1
    je move_normal

	call findIndex
	mov bl, ' '
	mov [esi], bl
	mov bl, 'X'
	mov esi, OFFSET mazeLayout
	mov [esi + 1552], bl

    mov xPos, 54
    mov yPos, 16
    mov is_alive, 1

    move_normal:
        mov dl,xPos
        mov dh,yPos
        call Gotoxy
        mov al, 'X'
        call WriteChar
    
    ret
DrawPlayer ENDP

findINDEX PROC
	mov esi, OFFSET mazeLayout
	mov ecx, 0
	mov cl, yPos
	sub cl ,2
	find_index1: add esi, 107
		loop find_index1
	mov ecx, 0
	mov cl, xPos
	find_index2:
		inc esi
		loop find_index2

	ret
findINDEX ENDP

charInput proc
	mov eax, 0
	call readkey
	mov inputChar, al

	cmp inputChar, 'p'
	je pause__game

	cmp inputChar, 'w'
	je move_UP

	cmp inputChar, 's'
	je move_DOWN

	cmp inputChar, 'a'
	je move_LEFT

	cmp inputChar, 'd'
	je move_RIGHT

	jmp end_function

	move_UP: call UpdatePlayer
		call moveUP
		jmp end_function

	move_DOWN: call UpdatePlayer
		call moveDOWN
		jmp end_function

	move_RIGHT: call UpdatePlayer
		call moveRIGHT
		jmp end_function

	move_LEFT: call UpdatePlayer
		call moveLEFT
		jmp end_function

	pause__game: call pauseMenu
		jmp end_function

	end_game:
		mov bool_gameOver, 1

	end_function:
		call drawPlayer

	ret
charInput ENDP

moveUP PROC
	call findINDEX

	sub esi, 107
	mov bl, [esi]
	cmp bl, '#'
	je to_end
	cmp bl, '.'
	je collect_coin
	cmp bl, '*'
	je eat_fruit
	cmp bl, '@'
	je died

	jmp no_coin

	eat_fruit:
		add score, 15
		call showData
		jmp no_coin

	collect_coin:
		inc score
		call showData

	no_coin:
		mov bl, 'X'
		mov [esi], bl
		mov bl, ' '
		add esi, 107
		mov [esi], bl
		dec yPos
		jmp to_end

	died:
		mov is_alive, 0
		dec lives
		call showData

	to_end:
	
	ret
moveUP ENDP

moveDOWN PROC
	call findINDEX

	add esi, 107
	mov bl, [esi]
	cmp bl, '#'
	je to_end
	cmp bl, '.'
	je collect_coin
	cmp bl, '*'
	je eat_fruit
	cmp bl, '@'
	je died

	jmp no_coin

	eat_fruit:
		add score, 15
		call showData
		jmp no_coin

	collect_coin:
		inc score
		call showData

	no_coin:
		mov bl, 'X'
		mov [esi], bl
		mov bl, ' '
		sub esi, 107
		mov [esi], bl
		inc yPos
		jmp to_end

	died:
		mov is_alive, 0
		dec lives
		call showData

	to_end:
	
	ret
moveDOWN ENDP

moveRIGHT PROC
	call findINDEX

	add esi, 1
	mov bl, [esi]
	cmp bl, '#'
	je to_end
	cmp bl, '.'
	je collect_coin
	cmp bl, '*'
	je eat_fruit
	cmp bl, '@'
	je died

	jmp no_coin

	eat_fruit:
		add score, 15
		call showData
		jmp no_coin

	collect_coin:
		inc score
		call showData

	no_coin:
		mov bl, 'X'
		mov [esi], bl
		mov bl, ' '
		dec esi
		mov [esi], bl
		inc xPos
		jmp to_end

	died:
		mov is_alive, 0
		dec lives
		call showData

	to_end:
		
	ret
moveRIGHT ENDP

moveLEFT PROC
	call findINDEX

	sub esi, 1
	mov bl, [esi]
	cmp bl, '#'
	je to_end
	cmp bl, '.'
	je collect_coin
	cmp bl, '*'
	je eat_fruit
	cmp bl, '@'
	je died

	jmp no_coin

	eat_fruit:
		add score, 15
		call showData
		jmp no_coin

	collect_coin:
		inc score
		call showData

	no_coin:
		mov bl, 'X'
		mov [esi], bl
		mov bl, ' '
		add esi, 1
		mov [esi], bl
		dec xPos
		jmp to_end

	died:
		mov is_alive, 0
		dec lives
		call showData

	to_end:
		
	ret
moveLEFT ENDP

InitializeGame PROC
	mov xPos, 54
	mov yPos, 16

	cmp level, 3
	je level3

	cmp level, 2
	je level2

	cmp level, 1
	je level1

	level3:
		mov esi, OFFSET layout3
		mov edi, OFFSET ghost1Pos
		mov bl, 9
		mov [edi], bl
		mov bl, 3
		mov [edi + 1], bl
		mov edi, OFFSET ghost2Pos
		mov bl, 41
		mov [edi], bl
		mov bl, 8
		mov [edi + 1], bl
		mov edi, OFFSET ghost3Pos
		mov bl, 1
		mov [edi], bl
		mov bl, 17
		mov [edi + 1], bl
		jmp end_function

	level2:
		mov esi, OFFSET layout2
		mov edi, OFFSET ghost1Pos
		mov bl, 3
		mov [edi], bl
		mov bl, 9
		mov [edi + 1], bl
		jmp end_function

	level1:
		mov score, 0
		mov lives, 3
		mov esi, OFFSET layout1
		mov edi, OFFSET ghost1Pos
		mov bl, 10
		mov [edi], bl
		mov bl, 6
		mov [edi + 1], bl

	end_function:
		call SaveMazeLayout
		call drawMaze

	ret
InitializeGame ENDP

drawMaze PROC
	call clrscr

	mov eax, white + (black * 16)
	call setTextColor
	mov dl, 0
	mov dh, 0
	call gotoxy
	mov edx, OFFSET prompt1
	call writestring
	
	mov dl, 15
	mov dh, 0
	call gotoxy
	mov edx, OFFSET prompt2
	call writestring
	
	mov dl, 30
	mov dh, 0
	call gotoxy
	mov edx, OFFSET prompt3
	call writestring

	mov eax, blue + (black * 16)
	call setTextColor
	mov esi, OFFSET mazeLayout
	mov bl, mazeheight
	mov ecx, 0
	mov cl, mazeHeight
	mov dl, 0
	mov dh, 2
	call gotoxy

	draw_maze:
		mov bl, cl
		mov cl, mazeWidth
		draw_row:
			mov eax, 0
			mov al, [esi]

			cmp al, '.'
			je draw_coin
			cmp al, 'X'
			je draw_player
			cmp al, '@'
			je draw_ghost
			cmp al, '*'
			je draw_fruit

			mov eax, blue + (black * 16)
			call setTextColor
			jmp end_drawRow

			draw_coin:
				mov eax, white + (black * 16)
				call setTextColor
				jmp end_drawRow

			draw_ghost:
				mov eax, red + (black * 16)
				call setTextColor
				jmp end_drawRow

			draw_fruit:
				mov eax, green + (black * 16)
				call setTextColor
				jmp end_drawRow

			draw_player:
				mov eax, yellow + (black * 16)
				call setTextColor

			end_drawRow:
				mov eax, 0
				mov al, [esi]
				call writeChar
				inc esi

			loop draw_row

		mov dl ,0
		inc dh
		call gotoxy
		mov cl, bl
		loop draw_maze

		call showData
	ret
drawMaze ENDP

SaveMazeLayout PROC
	mov edi, OFFSET mazeLayout
	mov ecx, 0
	mov cl, mazeHeight
	L1:
		mov bl, cl
		mov cl, mazewidth
		L2:
			mov al, [esi]
			mov [edi], al
			inc esi
			inc edi
			
			loop L2

		mov cl, bl
		loop L1
		
	ret
SaveMazeLayout ENDP

END main