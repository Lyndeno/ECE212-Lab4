/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global WelcomePrompt
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
/* File Name: Lab4a.s **************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/

/*=================================*/
    /* The welcome prompt subroutine is responsible for getting the input character from the user and making sure */
    /* it is valid. The subroutine then places the ascii value onto the stack in the space allocated.  */

WelcomePrompt:
/*Write your program here******************************************/
MOVE.L %d0, -(%sp) /* preserve the registers */

PEA WelcomeString /* Display the welcome string */
JSR iprintf
ADDA.L #4, %SP
getInput:
    JSR getchr /* get character and store it in D0 */

testNum:
    CMPI.L #0x30, %d0
    BLT Error /* if less than zero then error out */
    CMPI.L #0x39, %d0
    BLE Exit /* if less than or equal to 9 exit, we are good, otherwise test for letters

testChar:
    CMPI.L #0x41, %d0
    BLT Error /* if less than A error */
    CMPI.L #0x5A, %d0
    BLE Exit /* if less than or equal to Z than exit */
    BRA Error /* error out if invalid */

Error:
    PEA ErrorString /* Display the welcome string */
    JSR iprintf
    ADDA.L #4, %SP 
    BRA getInput

Exit:
    MOVE.L %d0 4(%sp)
    MOVE.L (%sp)+, %d0

rts 
/*End of Subroutine **************************************************/ 
.data
WelcomeString:
.string "Welcome to the LED character display! Please enter a valid Capital letter or number: "
ErrorString:
.string "Oof, that character was not valid, please try again: "
/*All Strings placed here **************************************************/


/*End of Strings **************************************************/
/******************************************************/
