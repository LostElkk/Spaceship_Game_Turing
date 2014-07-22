/*
					The Space Ship Game
 
 
 Definition:
 In this program, a user will be able to enjoy a simple spaceship game (instructions are provided in the game)

 PROBLEM:
 The main problem were the collisions of the moving objects in the game, (For example, a space ship colliding with a star)

 Checklist, The program will do the following:
 -Provide instructions for the user before the game
 -Move a Space ship around using the keys "w, a, s, d"
 -Shoot a fire ball with the space key (only when its recharged)
 -Loop the game, meaning that the game will keep on playing, even when the spaceship dies
 -Have a GAMEOVER screen when the spaceship collides with a "BAD" object
 -Have collisions with space ship from objects such as stars, and astroids
 -Have fire ball collision with star, (fireball destroys the star)
 -Have a score shown at the top left of the screen, when collision happens with the space ship and a "bad" object

 PROBLEM ANALYSIS
 Inputs and Outputs:
 -From user; (ALL TO SPACESHIP) W-Move Up, D-Move Right, S-Move Down, A-Move Left, Space-Shoot Fireball
 -From Files; pictures include spaceship picture, fire ball picture, boost picture, background picture, and astroid picture
 -All Pictures are taken from the internet, and edited to work

 SCREENS
 Instruction Screen
 -At the start of the program, opens with click on the GUI button
 -Black Background
 -Written instructions and rules to play the game
 -loops it back to the main sober screen (the black one)

 Game Over Screen (when the ship collides with a "bad" object)
 -Starts when ship collides
 -Blue background
 -Many text that show the score of the game, and when the new game is going to start
 -Also has a drawn text that says "Game Over"

 Program Breakdown
 -User should start from the title screen, then go to either instructions or to play the game
 -Once user plays the game, and dies (ends the game), it loops it back so it plays again
 -Meanwhile, everytime the space ship collides, the Game Over Screen Should appear, which tells the score
 */



%--------------------------------START OF THE PROGRAM---------------------------------%



%--------Needed variables/command for GUI buttons ----------------%
import GUI %needed for graphical user interface buttons used later
var Option1 : int % The option1 on the title page, which is PLAY the game
var Option2 : int % The option1 on the title page, which is Instructions

