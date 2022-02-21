# Biju's Hell

- ##### Ion- Irinel Dinu 

## Archive Content
* files implemented in assembly language
* README.md -> contains details about the structure and implementation


### Task 1 - Sort albums
-------------------------------------------------- -----------------------
In this task we approached the following solution. I went through each one
number from 1 to n, we looked up the number in the node vector and for each
number found we are looking for the consecutive number that follows after this. If
in which I found the consecutive number, I made the connection of the pointer next to
the previous element to the consecutive element. The iteration continues until
when all the connections are made for the elements to be traversed in
way out. At the end I looked for the node that contains the value 1 and I updated
the head of the list with this node.

### Task 2 - Turing's Nightmare
-------------------------------------------------- -------------------

#### CMMMC

In this task we used the following calculation formula:
** a⋅b = cmmdc (a, b) ⋅cmmmc (a, b) **
To solve this, we used Euclid's algorithm with repeated decreases for
determine the greatest common divisor. Then I determined the smallest
common multiple dividing the product of the two numbers by gcf In the task
the elements are added on the stack so as not to modify them, the cmmdc is calculated
using repeated decreases. If the order of the elements is not correct, it is
exchange using stack. Finally, the product is distributed to those
two numbers to cmmdc and the desired result is saved in the eax register.

#### Parentheses

To solve this task I chose to use a counter to keep
evidence of parentheses. Iterates through the string transmitted as a parameter again
if the current character is an open parenthesis the counter increases with
value 1. If the current character is a closed parenthesis
the counter decreases by 1. At the end of the program it is checked if the counter
is 0, in which case the sequence is the correct parenthesis, and I return the value in the axis
1. Otherwise the sequence is invalid and the eax register will have a value of 0. I tried
also the case where a closed parenthesis can be encountered before a
open parentheses, this represents an invalid sequence of parentheses.

### Task 3 - Word sort
-------------------------------------------------- -------------------
In this task we used a series of functions taken from the library
libc din C: ** qsort, strtok, strlen, strcmp. **
For the sorting part, I took over the arguments sent through the stack,
and then I added the necessary arguments to the qsort function call. Because qsort
use a comparison function I chose to implement this function.
I added the elements on the stack for the strcmp function and then I determined
the length of each string using the string function. If the two strings have
the same length I called the strcmp function. Otherwise the items are released from
the stack frame and the return is made.
For the part of separating words based on delimiters I used
functia strtok. I added the items on the stack for the function call, I have
determined the first word I added in the final array and then I
repeated the process for words that were not delimited, thus obtaining
the array that contains the separate words.


### Task Bonus - 64 bonus
In this task we determined the final array by going through each one
secondary array. As long as both arrays have elements, I've added mod
alternately elements from the first and second arrays, respectively. In case of
when one array has no more elements, all the elements in the other are added
array in the final array of elements.
