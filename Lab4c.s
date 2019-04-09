/* DO NOT MODIFY THIS --------------------------------------------*/
.text
.global LedSub
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
/* File Name: Lab4c.s **************************************/
/* Names of Students: _________________ and ____________________ **/
/* Date: _________________                                       **/
/* General Description:                                          **/
/*                                                               **/
/******************************************************************/
LedSub:
/*Write your program here******************************************/

/* Preserve registers */
SUBA.L #16, %SP
MOVEM.L %d2-%d4/%a2, (%SP)


/* retrieve the pattern address */
MOVE.L 20(%SP), %d2
MOVE.L %d2, (%a2)



/*** Initalize the Coords ***/

CLR.L %d2  
/* column value */
CLR.L %d3       /* Row value    */
MOVE.B #7, %d4       /* bit number   */

/************* Initialize the LED display *****************/

MOVE.L %d2, -(%SP)
jsr Column
ADDA.L #4, %SP

MOVE.L %d3, -(%SP)
jsr Row
ADDA.L #4, %SP

jsr TurnOffLed

/**********************************************************/


/* for iteration through rows */
loop_row:

    /* for iteration through column */
    loop_column:
        BTST.B %d4, (%a2) /* test the bit of the pattern */
        BEQ not_lit /* if bit is not set do nothing */
    lit:
        /* push column to stack */
        MOVE.L %d2, -(%SP)
        jsr Column
        /* move row to address pointed by stack pointer */
        MOVE.L %d3, (%SP)
        jsr Row
        /* clean up stack */
        ADDA.L #4, %SP

        /* turn the led on */
        jsr TurnOnLed

        /* delay for a specified period */
        /* push time to stack */
        MOVE.L #100, -(%SP)
        jsr Delay
        /* clean up stack */
        ADDA.L #4, %SP

        /* turn of led */
        jsr TurnOffLed

        /* delay for a specified period */
        /* push time to stack */
        MOVE.L #100, -(%SP)
        jsr Delay
        /* clean up stack */
        ADDA.L #4, %SP

    not_lit:
        ADD.L #1, %d2 /* increment column value */
        SUB.B #1, %d4 /* decrement the bit */
        CMPI.L #8, %d2 /* check if less than 8 */
        BLT loop_column /* if less than 8 loop again */

        ADD.L #1, %d3 /* increment the row */
        MOVE.B #7, %d4
        CMPI.L #8, %d3 /* check if the row is less than 8 */
        ADDA.L #1 %a2 /* increment the address to the next row */
        BLT loop_row /* if less than 8 keep looping */
        BRA exit

exit:
    MOVEM.L (%SP), %d2-%d4/%a2 /* restore the registers */
    ADDA.L #16, %SP /* return the stack pointer to return address */
rts 
/*End of Subroutine **************************************************/ 
.data
/*All Strings placed here **************************************************/



/*End of Strings **************************************************/
/******************************************************/