%------------Procedure for playing the game---------------%
procedure PlayGame % a procedure to play the game so i can use GUI buttons
    loop %loops the game so it keeps on happening once user clicks play game
	View.Set ("graphics")
	setscreen ("graphics:900;300") %Sets the screen to a specific dimensions

	%------------All The Pictures variable-------------------%
	%-----------PICTURE 1: The Spaceship Picture-------------%
	var picID : int % the first picture, variable
	picID := Pic.FileNew ("spaceship1.bmp") % loads the picture from a saved locatoin
	var spaceshipx, spaceshipy, spaceshipWidth, spaceshipHeight : int % all the varibales for my spaceship, ex spaceshipx  which is spaceship's x-axis
	    spaceshipx := 100 % spaceshipx is x-axis
	    spaceshipy := 125 % spaceshipy is Y-axis
	    spaceshipWidth := 70 % spaceshipWidth is the width (horizontally)
	    spaceshipHeight := 70 % spaceshipx is height (vertically)
	picID := Pic.Scale (picID, spaceshipWidth, spaceshipHeight) % scales the picture, with the width and the height from the variables
	var pic1 : int := Pic.Rotate (picID, 0, 100, 100) % not nessecary, but i wanted this so if the picture was rotated, i could flip it

	%----------PICTURE 2: The Boost Picture-----------------%
	var picID1 : int %The boost picture
	picID1 := Pic.FileNew ("boost3.bmp") % loads the picture from my saved location
	var boostx, boosty, width, height : int %all variables for the boost, boosty is the Y-axis
	    boostx := 60
	    boosty := 150
	picID1 := Pic.Scale (picID1, 60, 20) % Scales it so it is the specific dimensions
	var pic2 : int := Pic.Rotate (picID1, 0, 100, 100) %if picture is flipped, i would rotate it

	%------PICTURE 3: The Bullet (Fire Ball) Picture---------%
	var picID2 : int % the fireball picture (called bullet)
	var bulletx, bullety, bulletHeight, bulletWidth : int %all the varibales, ex bulletHeight is the height of the bullet from bulletX
	    bulletx := -1000 %at the start, i want it to be away from the screen, so i do not see it
	    bullety := -1000 %at the start, i want it to be away from the screen, so i do not see it
	    bulletHeight := 40
	    bulletWidth := 80
	picID2 := Pic.FileNew ("bullet1.bmp") %loads the picture bullet1 from my saved location
	picID2 := Pic.Scale (picID2, bulletWidth, bulletHeight) %scales the picture to perfect dimensions
	var pic3 : int := Pic.Rotate (picID2, 0, 100, 100)

	%------PICTURE 4: The Background Space Picture----------%
	var picID3 : int % the background picture, (the space one)
	picID3 := Pic.FileNew ("backgroundspace1.bmp") %loads the picture, from a saved location
	var backgroundx, backgroundy : int
	    backgroundx := 0 % i want the picture to start from the bottom left of the screen
	    backgroundy := 0 % i want the picture to start from the bottom left of the screen
	picID3 := Pic.Scale (picID3, 900, 300) %scales the picture, and gives it the perfect dimensions to fit the screen
	var pic4 : int := Pic.Rotate (picID3, 0, 100, 100)

	%----------PICTURE 5: The Astroid Picture --------------%
	var picID4 : int %The big astroid picture, (big rock kind of thing that destroys the spaceship)
	picID4 := Pic.FileNew ("bigrock.bmp") %loads the picture from a saved location
	var astroidx, astroidy, astroidWidth, astroidHeight : int
	    astroidx := Rand.Int (1000, 1200) % i want it to be random on the screen from 1000, to 1200 so it has diffrent timings each time user plays the game
	    astroidy := Rand.Int (0, 200) % Makes the astroid on random location, each time user plays the game, from the top of screen to the bottom
	    astroidWidth := 100
	    astroidHeight := 100
	picID4 := Pic.Scale (picID4, astroidWidth, astroidHeight) %scales the picture and gives it perfect dimensions


	%------------------- Other Variables -------------------%
	var chars : array char of boolean % a code that allows the user to use keys from the key board
	var score : int
	    score := 0         % a variable for the score, starts from ZERO
	var DistanceBulletFromShip : int %this varibale is nessesary for the bullet and the ship; allows the bullet to be shot
	    DistanceBulletFromShip := 0 %THIS IS VERY IMPORTANT; right now the distance is ZERO meaning the bullet is ready to be fired


	%--------------ALL MY STARS---------------------%
	%starx is random from 950 to 1300 so it comes at random timings
	%stary is random interger from 50, to 290 so it comes on diffrent planes of the y-Axis of the screen (from bottom to top)
	%starh is the height, and is needed for the collisions
	%starw is the width and is needed for the collision
	%this is done for 5 diffrent stars
	var starx : int
	    starx := Rand.Int (950, 1300)
	var stary : int
	    stary := Rand.Int (50, 290)
	var starh : int
	    starh := 20
	var starw : int
	    starw := 20

	var starx1 : int
	    starx1 := Rand.Int (950, 1300)
	var stary1 : int
	    stary1 := Rand.Int (20, 290)
	var starh1 : int
	    starh1 := 20
	var starw1 : int
	    starw1 := 20

	var starx2 : int
	    starx2 := Rand.Int (950, 1300)
	var stary2 : int
	    stary2 := Rand.Int (20, 290)
	var starh2 : int
	    starh2 := 20
	var starw2 : int
	    starw2 := 20

	var starx3 : int
	    starx3 := Rand.Int (950, 1300)
	var stary3 : int
	    stary3 := Rand.Int (20, 290)
	var starh3 : int
	    starh3 := 20
	var starw3 : int
	    starw3 := 20

	var starx4 : int
	    starx4 := Rand.Int (950, 1300)
	var stary4 : int
	    stary4 := Rand.Int (20, 290)
	var starh4 : int
	    starh4 := 20
	var starw4 : int
	    starw4 := 20


	%---------------ALL MY DIFFRENT SPEEDS---------%
	%Each one is for each diffrent star
	%speed is how fast they come from the right of the screen, to the left at random speeds from 7 to 16 intergers
	var speed : int %For star 0
	    speed := Rand.Int (7, 16)
	var speed1 : int %For star 1
	    speed1 := Rand.Int (7, 16)
	var speed2 : int%For star 2
	    speed2 := Rand.Int (7, 16)
	var speed3 : int%For star 3
	    speed3 := Rand.Int (7, 16)
	var speed4 : int%For star 4
	    speed4 := Rand.Int (7, 16)
	    
	var ExitTheLoop : string %A Command needed for exiting the game when collision has happend between a "BAD OBJECT" and spaceship
	ExitTheLoop := "NO" %Right now the variable is "NO" meaning do not exit loop


	%-------- The Real Coding For The Game -------%
	View.Set ("offscreenonly") % off sets the screen, so there is no flickering
	loop % loops the game, helps every thing move around, instead of everything just move once

	    Pic.Draw (pic4, backgroundx, backgroundy, picXor) % the space background is drawn, picXOR is needed since it is a background

	    Pic.Draw (picID4, astroidx, astroidy, picMerge) %Draws the big astroid thing, picmerge so it is cutout like a sprite
	    astroidx := astroidx - 2 %astroid moves at a speed of -2, coming from right to ,left of the screen
	    if astroidx < -200 then % loops the astroid so if it goes off screen, it comes back
		astroidx := Rand.Int (1000, 1100) %if it goes offsreen (to the left), it moves it right 1000-1100 interger to the right
		astroidy := Rand.Int (0, 200) %Also, makes it random on the Y-Axis too,
	    end if

	    %-------makes the star go from the right screen to the left-------%
	    %Each star is minused by each diffrent speed attached to them, makes them go at random speeds
	    starx := starx - speed 
	    starx1 := starx1 - speed1
	    starx2 := starx2 - speed2
	    starx3 := starx3 - speed3
	    starx4 := starx4 - speed4


	    %---------------Codes that allow keys to be pressed from the keyboard-----------------%
	    Input.KeyDown (chars) %This code allows user to input from keyboard,  
	    if chars ('d') and spaceshipx < 830 then %if the user presses the d letter from the keyboard and the spaceship is less than 830 (meaning the spaceship is in the screen, not off right of the screen) then 
		spaceshipx := spaceshipx + 12 %then x-value is increased making the spaceship go right
	    end if

	    if chars ('d') and spaceshipx < 830 and not chars ('w') and not chars ('s') and not chars ('a') then %helps with the boost...so we see bost when pressing d but not when pressing other keys with d .
		boostx := spaceshipx - 20
		    boosty := spaceshipy + 25
		Pic.Draw (pic2, boostx, boosty, picMerge)
	    end if

	    if chars ('a') and spaceshipx > 10 then %If user presses letter a (to make ship move left) and spaceship is in the screen (not off the screen to the left) then
		spaceshipx := spaceshipx - 12 %X-value for spaceship is decreased causing the spaceship to move left
	    end if
	    if chars ('w') and spaceshipy < 230 then %If user presses letter w(to make ship move up) and space ship is in the screen (not off to the top off the screen) then
		spaceshipy := spaceshipy + 12 %Y-value for spaceship is increased so it moved up
		boosty := boosty + 12 %boost pictures y-value also goes up by the same amount (so when the user presses only d, the boost is in the correct position)
	    end if

	    if chars ('s') and spaceshipy > 10 then %if user presses the letter s (to make the ship go down) and the spaceship is in the screen (not off to the bottom of the screen) then
		spaceshipy := spaceshipy - 12 %Y-value for space ship is subtracted causing the space ship to go down
		boosty := boosty - 12 %Also, the boost picture's y-value is also subtracted by the same amount so the boost picture is in the correct position when the user ONLY presses d
	    end if


	    %--------------Bullet Fireing ---------------------------%
	    % DistanceBulletFromShip := 5000 means that the bullet is not ready to fire (or its alredy been fired)
	    % DistanceBulletFromShip := 0  means that the bullet is ready to fire (and did not fire)
	    
	    if chars (' ') and not DistanceBulletFromShip = 5000 then %if user presses the key " " (SPACE) and the distance of bullet from ship is 0 (meaning its ready to be fired) then
		bulletx := spaceshipx %makes the bullet on the same X-axis just as the ship's X-axis
		    bullety := spaceshipy + 10 %makes the bullet on the same Y-axis just as the ships Y-axis, and its + 10 because I wanted the bullet to be fired from the middle of the ship rather than the corner of the ship
		DistanceBulletFromShip := 5000 %This tells that the bullet has been fired
	    end if
	    if DistanceBulletFromShip = 5000 then %if the bullet has been fired then
		 bulletx := bulletx + 10 %bullet's x-value is increased causing the bullet to go right
		Pic.Draw (pic3, bulletx, bullety, picMerge) %Draws the bullet, so it looks like its moving
	    end if
	    if bulletx > 1000 then %if the bullet goes out of the screen then
		DistanceBulletFromShip := 0 %Bullet has been recharged
	    end if
	    %------------End Of Bullet Coding ----------------------%
	    
	    
	    %-------Looping the Stars so it keeps on coming from the right of the screen---------%
	    %Basically, the IF STATEMENT  means that if the right side of the star is less than 1 (meaning its off the screen to the left) then
	    % 1. Starts the star off the screen to the right randomly between the intergers 950 and 1110 (so it comes on a random distance)
	    % 2. Makes the star's y-value a random value making it appear from random places of the screen (if your looking at it vertically)
	    % 3. Also increases the speed as it adds the previous speed, to a random interger between 0 to 3, increasing the speed as you miss the stars (making the game harder)
	    % 4. Increases the score, becasue the user survived another star
	    if starx + starw < 1 then 
	       starx := Rand.Int (950, 1110)  % 1
		    stary := Rand.Int (10, 290)  % 2
		    speed := Rand.Int (0, 3) + speed % 3
		score := score + 1 % 4
	    end if

	    if starx1 + starw1 < 1 then
		starx1 := Rand.Int (950, 1110)% 1
		    stary1 := Rand.Int (10, 290)% 2
		    speed1 := Rand.Int (0, 3) + speed1% 3
		score := score + 1% 4
	    end if

	    if starx2 + starw2 < 1 then
		starx2 := Rand.Int (950, 1110)% 1
		    stary2 := Rand.Int (10, 290)% 2
		    speed2 := Rand.Int (0, 3) + speed2 % 3
		score := score + 1 % 4
	    end if

	    if starx3 + starw3 < 1 then
		starx3 := Rand.Int (950, 1110)% 1
		    stary3 := Rand.Int (10, 290)% 2
		    speed3 := Rand.Int (0, 3) + speed3 % 3
		score := score + 1 % 4
	    end if

	    if starx4 + starw4 < 1 then
		starx4 := Rand.Int (950, 1110) % 1
		    stary4 := Rand.Int (10, 290) % 2
		    speed4 := Rand.Int (0, 3) + speed4 % 3
		score := score + 1 % 4
	    end if
	    %--------------------- End of Looping the stars ---------------------------%
	  
	    
	    
	    %--------------------------- COLLISIONS -----------------------------------%
	    
	     %----------------Collisions With Spaceship And Stars----------------------%
	     %This was no doubtly the most hardest part of building this game
	     %involves a lot of math
	     %if star's x-value is greater than spaceship's x-value (meaning the ship is right of star) and starx + star's width is less than spaceshipx + spaceship's width (meaning its in the middle , not off to right)
	     %Same thing with y-values of the spaceship, except i use height instead of width and y-values instead of x-values
	     %Happens with every star so every star can collide with spaceship
	     %if the collision happens, then the varibale ExitTheLoop is "YES" which means exit the loop, which happens later on
	    if starx + starw > spaceshipx and starx + starw < spaceshipx + spaceshipWidth and stary + starh > spaceshipy and stary - starh + 20 < spaceshipy + spaceshipHeight then 
		ExitTheLoop := "YES"
	    end if

	    if starx1 + starw1 > spaceshipx and starx1 + starw1 < spaceshipx + spaceshipWidth and stary1 + starh1 > spaceshipy and stary1 - starh1 + 20 < spaceshipy + spaceshipHeight then
		ExitTheLoop := "YES"
	    end if

	    if starx2 + starw2 > spaceshipx and starx2 + starw2 < spaceshipx + spaceshipWidth and stary2 + starh2 > spaceshipy and stary2 - starh2 + 20 < spaceshipy + spaceshipHeight then
		ExitTheLoop := "YES"
	    end if

	    if starx3 + starw3 > spaceshipx and starx3 + starw3 < spaceshipx + spaceshipWidth and stary3 + starh3 > spaceshipy and stary3 - starh3 + 20 < spaceshipy + spaceshipHeight then
		ExitTheLoop := "YES"
	    end if

	    if starx4 + starw4 > spaceshipx and starx4 + starw4 < spaceshipx + spaceshipWidth and stary4 + starh4 > spaceshipy and stary4 - starh4 + 20 < spaceshipy + spaceshipHeight then
		ExitTheLoop := "YES"
	    end if



	    %-------------------------------- Bullet Collision --------------------------------------%
	    %Same collision as the star and spaceship except this one is when the bullet hits the star
	    %Almost the same thing, except the diffrent variables
	    %if the collision happens, then star's x-value is increased causing the star to go off the screen to the right
	    %Also, star's y-value is increased by a random interger, so the star comes from random places of the screen (If you look at it from a vertical perspective)
	    %Score is increased, as the user killed a star and has earned a point
	    
	    if starx + starw > bulletx and starx + starw < bulletx + bulletWidth and stary + starh > bullety and stary - starh + 20 < bullety + bulletHeight then 
		% plus 20 so it has a bit of less gap when colliding
		starx := Rand.Int (950, 1110)
		    stary := Rand.Int (10, 290)
		    speed := Rand.Int (0, 3) + speed
		score := score + 1
	    end if

	    if starx1 + starw1 > bulletx and starx1 + starw1 < bulletx + bulletWidth and stary1 + starh1 > bullety and stary1 - starh1 + 20 < bullety + bulletHeight then 
		% plus 20 so it has a bit of less gap when colliding
		starx1 := Rand.Int (950, 1110)
		    stary1 := Rand.Int (10, 290)
		    speed1 := Rand.Int (0, 3) + speed1
		score := score + 1
	    end if

	    if starx2 + starw2 > bulletx and starx2 + starw2 < bulletx + bulletWidth and stary2 + starh2 > bullety and stary2 - starh2 + 20 < bullety + bulletHeight then 
		% plus 20 so it has a bit of less gap when colliding
		starx2 := Rand.Int (950, 1110)
		    stary2 := Rand.Int (10, 290)
		    speed2 := Rand.Int (0, 3) + speed2
		score := score + 1
	    end if

	    if starx3 + starw3 > bulletx and starx3 + starw3 < bulletx + bulletWidth and stary3 + starh3 > bullety and stary3 - starh3 + 20 < bullety + bulletHeight then 
		% plus 20 so it has a bit of less gap when colliding
		starx3 := Rand.Int (950, 1110)
		    stary3 := Rand.Int (10, 290)
		    speed3 := Rand.Int (0, 3) + speed3
		score := score + 1
	    end if

	    if starx4 + starw4 > bulletx and starx4 + starw4 < bulletx + bulletWidth and stary4 + starh4 > bullety and stary4 - starh4 + 20 < bullety + bulletHeight then 
		% plus 20 so it has a bit of less gap when colliding
		starx4 := Rand.Int (950, 1110)
		    stary4 := Rand.Int (10, 290)
		    speed4 := Rand.Int (0, 3) + speed4
		score := score + 1
	    end if
	    
	    
	    %------------- Astroid Collision With Spaceship -----------------%
	    %Same skill used, just as in the previous ones
	    %if the collision happens, then the user has died, thus the game must end
	    %To end the game, the x-value for the picture astroid, must go 10000, so we can create an "exit loop" commandd at the end  saying that if the x-value for astroid is more than 9000 then end the loop
	    if spaceshipy + spaceshipHeight > astroidy and spaceshipy < astroidy + astroidHeight and spaceshipx + spaceshipWidth > astroidx and spaceshipx < astroidx + astroidWidth then
		ExitTheLoop := "YES"
	    end if

	    %---------------------- My Pictures And Shapes ----------------------------%
	    Pic.Draw (pic1, spaceshipx, spaceshipy, picMerge) % The picture for the spaceship, draws it after the key is pressed, so it moves,
	    Draw.FillStar (starx, stary, starx + starw, stary + starh, white) %Draws star 0  with related widths, heights, x-values, and y-values
	    Draw.FillStar (starx1, stary1, starx1 + starw1, stary1 + starh1, white)%Draws star 1 with related widths, heights, x-values, and y-values
	    Draw.FillStar (starx2, stary2, starx2 + starw2, stary2 + starh2, white)%Draws star 2 with related widths, heights, x-values, and y-values
	    Draw.FillStar (starx3, stary3, starx3 + starw3, stary3 + starh3, white)%Draws star 3 with related widths, heights, x-values, and y-values
	    Draw.FillStar (starx4, stary4, starx4 + starw4, stary4 + starh4, white)%Draws star 4 with related widths, heights, x-values, and y-values


	    
	    %--------------------------- Needed Codes ----------------------------------%
	    View.Update %Updates the screen, eliminating flicker, thus moving the game more smoothly
	    delay (50) %Needed because it delays the game by 50 mili-seconds so our eyes can see the game happening
	    cls %Clears the screen, so all the drawn stuff is cleared, and makes room for new drawn stuff
	    
	    %-------------------------- The Exit Loop Command ---------------------------%
	exit when ExitTheLoop = "YES" %when collision happens between all these "BAD OBJECTS" the varibale ExitTheLoop is "YES" , which now is in a exit loop command which means the loop ends if this variable is "YES" (meaning collision has happend)
     end loop
     
     
     %-------------------------- THE "GAME OVER" SCREEN --------------------------%
     %This screen has 2 purposes, 1. To show to the user that they have died, and the game is over, and 2. to show the user their score

     View.Set ("nooffscreenonly") %Helps set the screen, so written text can be seen on the screen
     setscreen ("graphics:900;300")

     cls %Clears the screen, so the shapes and the pictures from the game are deleted, and the screen is a fresh white screen
     Text.ColorBack (brightblue) %Very important, because the background is going to be blue, and their is going to be text in the screen, so the background color behind the text should be the same as the background which is blue
     Draw.FillBox (0, 0, maxx, maxy, brightblue) %Makes the background blue, gives it a cool and an old school game look

     var fontID1 : int %Makes an interger called fontID1
	fontID1 := Font.New ("Arial:60:bold") % Makes this font arial 60 and bold
	
     Font.Draw ("GAME OVER", 215, 130, fontID1, 12) %Draws this big font, saying GAMEOVER, so the user knows the game has ended  
     locate (3, 3) % Locates the put command to the top left, so it looks cool
     put "Your Score Is ", score % puts these words and after thaat score, so the user sees his score
     
     locate (18, 81) %locates the put command, in the bottom right corner of the screen
     put "Game will begin in 6 seconds"  %Tells the user that the game will start again in 6 seconds so the user waits 

	delay (6000) % delays 6000 meaning 6 seconds
    end loop
