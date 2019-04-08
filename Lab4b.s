/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global convert
.extern cr
.extern iprintf
.extern getchr
.extern TurnOnLed
.extern TurnOffLed
.extern Row
.extern Column
.extern Delay
/*----------------------------------------------------------------*/

/******************************************************************/
/* General Information ********************************************/
/* File Name: Lab4b.s **************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/
convert:
/*Write your program here******************************************/

MOVE.L %d0, -(%sp) /* preserve data register */

MOVE.L 8(%sp), %d0 /* pull ascii value from stack
MOVE.L %d0, -(%sp) /* push ascii value to top of stack

JSR convert1 /* get the pattern address */
MOVE.L (%sp)+, %d0 /* move the returned pattern address to d0 and clean the stack */

MOVE.L %d0, 8(%sp) /* move the pattern address to the stack */

MOVE.L (%sp)+, %d0 /* restore the stack to the register, and clear the stack */


rts 
/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/


/*End of Strings **************************************************/