end PlayGame %End the procedure PlayGame

%--------------------------------  The Instruction Screen  ----------------------------------------------------%

procedure Instructions %The new procedure, called the instuctions (because its instructions)
    cls %Clears the screen so all drawn objects are deleted each time
    Draw.FillBox (0, 0, maxx, maxy, black) %Makes the background Black, for 2 reasons.  1. to make the background look cool. 2. To match the background of the title screen to this instrucitons screen
    
    %------------ The Instructions for the Keyboard Inputs ---------------%
    var fontID3 : int %Makes an interger called fontID3
    fontID3 := Font.New ("Arial:20") % Makes that fontID3 a Arial and 20 , so it is smaller size than my title
    
    %------------- Keyboard Input Instructions------------%
    %The Drawn fonts below are same size, so the  user can easily see and pick up the words from the background together
    %There also all the same color, a grey color
    Font.Draw ("W = Move UP", 0, 180, fontID3, 15) 
    Font.Draw ("A = Move LEFT", 0, 140, fontID3, 15)
    Font.Draw ("S = Move DOWN", 0, 100, fontID3, 15)
    Font.Draw ("D = Move RIGHT", 0, 60, fontID3, 15)
    Font.Draw ("SPACE = Shoot Fire Ball", 0, 20, fontID3, 15)
    
    %------------- The Main Instruction ---------------%
    var fontID4 : int %Makes an interger called fontID4
    fontID4 := Font.New ("Arial:25:bold") %This font is now 25 arial and bold so it is the first words the user sees
    Font.Draw ("Dodge AND kill Objects AND SURVIVE", 30, 350, fontID4, brightred) %Writes this breif but complete description of the game
    
    
    var fontID5 : int %Makes an interger called fontID5
    fontID5 := Font.New ("Arial:15:bold") 
    Font.Draw ("BAD THINGS", 410, 280, fontID5, brightblue) %This one is the sub headings for the pictures

    %-------------- The "Bad Objects" Pictures -----------%
    %Have to set all the variables again because the vaiables for this picture were in the procedure before, so they won't do anything here
    var picID4 : int 
    var astroidx, astroidy, astroidWidth, astroidHeight : int %All my variables for the astroid picture,
	astroidx := 430
	astroidy := 150
	astroidWidth := 100
	astroidHeight := 100
    picID4 := Pic.FileNew ("bigrock.bmp") %loads the picture from a saved location, so it can be seen
    picID4 := Pic.Scale (picID4, astroidWidth, astroidHeight) %Scales the pictures, so the picture has the correct dimensions
    Pic.Draw (picID4, astroidx, astroidy, picMerge) %Draws the picture, with PicMerge so it blends in with the background

    
    Draw.FillStar (460, 80, 490, 110, white) %The other bad object is the star, the white star, so it draws it

    delay (6000) %Delays the instructions screen for 6 seconds
    Draw.FillBox (0, 0, maxx, maxy, black) %Makes the background black again, so it has a good transition to the title screen

    Option1 := GUI.CreateButtonFull (250, 210, 210, "Play the Game", PlayGame, 55, '^D', true) %Makes these GUI option box again, so the user can press and thus he is in a loop
    Option2 := GUI.CreateButtonFull (250, 130, 210, "Instructions", Instructions, 55, '^D', true)%Makes these GUI option box again, so the user can press and thus he is in a loop
end Instructions %End of the procedure for instrucitons


%----------------- The First Screen: The Title Screen ------------------------%
procedure TitleScreen %New procedure that will be the first screen that the user sees, (because the procedure was the last procedure made)
    Draw.FillBox (0, 0, maxx, maxy, black) %Makes the background  black, so it looks cool, (and so it has a good, game title screen look)
	       
		 %---------------- The Two GUI Options --------------------%
    Option1 := GUI.CreateButtonFull (250, 210, 210, "Play the Game", PlayGame, 55, '^D', true)  %Creates this GUI button, in the middle of the screem, with the procedure Play the game (which would mean to play the game)
    Option2 := GUI.CreateButtonFull (250, 130, 210, "Instructions", Instructions, 55, '^D', true) %Creates a GUI  button, in the middle of the screen, with the procedure to go to the instruction screen 
end TitleScreen
 

TitleScreen % The title screen procedure, is shown first because it is the title screen. 

loop
    exit when GUI.ProcessEvent
end loop



%------------------------------------------- END OF THE PROGRAM --------------------------------------------------%

